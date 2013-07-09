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
% omega	=	motor speed [rad/s]
% V		=	applied voltage [V]
% Kv		=	motor speed parameter [rad/s/V]
% Ri		=	motor internal resistance [Ohms]
% I0		=	No load current [Amps]
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUTS:
% Q		=	motor torque [N-m]
% P		=	motor shaft power [N-m/s]
% eta	=	motor efficiency [ ]
% I		=	motor current [Amps]

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [Q,P,eta,I]=electricmotor(omega,V,Kv,Ri,I0)
Q=((V-omega/Kv)/Ri-I0)/Kv;
P=Q*omega;
eta=(1-I0*Ri/(V-omega/Kv))*(omega/(V*Kv));
I=(V-omega/Kv)/Ri;