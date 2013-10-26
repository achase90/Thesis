function stripChartCreator(hObject,eventdata,handles)
savePath = [handles.filePath handles.fileName];
periodLoc = strfind(handles.fileName, '.');
if ~exist(handles.fileName(1:periodLoc(1)),'dir')
    mkdir(handles.fileName(1:periodLoc(1)))
end
newDir = handles.fileName(1:periodLoc(1));

fields = fieldnames(handles.data);
f=figure('visible','off');
hhh=axes;
for i=1:numel(fields)
    if ~strcmp(fields{i},'time')
        if isnumeric(handles.data.(fields{i}))
            plot(hhh,handles.data.time,handles.data.(fields{i}))
            xlabel('Time [sec]');
            ylabel([fields{i} ' [' handles.units{i} ']']);
            saveas(hhh,[newDir '\' fields{i},'.eps'],'epsc')
        end
    end
end
set(handles.outputText,'String',['Strip chart files saved to ' savePath])