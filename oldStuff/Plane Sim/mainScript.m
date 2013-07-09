clear all,close all,clc
%{
TODO:
fix units in rcpropulsion

%}

warning off
%% Load prop data
load APCE11x8.5TableLookup.mat

Thrust=Tprop;
Torque=QProp;
Volt=V;
alt=h;
speed=v;
clearvars -except Thrust Torque Volt alt speed

m2ft=3.28084;

%% Trim states
defTrims=[0*pi/180 -5*pi/180 0*pi/180 .5]; %trim states, roll pitch yaw throttle

%% Deflection Limits
defAilMax = 20*pi/180;
defElevMax = 25*pi/180;
defRudMax = 16*pi/180;
defThrotMax = 20;

% defAilMax = 0*pi/180;
% defElevMax = 25*pi/180;
% defRudMax = 0*pi/180;
% defThrotMax = 0;

%% Reference Values
Sref = 174;
cref = 4.9;
bref = 36;
%NOTE : trim alpha at cruise is 0, so body axis = stability axis
u0 = 220.1;
alpha0 = 0;
alphaDot0 = 0;
q0 = 0;
deltaE0 = 0;
beta0 = 0;
betaDot0 = 0;
p0 = 0;
r0 = 0;
deltaA0 = 0;
deltaR0 = 0;

%% Longitudinal Aero
e = .7;
CD0 = .0270;
CDu = 0;
CD1 = .032;
% CDalpha = .121;
CDalpha = .0;
% Set induced CD term based on CL in block
KCL2 = 1/(pi*e*bref/cref);
CDalphaDot = 0;
CDq = 0;
CDdeltaE = 0;

CL0 = .307;
CL1 = .307;
CLu = 0;
CLalpha = 4.41;
CLalphaDot = 1.7;
CLq = 3.9;
CLdeltaE = .43;

CM0 = .04;
CM1 = 0;
CMu = 0;
CMalpha = -.613;
CMalphaDot = -7.27;
CMQ = -12.4;
CMdeltaE = -1.122;

CXu = -(CDu+2*CD1);
CXalpha = -CD1 - 2*CL0*CLalpha/(pi*e*bref/cref);
CXalphaDot = 0;
CXq = 0;
CXdeltaE = 0;

CZu = 0; % Assumption, Nelson has an equation for it
CZalpha = -(CLalpha + CL0);
CZalphaDot = -CLalphaDot;
CZq = -CLq;
CZdeltaE = -CLdeltaE;

%NOTE: all CM derivatives are the same as defined above

longCoeffRefs = [-CD1 -CL0 CM1];
    
longStateRefs = [u0 alpha0  alphaDot0 q0 deltaE0];

longNonDimRefs = [1/u0 1 cref/(2*u0) cref/(2*u0) 1];

longMatrix = [CXu CXalpha CXalphaDot CXq CXdeltaE;
CZu CZalpha CZalphaDot CZq CZdeltaE;
CMu CMalpha CMalphaDot CMQ CMdeltaE];

forcesReDimRefs = [Sref Sref Sref];

%% Lateral Aero
CY0 = 0;
CYbeta = -.393;
CYbetaDot = 0;
CYP = -.075;
CYR = .214;
CYdeltaA = 0;
CYdeltaR = .187;

Cl0 = 0;
ClBeta = -.0923;
ClBetaDot = 0;
ClP = -.484;
ClR = .0798;
ClDeltaA = .229;
ClDeltaR = .0147;

Cn0 = 0;
CnBeta = .0587;
CnBetaDot = 0;
CnP = -.0278;
CnR = -.0937;
CnDeltaA = -.0216;
CnDeltaR = -.0645;

latCoeffRefs = [CY0 Cl0 Cn0];
    
latStateRefs = [beta0 betaDot0 p0 q0 deltaA0 deltaR0];

latNonDimRefs = [1 bref/(2*u0) bref/(2*u0)  bref/(2*u0) 1 1]; %NOTE: Check this

latMatrix = [CYbeta CYbetaDot CYP CYR CYdeltaA CYdeltaR;
ClBeta ClBetaDot ClP ClR ClDeltaA ClDeltaR;
CnBeta CnBetaDot CnP CnR CnDeltaA CnDeltaR];

momentReDimRefs = [Sref*bref Sref*cref Sref*bref];

%% Weight and Moments of Inertia
W = 2650;
Jxx=948;
Jyy=1346;
Jxy=0;
Jyz=0;
Jxz=0;
Jzz=1967;

J = [Jxx Jxy Jxz
Jxy Jyy Jyz
Jxz Jyz Jzz];

%% Initial Values
% href=7724/3;
% psio=
flatearth_pos = lla2flat([37 -121 7000/m2ft], [37 -121], 0,0);

X0 = flatearth_pos*m2ft;
V0 = [220 0 0];
windAng0 = [0 0 0];
eulerRate0 = [0 0 0];

%% Run sim
% set_param('mainSim/deflectioms1', 'YMax', '1.1')
% set_param('mainSim/deflectioms1', 'YMin', '-1.1')
% sim('mainSim.mdl');