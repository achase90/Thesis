clear all
%# type and size in byte of the record fields
            % time    accelx   accely  accelz  gyrox   gyroy   gyroz   magx    magy    magz   press1 press2 press3 press4   gps deltaT

recordType = {'ulong' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'char' 'char' 'char' 'char' 'char' 'uint32' 'char' 'int32' 'char' 'int32' 'char' 'int32' 'int32' 'char' 'uint32'  'uint32' 'int16' 'uint32'};
recordLen = [   4       2        2       2      2        2        2      2       2       2       2       2      1      1       1      1      1      4        1      4       1     4        1      4       4       1       4         4        2      4];
% copyfile('G:\*',cd);
files=dir;
R = cell(1,numel(recordType));

%# read column-by-column
fid = fopen('21162443.txt','rb');
for i=1:numel(recordType)
    %# seek to the first field of the first record
    fseek(fid, sum(recordLen(1:i-1)), 'bof');

    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' recordType{i}], sum(recordLen)-recordLen(i));
end
fclose(fid);
%delete('DATALOG.TXT');

%delete('G:\*');
headers={'time' 'accelX' 'accelY' 'accelZ' 'gyroX' 'gyroY' 'gyroZ' 'magX' 'magY' 'magZ' ...
    'press0' 'press1' 'msgID1' 'msgID2' 'msgID3' 'msgID4' 'msgID5'...
    'utcTime' 'gpsStatus' 'gpsLat' 'nsInd' 'gpsLong' 'ewInd' 'gpsSpd' 'gpsCrs'...
    'date' 'mode' 'CS' 'temperature' 'deltaT'};
% svals=zeros(1,length(headers));
for i=1:length(headers)
data.(headers{i})=[];
end
for i=1:length(headers)
    data.(headers{i}) = cell2mat(R(:,i));
end
data.msgID=[data.msgID1 data.msgID2 data.msgID3 data.msgID4 data.msgID5];
data=rmfield(data,{'msgID1' 'msgID2' 'msgID3' 'msgID4' 'msgID5'});
validGPS = data.gpsLat~=0;
data.gpsLat = double(data.gpsLat(validGPS))/10000000;
data.gpsLong = double(data.gpsLong(validGPS))/10000000;
degLat = floor(data.gpsLat);
degLong = floor(data.gpsLong);
minLat = 100*(data.gpsLat - degLat);
minLong = 100*(data.gpsLong - degLong);
minLatInt = floor(minLat);
minLongInt = floor(minLong);
secLat = 60*(minLat - minLatInt);
secLong = 60*(minLong - minLongInt);
data.gpsLat = dms2degrees([degLat minLatInt secLat]);
data.gpsLong = dms2degrees([degLong minLongInt secLong]);
data.utcTime = double(data.utcTime(validGPS))/100;
data.gpsSpd = double(data.gpsSpd(validGPS))/1000;
data.gpsCrs = double(data.gpsCrs(validGPS))/1000;
kmlwrite('testGPS.kml',data.gpsLat,-data.gpsLong)