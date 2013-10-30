function handleOut = convertUnits(handles)
rpmThreshold = 1000;

handleOut = handles;
output=handles.data;
input=handles.data;

zeroOffSet=0; %TEMPORARY
%% Pressure

%% Air Angles
[output.alpha.data,output.beta.data] = pressureToAngles(input);
output.alpha.units = 'deg';
output.beta.units = 'beta';

%% Gyro
% assume gyro is lined up with accelerometer

% apply rotation matrix to gyro to line up readings with roll/pitch/yaw
%about gravity

output.gyroX.data = (input.gyroX.data-zeroOffSet)/14.375; %todo:everywhere you convert to real units use calibration data
output.gyroY.data = (input.gyroY.data-zeroOffSet)/14.375;
output.gyroZ.data = (input.gyroZ.data-zeroOffSet)/14.375;

%% Accel
output.accelX.data = 0.1*(input.accelX.data-zeroOffSet);
output.accelY.data = 0.1*(input.accelY.data-zeroOffSet);
output.accelZ.data = 0.1*(input.accelZ.data-zeroOffSet);

%% Mag to Euler
% calibrate magnetometer for hard iron and soft iron

% with airplane sitting on ground, use rotation matrix to align magnetometer
%with accelerometer.

% assume gyro is lined up with accelerometer -> lined up with magnetometer

% correlate gyro axes to magnetometer axes for kalman filter (is magX ==
%gyroX?)

%translate bits to angles
for i=1:length(input.magX.data)
    output.ang1.data(i) = input.magX.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
    output.ang2.data(i) = input.magY.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
    output.ang3.data(i) = input.magZ.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
end
    output.ang1.units = 'deg';
    output.ang2.units = 'deg';
    output.ang3.units = 'deg';
    
%% GPS
validGPS = input.gpsLat.data~=0;
input.gpsLat.data = double(input.gpsLat.data(validGPS))/10000000;
input.gpsLong.data = double(input.gpsLong.data(validGPS))/10000000;
degLat = floor(input.gpsLat.data);
degLong = floor(input.gpsLong.data);
minLat = 100*(input.gpsLat.data - degLat);
minLong = 100*(input.gpsLong.data - degLong);
minLatInt = floor(minLat);
minLongInt = floor(minLong);
secLat = 60*(minLat - minLatInt);
secLong = 60*(minLong - minLongInt);
if minLongInt == 60
    degLong = degLong+1;
    minLongInt = zeros(size(minLongInt));
end
if strcmpi(handles.data.ewInd.data(1),'w') %assume we're not crossing prime meridian
    output.gpsLong.data = dms2degrees([-degLong minLongInt secLong]);
else
    output.gpsLong.data = dms2degrees([degLong minLongInt secLong]);
end

if strcmpi(handles.data.nsInd.data(1),'n')
    output.gpsLat.data = dms2degrees([degLat minLatInt secLat]);
else
    output.gpsLat.data = dms2degrees([degLat minLatInt secLat]);
end

%% convert gps utcTime, gpsSpd and gpsCrs into real values
output.utcTime.data = double(input.utcTime.data(validGPS))/100;
output.gpsSpd.data = double(input.gpsSpd.data(validGPS))*1.68781/1000; %convert to ft/s from kts
output.gpsCrs.data = double(input.gpsCrs.data(validGPS))/1000;

%% Second Mag?

%% RPM
output.hasThrust.data = output.rpm.data>rpmThreshold;
%% Clean up
handleOut.data = output;