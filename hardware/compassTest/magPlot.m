clear all,close all,clc

load calibData.mat
[realData] = calibMag(magData);
plot(magData(:,1),magData(:,2),'.r')
hold on
plot(realData(:,1),realData(:,2),'.b')
axis equal
xlabel('X [-]');
ylabel('Y [-]');
title('Magnetometer Ellipse (X-Y Plane)')
legend('Calibrated','Raw','location','best');
% view(90,90)
