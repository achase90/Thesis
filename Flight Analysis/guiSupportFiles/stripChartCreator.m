function stripChartCreator(hObject,eventdata,handles)
if ~exist(handles.stripSaveDir,'dir')
    mkdir(handles.stripSaveDir)
end

if exist([handles.stripSaveDir '\sampleOutput.tex'],'file')==2
    fid = fopen([handles.stripSaveDir '\sampleOutput.tex'],'w');
    fclose(fid);
end

fid = fopen([handles.stripSaveDir '\sampleOutput.tex'],'a');
fprintf(fid,'\\chapter{Sample System Ouputs}\r\n');
fprintf(fid,'Below are charts of all measured signals versus time for a sample flight test.\r\n');

[type] = getDataType(handles);
fields = fieldnames(handles.data.(type));
f=figure('visible','off','paperunits','inches','paperposition',[0 0 6 3]);
hhh=axes;
for i=1:numel(fields)
    if ~strcmp(fields{i},'time') && ~strcmp(fields{i},'utcTime')
        if isnumeric(handles.data.(type).(fields{i}).data)
            if length(handles.data.(type).time.data)==length(handles.data.(type).(fields{i}).data)
                plot(hhh,handles.data.time.data,handles.data.(type).(fields{i}).data)
                xlabel(hhh,'Time [sec]');
            else
                if ~strcmp(fields{i},'utcTime')
                    try %assume they didn't match lengths because it was GPS
                        plot(hhh,handles.data.(type).utcTime.data,handles.data.(type).(fields{i}).data)
                        xlabel(hhh,'GPS Time [sec]');
                    catch
                        %                     str=sprintf();
                        warning('Vector lengths did not match for variable ''%s'', and attempted GPS resolution failed.',fields{i});
                    end
                end
            end
            ylabel(hhh,[fields{i} ' [' handles.data.(type).(fields{i}).units ']']);
            saveas(f,[handles.stripSaveDir '\' fields{i},'.eps'],'epsc')
            writeLatexFigure(fid,handles.stripSaveDir,fields{i})
        end
    end
end
set(handles.outputText,'String',['Strip chart files saved to ' handles.stripSaveDir])
fclose(fid)