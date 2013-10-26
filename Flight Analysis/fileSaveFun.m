function fileSaveFun(handles)

cellData = struct2cell(handles.data);
fid = fopen(handles.fullFileSavePath,'w');
for i=1:length(cellData{1,:})
    output = cellfun(@(x) x(i), cellData,'UniformOutput',false);
    fprintf(fid,'%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%c\t%c\t%c\t%c\t%c\t%d\t%c\t%d\t%c\t%d\t%c\t%d\t%d\t%c\t%d\t%d\t%d\t%d\n',output{:});
end
fclose(fid);