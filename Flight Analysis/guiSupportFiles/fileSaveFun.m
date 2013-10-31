function fileSaveFun(handles)
if ischar(handles.fileName) && ischar(handles.filePath)
    [fileSaveName,filePathName] = uiputfile('.fdr');
    if ischar(fileSaveName) && ischar(filePathName)
        handles.fullFileSavePath = [filePathName fileSaveName];
        fid = fopen(handles.fullFileSavePath,'w');
fn = fieldnames(handles.data);
cellData = struct2cell(handles.data.(fn{1}));
dn = fieldnames(handles.data.(fn{1}));
        for i=1:length(handles.data.(fn{1}).(dn{1}).data)

            output = cellfun(@(x) x.data(i), cellData,'UniformOutput',false);
            fprintf(fid,'%u\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%i\t%c\t%c\t%c\t%c\t%c\t%u\t%c\t%d\t%c\t%d\t%c\t%d\t%d\t%u\t%c\t%u\t%d\t%u\t%u\n',output{:});
        end
        fclose(fid);
        
    end
else
    set(handles.outputText,'String','Please load data before saving data.');
end
