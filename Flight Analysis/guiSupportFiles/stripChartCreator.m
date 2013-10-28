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


fields = fieldnames(handles.data);
f=figure('visible','off','paperunits','inches','paperposition',[0 0 6 3]);
hhh=axes;
for i=1:numel(fields)
    if ~strcmp(fields{i},'time') && ~strcmp(fields{i},'utcTime')
        if isnumeric(handles.data.(fields{i}).data)
            if length(handles.data.time.data)==length(handles.data.(fields{i}).data)
                plot(hhh,handles.data.time.data,handles.data.(fields{i}).data)
%                 curPos = get(hhh,'position');
%                 set(hhh,'position',[curPos(1:2) 640 320]);
                xlabel(hhh,'Time [sec]');
            else
                if ~strcmp(fields{i},'utcTime')
                    try %assume they didn't match lengths because it was GPS
                        plot(hhh,handles.data.utcTime.data,handles.data.(fields{i}).data)
%                         curPos = get(hhh,'position');
%                         set(hhh,'position',[curPos(1:2) 640 320]);
                        xlabel(hhh,'GPS Time [sec]');
                    catch
                        %                     str=sprintf();
                        warning('Vector lengths did not match for variable ''%s'', and attempted GPS resolution failed.',fields{i});
                    end
                end
            end
            ylabel(hhh,[fields{i} ' [' handles.data.(fields{i}).units ']']);
            saveas(f,[handles.stripSaveDir '\' fields{i},'.eps'],'epsc')
            writeLatexFigure(fid,handles.stripSaveDir,fields{i})
        end
    end
end
set(handles.outputText,'String',['Strip chart files saved to ' handles.stripSaveDir])
fclose(fid)