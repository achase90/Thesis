function handleOut = convertUnits(handles)
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
output.gyroX.data = (input.gyroX.data-zeroOffSet)/14.375; %todo:everywhere you convert to real units use calibration data
output.gyroY.data = (input.gyroY.data-zeroOffSet)/14.375;
output.gyroZ.data = (input.gyroZ.data-zeroOffSet)/14.375;

%% Accel
output.accelX.data = 0.1*(input.accelX.data-zeroOffSet);
output.accelY.data = 0.1*(input.accelY.data-zeroOffSet);
output.accelZ.data = 0.1*(input.accelZ.data-zeroOffSet);

%% Mag to Euler
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
output.gpsLat.data = dms2degrees([degLat minLatInt secLat]);
output.gpsLong.data = dms2degrees([degLong minLongInt secLong]);

%% convert gps utcTime, gpsSpd and gpsCrs into real values
output.utcTime.data = double(input.utcTime.data(validGPS))/100;
output.gpsSpd.data = double(input.gpsSpd.data(validGPS))*1.68781/1000; %convert to ft/s from kts
output.gpsCrs.data = double(input.gpsCrs.data(validGPS))/1000;

%% Second Mag?

%% RPM

%% Clean up
handleOut.data = output;