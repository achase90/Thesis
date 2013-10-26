function stripChartCreator(hObject,eventdata,handles)
savePath = [handles.filePath handles.fileName];
periodLoc = strfind(handles.fileName, '.');
if ~exist(handles.fileName(1:periodLoc(1)-1),'dir')
    mkdir(handles.fileName(1:periodLoc(1)-1))
end
newDir = handles.fileName(1:periodLoc(1)-1);

fields = fieldnames(handles.data);
f=figure('visible','off');
hhh=axes;
for i=1:numel(fields)
    if ~strcmp(fields{i},'time')
        if isnumeric(handles.data.(fields{i}).data)
            if length(handles.data.time.data)==length(handles.data.(fields{i}).data)
                plot(hhh,handles.data.time.data,handles.data.(fields{i}).data)
                xlabel('Time [sec]');
            else
                if ~strcmp(fields{i},'utcTime')
                    try %assume they didn't match lengths because it was GPS
                        plot(hhh,handles.data.utcTime.data,handles.data.(fields{i}).data)
                        xlabel('GPS Time [sec]');
                    catch
                        %                     str=sprintf();
                        warning('Vector lengths did not match for variable ''%s'', and attempted GPS resolution failed.',fields{i});
                    end
                end
            end
            ylabel([fields{i} ' [' handles.data.(fields{i}).units ']']);
            saveas(hhh,[newDir '\' fields{i},'.eps'],'epsc')
        end
    end
end
set(handles.outputText,'String',['Strip chart files saved to ' handles.filePath newDir])