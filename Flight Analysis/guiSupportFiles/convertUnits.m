% The purpose of this function is to convert all measured quantities to
% units. The purpose is not to set it up in state form, ie, no need to
% rotate magnetometer into body axes, or calculate wind angles. This
% shouldn't add any fields to the structure, so we can simply copy the old
% to the new then replace.

function output = convertUnits(input)
output = input;

rpmThreshold = 1000;

zeroOffSet=0; %TEMPORARY

%% Pressure
% remove zero offset here
%todo:calc this
output.press0.noise = .1;
output.press1.noise = .1;
output.press2.noise = .1;
output.press3.noise = .1;

% scale

%% Gyro
% remove zero offet here. while doing this, grab RMS of zero data for noise
% settings.

output.gyroX.noise = .01;
output.gyroY.noise = .01;
output.gyroZ.noise = .01;

%now scale
output.gyroX.data = (input.gyroX.data-zeroOffSet)/14.375; %todo:everywhere you convert to real units use calibration data
output.gyroY.data = (input.gyroY.data-zeroOffSet)/14.375;
output.gyroZ.data = (input.gyroZ.data-zeroOffSet)/14.375;

% now rotate to match body axes

%% Accel
% remove zero offet here. while doing this, grab RMS of zero data for noise
% settings.

% now scale
output.accelX.data = 0.1*input.accelX.data;
output.accelY.data = 0.1*input.accelY.data;
output.accelZ.data = 0.1*input.accelZ.data;

output.accelX.noise = 0.1;
output.accelY.noise = 0.1;
output.accelZ.noise = 0.1;

%% Mag hmr2300
% calibrate magnetometer for hard iron and soft iron. while doing this, grab RMS of zero data for noise
% settings.

%translate bits to angles
%todo: this is the cos of the angle, need to do acos
for i=1:length(input.magX.data)
    output.ang2300X.data(i) = input.magX.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
    output.ang2300Y.data(i) = input.magY.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
    output.ang2300Z.data(i) = input.magZ.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
end
output.ang2300X.units = 'deg';
output.ang2300Y.units = 'deg';
output.ang2300Z.units = 'deg';

output.ang2300X.noise = .1;
output.ang2300Y.noise = .1;
output.ang2300Z.noise = .1;

%% Mag hmc5883L
% calibrate magnetometer for hard iron and soft iron. while doing this, grab RMS of zero data for noise
% settings.

%translate bits to angles - todo:when working, change this to data from the
%HMC5883L

%todo: this is the cos of the angle, need to do acos

for i=1:length(input.magX.data)
    output.ang5883X.data(i) = input.magX.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
    output.ang5883Y.data(i) = input.magY.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
    output.ang5883Z.data(i) = input.magZ.data(i)/norm(double([input.magX.data(i) input.magY.data(i) input.magZ.data(i)]));
end
output.ang5883X.units = 'deg';
output.ang5883Y.units = 'deg';
output.ang5883Z.units = 'deg';

output.ang5883X.noise = .1;
output.ang5883Y.noise = .1;
output.ang5883Z.noise = .1;

%% GPS
validGPS = input.gpsLat.data~=0;
gpsLat = double(input.gpsLat.data(validGPS))/10000000;
gpsLong = double(input.gpsLong.data(validGPS))/10000000;
degLat = floor(gpsLat);
degLong = floor(gpsLong);
minLat = 100*(gpsLat - degLat);
minLong = 100*(gpsLong - degLong);
minLatInt = floor(minLat);
minLongInt = floor(minLong);
secLat = 60*(minLat - minLatInt);
secLong = 60*(minLong - minLongInt);
if minLongInt == 60
    degLong = degLong+1;
    minLongInt = zeros(size(minLongInt));
end
if strcmpi(input.ewInd.data(1),'w') %assume we're not crossing prime meridian
    output.gpsLong.data = dms2degrees([-degLong minLongInt secLong]);
else
    output.gpsLong.data = dms2degrees([degLong minLongInt secLong]);
end

if strcmpi(input.nsInd.data(1),'n')
    output.gpsLat.data = dms2degrees([degLat minLatInt secLat]);
else
    output.gpsLat.data = dms2degrees([degLat minLatInt secLat]);
end

% convert gps utcTime, gpsSpd and gpsCrs into real values
output.utcTime.data = double(input.utcTime.data(validGPS))/100;
output.gpsSpd.data = double(input.gpsSpd.data(validGPS))*1.68781/1000; %convert to ft/s from kts
output.gpsCrs.data = double(input.gpsCrs.data(validGPS))/1000;