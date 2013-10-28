function fileSaveFun(handles)
if strcmp(class(handles.fileName),'char') && strcmp(class(handles.filePath),'char')
    [fileSaveName,filePathName] = uiputfile('.fdr');
    if strcmp(class(fileSaveName),'char') && strcmp(class(filePathName),'char')
        
        handles.fullFileSavePath = [filePathName fileSaveName];
        %todo:just use a struct fun. dumbass
        cellData = struct2cell(handles.data);
        fid = fopen(handles.fullFileSavePath,'w');
        for i=1:length(cellData{1,:}.data)
            output = cellfun(@(x) x.data(i), cellData,'UniformOutput',false);
            if i==29
                keyboard
            end
            %todo:fix fields.
            fprintf(fid,'%u\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%c\t%c\t%c\t%c\t%c\t%u\t%c\t%d\t%c\t%d\t%c\t%d\t%d\t%u\t%c\t%u\t%d\t%u\t%u\n',output{:});
        end
        fclose(fid);
        
    end
else
    set(handles.outputText,'String','Please load data before saving data.');
end
