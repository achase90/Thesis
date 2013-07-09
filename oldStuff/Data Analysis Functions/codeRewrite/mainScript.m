%%
%{
Roll might be negative - checked, postive roll/P is right wing down

should check all euler angles, since non-zero accel vector when not moving
on ground

pitch should be fine - positive pitch is nose up

maybe check signs of omega and windangles also

alpha looks fine - positive alpha is nose up

changing the down vector to a -1 in accelFun fixed lift. Don't know why,
and it doesn't make sense that this is correct. But it works.

if I mess with any accels, lift gets work, meaning accels are probably
alright and the error is somewhere else.

%}
%%
% clear all,close all,clc

plotFlag=false;
% plotFlag=true;
residuals=false;
% residuals=true;

logfile='XPlaneData-4-3-2013.mat';
% logfile='XPlaneDataRollTest.mat';

[state,plane]=dataReadin(logfile);

[cAero,fAero]=plant(state,plane);

[accel]=plantInverse(fAero,state.thrust,state.W,state.windAngles,state.eulerAngles);

%% Plots
if plotFlag
    plotStates(state);
end

marksize=100;
marktype='.';
% ii=find(state.altMsl>state.altMsl(1)+50,1,'first');
ii=find(state.altAgl>15,1,'first');
kk=length(state.altAgl);

f=figure;
set(f,'name','Drag Comp','numbertitle','off');
scatter(state.time(ii:kk),fAero((ii:kk),1),marksize,'k','marker',marktype);
hold on
scatter(state.time(ii:kk),state.drag(ii:kk),marksize,'b','marker',marktype);
xlabel('Time [sec]')
ylabel('Drag Force [lb]')
title('Drag Force vs. Time')
legend('Model','XPlane')

f=figure;
set(f,'name','Lift Comp','numbertitle','off');
scatter(state.time(ii:kk),fAero((ii:kk),3),marksize,'k','marker',marktype);
hold on
scatter(state.time(ii:kk),state.lift(ii:kk),marksize,'b','marker',marktype);
xlabel('Time [sec]')
ylabel('Lift Force [lb]')
title('Lift Force vs. Time')
legend('Model','XPlane')

f=figure;
set(f,'name','Side Comp','numbertitle','off');
scatter(state.time(ii:kk),fAero((ii:kk),2),marksize,'k','marker',marktype);
hold on
scatter(state.time(ii:kk),state.side(ii:kk),marksize,'b','marker',marktype);
xlabel('Time [sec]')
ylabel('Side Force [lb]')
title('Side Force vs. Time')
legend('Model','XPlane')

f=figure;
set(f,'name','Polar Comp','numbertitle','off');
scatter(fAero((ii:kk),1),fAero((ii:kk),3),marksize,'k','marker',marktype);
hold on
scatter(state.drag(ii:kk),state.lift(ii:kk),marksize,'b','marker',marktype);
xlabel('C_D [-]')
ylabel('C_L [-]')
title('Drag Polar')
legend('Model','XPlane')

if residuals
    f=figure;
    set(f,'name','Drag Residual','numbertitle','off');
    scatter(state.time(ii:kk),100*(fAero((ii:kk),1)-state.drag(ii:kk))./state.drag(ii:kk),...
        marksize,'k','marker',marktype);
    xlabel('Time [-]')
    ylabel('Percent Difference Drag [-]')
    title('Drag Residual')
    
    f=figure;
    set(f,'name','Lift Residual','numbertitle','off');
    scatter(state.time(ii:kk),100*(fAero((ii:kk),3)-state.lift(ii:kk))./state.lift(ii:kk),...
        marksize,'k','marker',marktype);
    xlabel('Time [-]')
    ylabel('Percent Difference Lift [-]')
    title('Lift Residual')
end

%%
% f=figure;
% set(f,'name','X accel','numbertitle','off');
% scatter(state.time(ii:kk),accel(1,ii:kk),marksize,'k','marker',marktype);
% hold on
% scatter(state.time(ii:kk),32.2*state.accelCheck(ii:kk,1),marksize,'b','marker',marktype);
% xlabel('Time [-]')
% ylabel('X Accel [-]')
% title('X Accel')
% legend('Model','XPlane')
% 
% f=figure;
% set(f,'name','Y accel','numbertitle','off');
% scatter(state.time(ii:kk),accel(2,ii:kk),marksize,'k','marker',marktype);
% hold on
% scatter(state.time(ii:kk),32.2*state.accelCheck(ii:kk,2),marksize,'b','marker',marktype);
% xlabel('Time [-]')
% ylabel('Y Accel [-]')
% title('Y Accel')
% legend('Model','XPlane')
% 
% f=figure;
% set(f,'name','Z accel','numbertitle','off');
% scatter(state.time(ii:kk),accel(3,ii:kk),marksize,'k','marker',marktype);
% hold on
% scatter(state.time(ii:kk),32.2*state.accelCheck(ii:kk,3),marksize,'b','marker',marktype);
% xlabel('Time [-]')
% ylabel('Z Accel [-]')
% title('Z Accel')
% legend('Model','XPlane')
