% the purpose of this function is to translate the measured, calibrated
% values, with units, from the IMU, and to convert them to values
% meaningful to the plant. This also includes translating the noise values 
% to plant values. This is where we align gyros/accels/mags/etc.

function [output] = unitsToState(input)

%don't blindly copy input to output since we don't want most of the data in
%the input struct.
output.time.data = input.time.data;
output.time.units = input.time.units;

%% Pressures

output.qbar.data = input.press0.data; %todo:check if this is the correct pressure transducer
output.qbar.units = input.press0.units;
output.qbar.noise = input.press0.noise; %todo:check if this is the correct pressure transducer

R = 287; %universal gas constant %todo:check units on this, they're not right
output.rho.data = input.press3.data./(R*input.temperature.data);
%todo: do error propagation to propagate press4 and temp to rho, the below
%is BS
output.rho.noise = input.press3.noise;
output.rho.units = 'lb/ft^3';

%% Wind Angles
% the same functions you replace the zeros with apply to both data and
% noise
output.alpha.data = zeros(size(input.accelX.data));
output.beta.data = zeros(size(input.accelX.data));

output.alpha.units = 'deg';
output.beta.units = 'deg';

output.alpha.noise = 0;
output.beta.noise = 0;


%% Euler Angles
output.roll.data=zeros(size(input.accelX.data));
output.pitch.data=zeros(size(input.accelX.data));
output.yaw.data=zeros(size(input.accelX.data));

output.roll.units='deg';
output.pitch.units='deg';
output.yaw.units='deg';

output.roll.noise=0;
output.pitch.noise=0;
output.yaw.noise=0;

%% Angular Rates

output.rollRate.data=zeros(size(input.accelX.data));
output.pitchRate.data=zeros(size(input.accelX.data));
output.yawRate.data=zeros(size(input.accelX.data));

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
