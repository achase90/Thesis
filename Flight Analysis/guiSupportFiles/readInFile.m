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
    input = dlmread(filename, delimiter);
    [handles.data.Raw] = fileToStruct(input);
end