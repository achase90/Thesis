function [R] = parseData(filepath)
recordType = {'ulong' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'char' 'char' 'char' 'char' 'char' 'uint32' 'char' 'int32' 'char' 'int32' 'char' 'int32' 'int32' 'char' 'uint32'  'uint32' 'int16' 'uint32'};
recordLen = [   4       2        2       2      2        2        2      2       2       2       2       2      1      1       1      1      1      4        1      4       1     4        1      4       4       1       4         4        2      4];

R = cell(1,numel(recordType));

%# read column-by-column
fid = fopen(filepath,'rb');
for i=1:numel(recordType)
    %# seek to the first field of the first record
    fseek(fid, sum(recordLen(1:i-1)), 'bof');

    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' recordType{i}], sum(recordLen)-recordLen(i));
end
fclose(fid);