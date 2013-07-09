clear all,close all,clc
load simData_5_9_2013.mat

noise.eulerAngles = 3; %deg
noise.eulerRates = .1; %deg/s
noise.windAngles = 1; %deg
noise.accel = .1; %ft/s/s
noise.qbar = .1; %psf
noise.gravity = 0; %ft/s/s
noise.W = .001;
noise.GPSSpeed=.1*3.28;

run dataReadin


realAngles = state.eulerAngles;

state = addNoise(state,noise);

stateK = eulerKalman(state,noise);

%%

f=figure;
set(f,'name','phi Comp','numbertitle','off');
plot(state.time,realAngles(:,1),'.r')
hold on
plot(state.time,stateK.eulerAngles(:,1),'.b')
hold on
scatter(state.time,state.eulerAngles(:,1),100,'og')
xlabel('Time [sec]')
ylabel('\phi [rad]')
title('Kalman Filter on \phi')
legend('Simulink','Filtered','Simulink+error','location','northwest')

f=figure;
set(f,'name','psi Comp','numbertitle','off');
plot(state.time,realAngles(:,3),'.r')
hold on
plot(state.time,stateK.eulerAngles(:,3),'.b')
hold on
scatter(state.time,state.eulerAngles(:,3),100,'og')
xlabel('Time [sec]')
ylabel('\psi [rad]')
title('Kalman Filter on \psi')
legend('Simulink','Filtered','Simulink+error','location','northwest')

f=figure;
set(f,'name','theta Comp','numbertitle','off');
plot(state.time,realAngles(:,2),'.r')
hold on
plot(state.time,stateK.eulerAngles(:,2),'.b')
hold on
scatter(state.time,state.eulerAngles(:,2),100,'og')
xlabel('Time [sec]')
ylabel('\theta [rad]')
title('Kalman Filter on \theta')
legend('Simulink','Filtered','Simulink+error','location','northwest')

% RMS_phi = std(realAngles(:,1)-state.eulerAngles(:,1))
% RMS_phi_kalman = std(realAngles(:,1)-xHat(1,:)')
% RMS_theta = std(realAngles(:,2)-state.eulerAngles(:,2))
% RMS_theta_kalman = std(realAngles(:,2)-xHat(2,:)')
% RMS_psi = std(realAngles(:,3)-state.eulerAngles(:,3))
% RMS_psi_kalman = std(realAngles(:,3)-xHat(3,:)')
