clear all,close all,clc

logfile='XPlaneData-3-28-2013.mat';
% logfile='XPlaneDataRollTest.mat';

[state,plane]=dataReadin(logfile);

fAero=[state.drag zeros(size(state.drag)) state.lift];
FT=state.thrust;
FW=[zeros(length(state.W),2) state.W];

[FW]=inertToBody(FW,state.eulerAngles,true);
sumOfForces=state.accel.*FW'/32.2-FT-fAero-FW';
ii=find(state.altMsl>state.altMsl(1)+50,1,'first');
kk=length(state.altMsl);

figure(1)
scatter(ii:kk,sumOfForces(ii:kk,1));
ylabel('Drag')

figure(2)
scatter(ii:kk,sumOfForces(ii:kk,3));
ylabel('lift')
