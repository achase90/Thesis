clear all,close all,clc

%{
NOTE: This mat file has the plane start from a stop then throttle up and
remove brakes. The plane did not move until brakes were removed. The plane
might have slightly drifted towards the right wing.
%}
logfile='XPlaneDataForwardAccel.mat';

[state,plane]=dataReadin(logfile);

kk=find(state.altAgl>15,1,'last');
ii=1;
kk=length(state.altAgl);
% kk=50;

f=figure;
subplot(3,1,1);
plot(state.accel(ii:kk,1),'-ok')
ylabel('First Component')

subplot(3,1,2)
plot(state.accel(ii:kk,2),'-ok')
ylabel('Second Component')

subplot(3,1,3)
plot(state.accel(ii:kk,3),'-ok')
ylabel('Third Component')