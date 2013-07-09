% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Electric Motor Model
% Adam Chase
% Cal Poly DBF 2012-2013
% 11/1/2012
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% INPUTS:
% prop	=	type of propeller, in a string. For an APC electric, 'apce'
% diam	=	propeller diameter, [inch]
% pitch	=	propeller pitch, [ ]
% omega	=	motor speed [rad/s]
% v		=	free stream velocity [m/s]
% h		=	altitude [m]
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUTS:
% Qdes		=	motor torque at flight condition[N-m]
% Pdes		=	motor shaft power at flight condition[N-m/s]
% etades		=	motor efficiency at flight condition[ ]
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Qdes,Tdes,Pdes,etades,CTdes,CPdes,Jdes]=rcprop(prop,diam,pitch,omega,v,h)
[~,rho]=stdatm(h,0);

n=omega*2*pi;
diamnd=diam*.0254; %diam for non-dimensionalizing, in meters
Jdes=v/(n*diamnd);

[J,CT,CP]=prop_data(prop,diam,pitch);
%having problems with J not being unique, so removing non-unique points
% J=J(diff(J)~=0);
% CT=CT(diff(J)~=0);
% CP=CP(diff(J)~=0);
[~,m]=unique(J);

J=J(m);
CT=CT(m);
CP=CP(m);

CPdes=interp1(J,CP,Jdes,'linear');
CTdes=interp1(J,CT,Jdes,'linear');

Tdes=CTdes*rho*n^2*diamnd^4;
Pdes=CPdes*rho*n^3*diamnd^5;

Qdes=Pdes/omega;
etades=Jdes*CTdes/CPdes;