% clear all,close all,clc
load simData_4_29_2013.mat

noise.eulerAngles = 1; %deg
noise.eulerRates = .1; %deg/s
noise.windAngles = 1; %deg
noise.accel = 1; %ft/s/s
noise.qbar = .1; %psf
noise.gravity = 0; %ft/s/s
noise.W = .001;
noise.GPSSpeed=.1*3.28;

run dataReadin

realVBody = state.GPSSpeed;

state = addNoise(state,noise);

state = eulerKalman(state,noise);
stateK = vBodyKalman(state,noise);

%%

f=figure;
set(f,'name','Vx Comp','numbertitle','off');
plot(state.GPSTime,realVBody(:,1),'.r')
hold on
plot(state.time,stateK.vBodyGPS(:,1),'.b')
hold on
scatter(state.GPSTime,state.GPSSpeed(:,1),100,'og')
xlabel('Time [sec]')
ylabel('V_X [ft/s]')
title('Kalman Filter on V_X')
legend('Simulink','Filtered','Simulink+error','location','best')

f=figure;
set(f,'name','Vz Comp','numbertitle','off');
plot(state.GPSTime,realVBody(:,3),'.r')
hold on
plot(state.time,stateK.vBodyGPS(:,3),'.b')
hold on
scatter(state.GPSTime,state.GPSSpeed(:,3),100,'og')
xlabel('Time [sec]')
ylabel('V_Z [ft/s]')
title('Kalman Filter on V_Z')
legend('Simulink','Filtered','Simulink+error','location','best')

f=figure;
set(f,'name','Vy Comp','numbertitle','off');
plot(state.GPSTime,realVBody(:,2),'.r')
hold on
plot(state.time,stateK.vBodyGPS(:,2),'.b')
hold on
scatter(state.GPSTime,state.GPSSpeed(:,2),100,'og')
xlabel('Time [sec]')
ylabel('V_Y [ft/s]')
title('Kalman Filter on V_Y')
legend('Simulink','Filtered','Simulink+error','location','best')

