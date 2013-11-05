function [data] = fileToStruct(input)
headers = {'time' 'accelX' 'accelY' 'accelZ' 'gyroX' 'gyroY' 'gyroZ' ...
    'magX'   'magY'  'magZ' 'press0' 'press1' 'press2' 'press3' 'msgid1'...
    'msgid2' 'msgid3' 'msgid4' 'msgid5' 'utcTime' 'gpsStatus' 'gpsLat' ...
    'nsInd' 'gpsLong' 'ewInd' 'gpsSpd' 'gpsCrs' 'date'  'gpsMode'     'CS'  ...
    'temperature'   'deltaT'  'rpmPwm'};


units = {'sec' 'ft/s^2' 'ft/s^2' 'ft/s^2' 'deg/s' 'deg/s' 'deg/s' ...
    'bits'   'bits'  'bits' 'lb/ft^2' 'lb/ft^2' 'lb/ft^2' 'lb/ft^2' '-'...
    '-' '-' '-' '-' '??' '-' 'deg' ...
    '-' 'deg' '-' 'ft/s' 'deg' '??'  '-'     '-'  ...
    'degF'   'sec' 'usec'};

for i=1:length(headers)
    data.(headers{i})=[];
    data.(headers{i}).data=[];
    data.(headers{i}).units=[];
end

if isstruct(input)
    for i=1:length(headers)
        data.(headers{i}) = input(:,i);
        data.(headers{i}).units = units{i};
    end
elseif iscell(input);
    for i=1:length(headers)
        data.(headers{i}).data = cell2mat(input(:,i));
        data.(headers{i}).units = units{i};
    end
end
