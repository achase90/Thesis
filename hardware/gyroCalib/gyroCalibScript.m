clear all,close all,clc
load calibData.mat
load testData.mat

zeroAv = mean(zeroData);
zeros =  repmat(zeroAv,length(zeroData),1);
mz = (33+1/3)*360/60/(-mean(calib1(:,3)-zeros(:,3)));
mx = (33+1/3)*360/60/(mean(calib2(:,1)-zeros(:,1)));
my = (33+1/3)*360/60/(-mean(calib3(:,2)-zeros(:,2)));
bx = zeroAv(1);
by = zeroAv(2);
bz = zeroAv(3);

zeros =  repmat(zeroAv,length(test),1);

deltaT = test(:,4)/1e6;
test = test(:,1:3);
testNZ = test - zeros;
% xCalib = mx*testNZ(:,1);
% yCalib = my*testNZ(:,2);
% zCalib = mz*testNZ(:,3);
xCalib = testNZ(:,1)/14.375;
yCalib = testNZ(:,2)/14.375;
zCalib = testNZ(:,3)/14.375;

xCalib = smooth(xCalib);
yCalib = smooth(yCalib);
zCalib = smooth(zCalib);

figure(1)
subplot(3,1,1)
xAng = cumtrapz(deltaT,xCalib);
plot(xAng)
ylabel('x Angle [deg]')
subplot(3,1,2)
yAng = cumtrapz(deltaT,yCalib);
plot(yAng)
ylabel('y Angle [deg]')
subplot(3,1,3)
zAng = cumtrapz(deltaT,zCalib);
plot(zAng)
ylabel('z Angle [deg]')


figure(2)
subplot(3,1,1)
plot(xCalib)
ylabel('X Rate [deg/s]')
subplot(3,1,2)
plot(yCalib)
ylabel('Y Rate [deg/s]')
subplot(3,1,3)
plot(zCalib)
ylabel('Z Rate [deg/s]')