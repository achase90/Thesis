function [R] = parseBinary(filepath)
% %recordType = {'time' 'accelX' 'accelY' 'accelZ' 'gyroX' 'gyroY' 'gyroZ' 'magX'   'magY'  'magZ' 'press0' 'press1' 'press2' 'press3' 'msgid1' 'msgid2' 'msgid3' 'msgid4' 'msgid5' 'utcTime' 'gpsStatus' 'gpsLat' 'nsInd' 'gpsLong' 'ewInd' 'gpsSpd' 'gpsCrs'   'date'   'mode'     'CS'   'temperature'   'deltaT'};
%  recordType = {'ulong' 'int16'  'int16'  'int16' 'int16' 'int16' 'int16' 'int16'  'int16' 'int16' 'int16'  'int16'  'int16'  'int16' 'char'    'char'   'char'   'char'  'char'    'uint32'    'char'    'int32'  'char'   'int32'  'char'  'int32' 'int32'  'uint32'   'char'  'uint32'    'int16'     'uint32'};
%  recordLen = [   4       2        2         2        2      2        2      2       2       2       2         2        2        2       1         1       1         1       1          4         1           4      1         4       1        4       4          4       1          4           2            4];

 
%recordType = {'time' 'accelX' 'accelY' 'accelZ' 'gyroX' 'gyroY' 'gyroZ' 'magX'   'magY'  'magZ'   'hmcX'      'hmcZ'     'hmcY'   'press0' 'press1' 'press2' 'press3' 'msgid1' 'msgid2' 'msgid3' 'msgid4' 'msgid5' 'utcTime' 'gpsStatus' 'gpsLat' 'nsInd' 'gpsLong' 'ewInd' 'gpsSpd' 'gpsCrs'   'date'   'mode'     'CS'      'temperature'   'pwm0'   'pwm0'      'pwm0'    'pwm0'     'pwm0'     'pwm0'     'pwm0'     'pwm0'     'deltaT'};
 recordType = {'ulong' 'int16'  'int16'  'int16' 'int16' 'int16' 'int16' 'int16'  'int16' 'int16'  'int16'    'int16'    'int16'    'int16'  'int16'  'int16'  'int16' 'char'    'char'   'char'   'char'  'char'    'uint32'    'char'    'int32'  'char'   'int32'  'char'  'int32' 'int32'  'uint32'   'char'  'uint32'       'int16'      'uint32'  'uint32'   'uint32'   'uint32'   'uint32'   'uint32'   'uint32'   'uint32'   'uint32'};
 recordLen = [   4       2        2         2        2      2        2      2       2       2        2           2          2           2         2        2        2       1         1       1         1       1          4         1           4      1         4       1        4       4          4       1          4           2            4         4           4       4           4           4           4       4           4];

 
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