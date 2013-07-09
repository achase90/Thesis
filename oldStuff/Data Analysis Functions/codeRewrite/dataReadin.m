function [state,plane]=dataReadin(logfile,logdir)

if nargin<2
    cwd=pwd;
    kk = strfind(cwd,'Thesis');
    logdir=[cwd(1:kk+6),'Data Logs\'];
end
load([logdir,logfile])
%% Calculate the current aircraft weight
% state.W=maximlb-(fueltotlb(1)-fueltotlb); %TOGW - weight of fuel burn
% state.W=maximlb;
state.W=curntlb;

%% Build eulerAngles and fix units
state.eulerAngles=[rolldeg pitchdeg hdingtrue]*pi/180;

%% Build windAngles and fix units
state.windAngles=[alphadeg betadeg]*pi/180;

%% Build time
state.time=totltime-totltime(1);

%% Calculate accelerations and velocities
accelVec=[Gloadaxial Gloadside Gloadnorml];
state.accelCheck=accelVec;
% [accelNoG,V]=accelFun(accelVec,state.eulerAngles,state.time);
[accelNoG]=accelFun(accelVec,state.eulerAngles,state.time);
state.accel=accelNoG;
% state.V=V;
% state.VCheck=Vtruemphas*5280/3600;

%% Build omega and fix units
% state.omega=[Pds Qds Rds]*pi/180;

%% Build thrust (assume completely axial thrust)
% state.thrust=[thrst1lb zeros(length(thrst1lb),1) zeros(length(thrst1lb),1)];
% state.thrust=[thrst1lb.*cosd(vert1tvect) zeros(length(thrst1lb),1) thrst1lb.*sind(vert1tvect)];
state.thrust=[axiallb sidelb normllb];
% state.thrust=[thrst1lb zeros(length(thrst1lb),2)];
state.thrustCheck=thrst1lb;

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
plane.Sref=88.1100;