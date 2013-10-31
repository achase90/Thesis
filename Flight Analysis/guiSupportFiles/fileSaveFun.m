function fileSaveFun(handles)
if ischar(handles.fileName) && ischar(handles.filePath)
    [fileSaveName,filePathName] = uiputfile('.fdr');
    if ischar(fileSaveName) && ischar(filePathName)
        handles.fullFileSavePath = [filePathName fileSaveName];
        fid = fopen(handles.fullFileSavePath,'w');
fn = fieldnames(handles.data);
        for i=1:length(handles.data.(fn{1}).data)
% it's fuck-this-shit-o-clock, deal with this later, and don't save files
% for now.

%             output = cellfun(@(x) x.data.(type)(i), cellData,'UniformOutput',false);
%             fprintf(fid,'%u\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%c\t%c\t%c\t%c\t%c\t%u\t%c\t%d\t%c\t%d\t%c\t%d\t%d\t%u\t%c\t%u\t%d\t%u\t%u\n',output{:});
        end
warning('not saving files, because you''re a pussy that doesn''t want to deal with cellfuns of structfuns.');
        fclose(fid);
        
    end
else
    set(handles.outputText,'String','Please load data before saving data.');
end
