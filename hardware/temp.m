clear all
%# type and size in byte of the record fields
            % time    accelx   accely  accelz  gyrox   gyroy   gyroz   magx    magy    magz   press1 press2 press3 press4   gps deltaT

recordType = {'ulong' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'uchar' 'uchar' 'uchar' 'uchar' 'uchar' 'uint32' 'uchar' 'int32' 'uchar' 'int32' 'uchar' 'int32' 'int32' 'uint32' 'uchar' 'uint32' 'ulong'};                                                     
recordLen = [4           2      2         2      2       2       2       2       2       2      2       2      2       2      1       1       1       1        1   4        1      4         1       4       1        4       4      4 1 4 4];
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
