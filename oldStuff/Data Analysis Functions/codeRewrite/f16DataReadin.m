function [state,plant]=f16DataReadin(logfile,logdir)
if nargin<2
    cwd=pwd;
    kk = strfind(cwd,'Thesis');
    logdir=[cwd(1:kk+6),'Data Logs\'];
end
load([logdir,logfile])
state=f16readin(y_sim);
%% Calculate the current aircraft weight
% state.W=maximlb-(fueltotlb(1)-fueltotlb); %TOGW - weight of fuel burn
% state.W=maximlb;
[state.g]=constParser('C:\Users\mufasa\Documents\Dropbox\Thesis\f16sim\F16Sim\nlplant.c','double g','= ',';');

[state.m]=constParser('C:\Users\mufasa\Documents\Dropbox\Thesis\f16sim\F16Sim\nlplant.c','double m','= ',';');
state.W=state.g*state.m;

%% Build eulerAngles and fix units
state.eulerAngles=[state.phi state.theta state.psi];

%% Build windAngles and fix units
state.windAngles=[state.alpha state.beta];

%% Build time
% state.time=totltime-totltime(1);

%% Calculate accelerations and velocities
accelVec=[state.nx state.ny state.nz];
% state.accelCheck=accelVec;
% [accelNoG,V]=accelFun(accelVec,state.eulerAngles,state.time);
[accelNoG]=accelFun(accelVec,state.eulerAngles,state.time);
state.accel=accelNoG;
% state.V=V;
% state.VCheck=Vtruemphas*5280/3600;

%% Build omega and fix units
% state.omega=[Pds Qds Rds]*pi/180;

%% Build thrust (assume completely axial thrust)
state.thrust=[trim_thrust*ones(size(state.time)) zeros(length(state.time),2)];
% state.thrustCheck=thrst1lb;

%% Build qbar (this is wrong so only compare forces for now)
% for i=1:length(state.V)
%     [~,state.rho(i)]=stdatm(alt1ftmsl(i),2);
%     state.qbar(i,1)=.5*state.rho(i)*norm(state.V(i,:))^2;
% end

%% Build XPlane output to comapare to
state.drag=draglb;
state.lift=liftlb;
state.side=sidelb1;

state.altAgl=altftagl;
% state.altMsl=alt1ftmsl;

try
    state.cDrag=cdtotal;
    state.cLift=cltotal;
catch
end
%% Build plane struct
[plane.Sref]=constParser('C:\Users\mufasa\Documents\Dropbox\Thesis\f16sim\F16Sim\nlplant.c','double S','= ',';');
