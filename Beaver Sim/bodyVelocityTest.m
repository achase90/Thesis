clear all,close all,clc

clear all,close all,clc

load simData_4_26_2013.mat


run dataReadin

noise.eulerAngles = 1; %deg
noise.eulerRates = .1; %deg/s
noise.windAngles = 0; %deg
noise.accel = .1; %ft/s/s
noise.qbar = .25; %psf
noise.gravity = 0; %ft/s/s
noise.W = .001;
% state.gravity = state.gravity+noise.gravity;
state = addNoise(state,noise);

% V = qbarToV(state);
for i=1:length(state.vBody)
    V(i) = norm(state.vBody(i,:));
end
V=V';
alphaTest = atand(state.vBody(:,3)./state.vBody(:,1));

betaTest = asind(state.vBody(:,2)./V);

plot(alphaTest,'ok')
hold on
plot(state.windAngles(:,1)*180/pi,'xr')


figure(2)
plot(betaTest,'ok')
hold on
plot(state.windAngles(:,2)*180/pi,'xr')