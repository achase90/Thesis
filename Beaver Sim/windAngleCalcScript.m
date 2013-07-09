clear all,close all,clc

load simData_5_1_2013.mat


run dataReadin

%% Noise settings
% noise.eulerAngles = 1; %deg
% noise.eulerRates = .1; %deg/s
% noise.windAngles = 1; %deg
% noise.accel = .1; %ft/s/s
% noise.qbar = .1; %psf
% noise.gravity = 0; %ft/s/s
% noise.W = .001;
% noise.GPSSpeed=.1*3.28;

noise.eulerAngles = 0; %deg
noise.eulerRates = 0; %deg/s
noise.windAngles = 0; %deg
noise.accel = 0; %ft/s/s
noise.qbar = 0; %psf
noise.gravity = 0; %ft/s/s
noise.W = 0;
noise.GPSSpeed=0;

state = addNoise(state,noise);

% errorBnd = errorProp(state,plane,noise);

%% 
% state = eulerKalman(state,noise);
state = windAngleCalc(state,noise);
% state = windKalman(state,noise);

plot(state.windAngles(:,1)*180/pi,'og')
hold on
% plot(state.eulerAngles(:,2)*180/pi,'xr')
% plot(atan2(state.windVelBody(:,3),state.windVelBody(:,1))*180/pi)
% plot(state.pitchCalc(:,1)*180/pi,'sk')
plot(state.alphaCalc(:,1)*180/pi,'pb')
% state.pitchCalc(i,2)
% 
% figure(2)
% plot(state.windAngles(:,2)*180/pi,'og')
% hold on
% plot(state.eulerAngles(:,3)*180/pi,'xr')
% plot(state.headingCalc(:,1)*180/pi,'sk')
% plot((state.eulerAngles(:,3)+state.headingCalc(:,1))*180/pi,'pb')

% figure(3)
% plot(state.windAngles(:,1),'og')
% hold on
% plot(state.windAnglesCalc(:,3),'xr')

% figure(4)
% plot(state.flightPath)
