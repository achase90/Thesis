clear all
%# type and size in byte of the record fields
recordType = {'int32' 'long' 'ulong'};
recordLen = [4 4 4];
R = cell(1,numel(recordType));

%# read column-by-column
fid = fopen('DATALOG.txt','rb');
for i=1:numel(recordType)
    %# seek to the first field of the first record
    fseek(fid, sum(recordLen(1:i-1)), 'bof');

    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' recordType{i}], sum(recordLen)-recordLen(i));
end
fclose(fid);
