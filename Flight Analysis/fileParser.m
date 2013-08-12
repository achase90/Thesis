function [data] = fileParser(filename)
%# type and size in byte of the record fields

recordType = {'ulong' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'int16' 'char' 'char' 'char' 'char' 'char' 'uint32' 'char' 'int32' 'char' 'int32' 'char' 'int32' 'int32' 'char' 'uint32'  'uint32' 'int16' 'uint32'};
recordLen = [   4       2        2       2      2        2        2      2       2       2       2       2      1      1       1      1      1      4        1      4       1     4        1      4       4       1       4         4        2      4];

R = cell(1,numel(recordType));

%# read column-by-column
fid = fopen(filename,'rb');
for i=1:numel(recordType)
    %# seek to the first field of the first record
    fseek(fid, sum(recordLen(1:i-1)), 'bof');

    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' recordType{i}], sum(recordLen)-recordLen(i));
end
fclose(fid);

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

%% gravity
data.gravity = 32.2;

%% weight
data.W = weight;

%% combine msgID fields into one msgID
data.msgID=[data.msgID1 data.msgID2 data.msgID3 data.msgID4 data.msgID5];
data=rmfield(data,{'msgID1' 'msgID2' 'msgID3' 'msgID4' 'msgID5'});

%% combine accels into one field
data.accel = [data.accelX data.accelY data.accelZ];
%remove unnecessary fields
data=rmfield(data,{'accelX','accelY','accelZ'});

%% combine gyros into one field
data.eulerRates = [data.gyroX data.gyroY data.gyroZ];
%remove unnecessary fields
data=rmfield(data,{'gyroX','gyroY','gyroZ'});

%% parse gps lat and long
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

%% convert gps utcTime, gpsSpd and gpsCrs into real values
data.utcTime = double(data.utcTime(validGPS))/100;
data.gpsSpd = double(data.gpsSpd(validGPS))*1.68781/1000; %convert to ft/s from kts
data.gpsCrs = double(data.gpsCrs(validGPS))/1000;

%% calculate density
Rgas = 1716; %ft-lb/(slug degR)

%make sure P is in the correct units (psf)
data.rho = P/(Rgas*(temperature+459.67)); %use temperature in fahrenheit and convert to rankine

%rename qbar term CHECK UNITS
data.qbar = Pinf;

%% Build windAngles CONVERT TO RADIANS and get rid of bank angle
[alpha,beta] = pressureToAngles(data);
data.windAngles=[alpha beta];

%% create "thrust" data
kk = length(data.accel);
data.fThrust=zeros(kk,3); %assume gliding flight

%% plane wing area
plane.Sref = wingArea;