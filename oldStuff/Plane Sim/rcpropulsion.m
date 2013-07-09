% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% RC Propulsion Model
% Adam Chase
% Cal Poly DBF 2012-2013
% 11/1/2012
% 
% This function does torque matching for an electric motor and
% an RC propeller
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% INPUTS:
% prop	=	type of propeller, in a string. For an APC electric, 'apce'
% diam	=	propeller diameter, [inch]
% pitch	=	propeller pitch, [ ]
% v		=	free stream velocity [ft/s]
% h		=	altitude [ft]
% V		=	applied voltage [V]
% Kv		=	motor speed parameter [rad/s/V]
% Ri		=	motor internal resistance [Ohms]
% I0		=	No load current [Amps]
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% OUTPUTS:
% Tprop	=	total propeller thrust, [lbf]
% Q		=	structure containing component torques [ft-lbf]
% P		=	structure containing component powers	[Watts]
% eta		=	structure containing component efficiency[ ]
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Tprop,QProp,QMotor,PMotor,PProp,PReq,etaTotal,etaMotor,etaProp,CT,CP,J,omega_match,Imotor]=rcpropulsion(prop,diam,pitch,v,h,V,Kv,Ri,I0)
v=.3048*v; %convert v in ft/s to v in m/s
h=.3048*h; %convert h in ft to h in m
Kv=Kv*2*pi/60; %convert RPM/V to rad/s/V
omega1=0;
omega2=30000*2*pi/60;
opts=optimset;
[omega_match,Qerror,exitflag]=fminbnd(@(omega) (torqueerror(prop,diam,pitch,omega,v,...
    h,V,Kv,Ri,I0))^2,omega1,omega2,opts);
if exitflag ~=1
    warn('fminbnd did not converge, but stopped iterating for another reason. Results probably invalid');
end

[Qprop,Pprop,Tprop,J,~,CT,CP,etaprop]=propmodel(prop,diam,pitch,v,omega_match,h);
% [Qprop,Tprop,Pprop,etaprop,CT,CP,J]=rcprop(prop,diam,pitch,omega_match,v,h);
[Qmotor,Pshaft,etamotor,Imotor]=electricmotor(omega_match,V,Kv,Ri,I0);

N2lbf=0.224808943;
Tprop=Tprop*N2lbf;

Nm2ftlb=0.737562121;

QProp=Qprop*Nm2ftlb;
QMotor=Qmotor*Nm2ftlb;

PMotor=Pshaft;
PProp=Pprop;
PReq=V*Imotor;

etaTotal=etaprop*etamotor;
etaMotor=etamotor;
etaProp=etaprop;