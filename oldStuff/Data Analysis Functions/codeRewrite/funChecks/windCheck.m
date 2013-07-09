% clear all,close all,clc

global RbwOut

logfile='XPlaneData-4-3-2013.mat';

[state,plane]=dataReadin(logfile);
[xWind]=bodyToWind(state.accel,state.windAngles);
for i=1:length(state.accelCheck)
    magWind(i)=norm(RbwOut(:,:,i));
end
kk=find(state.altAgl>15,1,'last');
ii=1;
kk=length(state.altAgl);

plot(magWind(ii:kk),'-ok')
% hold on
% plot(magACheck(ii:kk),'-b')
% legend('Calc','XPlane ')

% figure
% plot(100*(magA-magACheck)./magACheck)