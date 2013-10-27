function stripChartCreator(hObject,eventdata,handles)
if ~exist(handles.stripSaveDir,'dir')
    mkdir(handles.stripSaveDir)
end

fields = fieldnames(handles.data);
f=figure('visible','off');
hhh=axes;
for i=1:numel(fields)
    if ~strcmp(fields{i},'time') && ~strcmp(fields{i},'utcTime')
        if isnumeric(handles.data.(fields{i}).data)
            if length(handles.data.time.data)==length(handles.data.(fields{i}).data)
                plot(hhh,handles.data.time.data,handles.data.(fields{i}).data)
                xlabel(hhh,'Time [sec]');
            else
                if ~strcmp(fields{i},'utcTime')
                    try %assume they didn't match lengths because it was GPS
                        plot(hhh,handles.data.utcTime.data,handles.data.(fields{i}).data)
                        xlabel(hhh,'GPS Time [sec]');
                    catch
                        %                     str=sprintf();
                        warning('Vector lengths did not match for variable ''%s'', and attempted GPS resolution failed.',fields{i});
                    end
                end
            end
            ylabel(hhh,[fields{i} ' [' handles.data.(fields{i}).units ']']);
            saveas(hhh,[handles.stripSaveDir '\' fields{i},'.eps'],'epsc')
        end
    end
end
set(handles.outputText,'String',['Strip chart files saved to ' handles.stripSaveDir])