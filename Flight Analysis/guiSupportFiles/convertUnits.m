% The purpose of this function is to convert all measured quantities to
% units. The purpose is not to set it up in state form, ie, no need to
% rotate magnetometer into body axes, or calculate wind angles. This
% shouldn't add any fields to the structure, so we can simply copy the old
% to the new then replace.


% todo: make sure the unit structure is correct. probably need to
% completely update it
function output = convertUnits(input)
%convert all data to doubles
[input] = dataToDouble(input);
%todo:remove all conversions to double in every file except this one.
output = input; %copy input structure to output, since it's largely the same
output.time.data = output.time.data/1e3;

%% Pressure and temperature
scaleD = 10; %todo:calc this
scaleB = 10; %todo:calc this
barMeasured = 1000; %todo: add an input box for atmospheric pressure and temperature
tMeasured = 70;

[PressCalibFile,PressCalibPath] = uigetfile('*.clb','Select pressure calibration file');
if ischar(PressCalibFile)
    %read in calib file
    M = dlmread([PressCalibPath PressCalibFile],'\t',2,0);
    
% calc zero offset
zero1 = mean(M(:,1));
zero2 = mean(M(:,2));
zero3 = mean(M(:,3));
barZero = mean(M(:,4));
tZero = mean(M(:,5));

% scale and remove zero offset
output.press0.data = scaleD*(input.press0.data-zero1);
output.press1.data = scaleD*(input.press0.data-zero2);
output.press2.data = scaleD*(input.press0.data-zero3);
%scale barometric pressure then add zero offset to match known initial pressure
output.press3.data = scaleB*input.press0.data-(barZero-barMeasured); 
%scale temperature then add zero offset to match known initial temperature
%todo: convert from 1000*degF to degF
output.temperature.data = output.temperature.data-(tZero-tMeasured);

% set noise values
output.press0.noise = std(M(:,1)-zero1);
output.press1.noise = std(M(:,2)-zero2);
output.press2.noise = std(M(:,3)-zero3);
output.press3.noise = std(M(:,4)-barZero);
output.temperature.noise = std(M(:,5)-tZero);
else
        warning('No pressure calibration file selected. No calibration will be performed, and noise will be set to zero.');
output.press0.noise = 0;
output.press1.noise = 0;
output.press2.noise = 0;
output.press3.noise = 0;
output.temperature.noise = 0;
end

%% Accelerometer and Gyroscope

[accelGyroCalibFile,accelGyroCalibPath] = uigetfile('*.clb','Select accelerometer/gyroscope calibration file');
if ischar(accelGyroCalibFile)
    % find slope and zero offsets
    M = dlmread([accelGyroCalibPath accelGyroCalibFile],'\t',2,0);
    [bitsToFTSS,rmsAccel] = accelCalib(M);
    
% apply scale and zero offset corrections to accel
output.accelX.data = input.accelX.data*bitsToFTSS(1)+bitsToFTSS(4);
output.accelY.data = input.accelY.data*bitsToFTSS(2)+bitsToFTSS(5);
output.accelZ.data = input.accelZ.data*bitsToFTSS(3)+bitsToFTSS(6);

% apply scale and zero offset corrections to gyro
scale = 1/14.375; %todo: calibrate this
gyroXZero = mean(M(:,5));
gyroYZero = mean(M(:,6));
gyroZZero = mean(M(:,7));
output.gyroX.data = scale*(input.gyroX.data-gyroXZero);
output.gyroY.data = scale*(input.gyroY.data-gyroYZero);
output.gyroZ.data = scale*(input.gyroZ.data-gyroZZero);

% set units
output.accelX.units = 'ft/s^2';
output.accelY.units = 'ft/s^2';
output.accelZ.units = 'ft/s^2';
output.gyroX.units = 'deg/s';
output.gyroY.units = 'deg/s';
output.gyroZ.units = 'deg/s';

%set noise values %todo:what are units? what should they be?
% can we take each section, after scaling, and take noise as
% (sstd(x-mean(x)), which would give units of ft/s/s/
output.accelX.noise = rmsAccel;
output.accelY.noise = rmsAccel;
output.accelZ.noise = rmsAccel;

output.gyroX.noise = scale*std(M(:,5)); %gyro noise units are in deg/s, this should be correct
output.gyroY.noise = scale*std(M(:,6));
output.gyroZ.noise = scale*std(M(:,7));
else
    warning('No accelerometer/gyro calibration file selected. No calibration will be performed, and noise will be set to zero.');
output.accelX.noise = 0;
output.accelY.noise = 0;
output.accelZ.noise = 0;
output.gyroX.noise = 0;
output.gyroY.noise = 0;
output.gyroZ.noise = 0;
end

%% Magnetometers
%build matrices
HMR2300 = [input.magX.data input.magY.data input.magZ.data];
HMC5883 = [input.hmcX.data input.hmcY.data input.hmcZ.data];

% load calibration file
[magCalibFile,magCalibPath] = uigetfile('*.clb','Select magnetometer calibration file');
if ischar(magCalibFile)
[HMR2300,HMC5883,MHmrToHmc,rmsHMR2300,rmsHMC5883] = calibMags(HMR2300,HMC5883,[magCalibPath magCalibFile]);
else
    warning('No magnetometer calibration file selected. No calibration will be performed, and noise will be set to zero.');
rmsHMR2300 = 0;
rmsHMC5883 = 0;
end
    HMR2300 = bitsToAngs(HMR2300);
output.magX.data = HMR2300(:,1);
output.magY.data = HMR2300(:,2);
output.magZ.data = HMR2300(:,3);
output.magX.units = 'rad';
output.magY.units = 'rad';
output.magZ.units = 'rad';
%todo:check units on noise. what should they be?
output.magX.noise = rmsHMR2300;
output.magY.noise = rmsHMR2300;
output.magZ.noise = rmsHMR2300;

HMC5883 = bitsToAngs(HMC5883);
output.hmcX.data = HMC5883(:,1);
output.hmcY.data = HMC5883(:,2);
output.hmcZ.data = HMC5883(:,3);
output.hmcX.units = 'rad';
output.hmcY.units = 'rad';
output.hmcZ.units = 'rad';
output.hmcX.noise = rmsHMC5883;
output.hmcY.noise = rmsHMC5883;
output.hmcZ.noise = rmsHMC5883;

%% GPS
validGPS = input.gpsStatus.data=='A';
gpsLat = double(input.gpsLat.data(validGPS))/10000000;
gpsLong = double(input.gpsLong.data(validGPS))/10000000;
nsInd = input.nsInd.data(validGPS);
ewInd = input.ewInd.data(validGPS);
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
if max(validGPS) %check if there's any valid gps data. if there is, use it
    for i=1:sum(validGPS)
        if strcmpi(ewInd(i),'W') %assume we're not crossing prime meridian
            degLong(i) = -degLong(i);
        
        end
        
        if strcmpi(nsInd(i),'S')
            degLat(i) = -degLat(i);
        end
        output.gpsLong.data = dms2degrees([degLong minLongInt secLong]);
        output.gpsLat.data = dms2degrees([degLat minLatInt secLat]);
    end
else %if there isn't valid gps data, set gps equal to zero
    output.gpsLat.data = zeros(size(input.gpsLat.data));
    output.gpsLong.data = zeros(size(input.gpsLong.data));
end
% convert gps utcTime, gpsSpd and gpsCrs into real values
output.utcTime.data = double(input.utcTime.data(validGPS))/100;
output.gpsSpd.data = double(input.gpsSpd.data(validGPS))*1.68781/1000; %convert to ft/s from kts
output.gpsCrs.data = double(input.gpsCrs.data(validGPS))/1000;