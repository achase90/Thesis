clear all
%# type and size in byte of the record fields
            % time    accelx   accely  accelz  gyrox   gyroy   gyroz   magx    magy    magz   press1 press2 press3 press4   gps deltaT
% recordType = {'ulong' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'char' 'char' 'char' 'char' 'char' 'uint32' 'char' 'int32' 'char' 'int32' 'char' 'int32' 'int32' 'uint32' 'char' 'uint32' 'ulong'};
% recordLen = [   4       2        2       2      2        2        2      2       2       2       2       2      1      1       1      1      1      4       1       4       1       4       1      4       4       4       1       4       4];
recordType = {'ulong' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'char' 'char' 'char' 'char' 'char' 'uint32' 'char' 'int32' 'char' 'int32' 'char' 'int32' 'int32' 'char' 'uint32'  'uint32' 'int16' 'uint32'};
recordLen = [   4       2        2       2      2        2        2      2       2       2       2       2      1      1       1      1      1      4        1      4       1     4        1      4       4       1       4         4        2      4];
%copyfile('G:\DATALOG.TXT',cd);
R = cell(1,numel(recordType));

%# read column-by-column
fid = fopen('17053207.txt','rb');
for i=1:numel(recordType)
    %# seek to the first field of the first record
    fseek(fid, sum(recordLen(1:i-1)), 'bof');

    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' recordType{i}], sum(recordLen)-recordLen(i));
end
fclose(fid);
%delete('DATALOG.TXT');

delete('G:\DATALOG.TXT');
