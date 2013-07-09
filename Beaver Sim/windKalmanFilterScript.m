clear all,close all,clc

load simData_5_9_2013.mat

noise.eulerAngles = .01; %deg
noise.eulerRates = .0875; %deg/s
noise.windAngles = 2; %deg
noise.accel = .0483; %ft/s/s
noise.qbar = 0; %psf
noise.gravity = .01; %ft/s/s
noise.W = 0.001;
noise.GPSSpeed=.1*3.28;

run dataReadin


realAngles = state.windAngles;

state = addNoise(state,noise);

state = eulerKalman(state,noise);
state = windAngleCalc(state,noise);
stateK = windKalman(state,noise);

f=figure;
set(f,'name','alpha Comp','numbertitle','off');
plot(state.time,realAngles(:,1)*180/pi,'.r')
hold on
plot(state.time,stateK.windAngles(:,1)*180/pi,'.b')
hold on
scatter(state.time,state.windAngles(:,1)*180/pi,100,'og')
xlabel('Time [sec]')
ylabel('\alpha [deg]')
title('Kalman Filter on \alpha')
legend('Simulink','Filtered','Simulink+error','location','northwest')

% f=figure;
% set(f,'name','beta Comp','numbertitle','off');
% plot(state.time,realAngles(:,2),'.r')
% hold on
% plot(state.time,stateK.windAngles(:,2),'.b')
% hold on
% scatter(state.time,state.windAngles(:,2),100,'og')
% xlabel('Time [sec]')
% ylabel('\beta [rad]')
% title('Kalman Filter on \beta')
% legend('Simulink','Filtered','Simulink+error','location','northwest')