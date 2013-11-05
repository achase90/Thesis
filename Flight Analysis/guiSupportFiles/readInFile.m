function [handles] = readInFile(handles)

handles.fullFilePath = [handles.filePath handles.fileName];

binaryFile = isFileBinary(handles.fullFilePath);
if binaryFile
    input = parseBinary(handles.fullFilePath);
    [handles.data.Raw] = fileToStruct(input);
    answer = questdlg('Save ASCII data file?');
    if strcmpi(answer,'yes');
        fileSaveFun(handles);
    end
else
    fid = fopen(handles.fullFilePath,'r');
    input = textscan(fid,'%u %d %d %d %d %d %d %d %d %d %d %d %d %d %c %c %c %c %c %u %c %d %c %d %c %d %d %u %c %u %d %u %u','Delimiter','\t');
    fclose(fid);
    [handles.data.Raw] = fileToStruct(input);
end