clear all,close all,clc

logfile='XPlaneDataForwardAccel.mat';

[state,plane]=dataReadin(logfile);

for i=1:length(state.accelCheck)
    magA(i)=norm(state.accel(i,:)/32.2);
    magACheck(i)=norm(state.accelCheck(i,:));
    magANormComp(i)=magACheck(i)-magA(i);
end

kk=find(state.altAgl>15,1,'last');
ii=1;
kk=length(state.altAgl);
% kk=50;

f=figure;
subplot(3,1,1);
plot(magANormComp(ii:kk),'-ok')
ylabel('Difference should be 1')

subplot(3,1,2)
plot(magA(ii:kk),'-ok')
ylabel('Norm Calc''d should be 0')

subplot(3,1,3)
plot(magACheck(ii:kk),'-ok')
ylabel('Norm XPlane should be 1')