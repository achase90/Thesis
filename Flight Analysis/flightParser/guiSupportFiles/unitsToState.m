% the purpose of this function is to translate the measured, calibrated
% values, with units, from the IMU, and to convert them to values
% meaningful to the plant. This also includes translating the noise values 
% to plant values. This is where we align gyros/accels/mags/etc.

function [output] = unitsToState(input,adsR)

%% copying
%don't blindly copy input to output since we don't want most of the data in
%the input struct.
output.time = input.time;

%% Qbar and rho

output.qbar.data = input.press1.data;
output.qbar.units = 'lb/ft^2';
output.qbar.noise = input.press1.noise;

R = 1716; %universal gas constant %todo:check units on this, they're not right
output.rho.data = input.press3.data./(R*(input.temperature.data+459.67));

output.rho.noise = sqrt((input.press3.noise./(R*(input.temperature.data+459.67))).^2+((input.press3.data./(R*(input.temperature.data+459.67).^2)).*input.temperature.noise).^2);
output.rho.units = 'lb/ft^3';

output.vinf.data = sqrt(2*output.qbar.data./output.rho.data);
output.vinf.units = 'ft/s';
output.vinf.noise = sqrt((1./(output.rho.data.*output.vinf.data.^3).*output.rho.noise).^2+(output.qbar.data./(output.vinf.data.^3.*output.rho.data.^2).*output.qbar.noise).^2);
%% Wind Angles
%assume probe noise is same as wind-to-body angle noise
[output.alphaP.data,output.betaP.data,output.alphaP.noise,output.betaP.noise] = pressureToAngles(input,adsR);
output.alphaP.units = 'deg';
output.betaP.units = 'deg';

%% Euler Angles
% output.roll.data=zeros(size(input.accelX.data));
% output.pitch.data=zeros(size(input.accelX.data));
% output.yaw.data=zeros(size(input.accelX.data));
% 
% output.roll.units='deg';
% output.pitch.units='deg';
% output.yaw.units='deg';
% 
% output.roll.noise=0;
% output.pitch.noise=0;
% output.yaw.noise=0;

%% Angular Rates

output.rollRate.data = -input.gyroY.data;
output.pitchRate.data= -input.gyroX.data;
output.yawRate.data = -input.gyroZ.data;

output.rollRate.units='deg/s';
output.pitchRate.units='deg/s';
output.yawRate.units='deg/s';

output.rollRate.noise=0;
output.pitchRate.noise=0;
output.yawRate.noise=0;

%% Accelerations
output.accelX.data = input.accelX.data;
output.accelY.data = input.accelY.data;
output.accelZ.data = input.accelZ.data;

output.accelX.noise = input.accelX.noise;
output.accelY.noise = input.accelY.noise;
output.accelZ.noise = input.accelZ.noise;

output.accelX.units = input.accelX.units;
output.accelY.units = input.accelY.units;
output.accelZ.units = input.accelZ.units;
