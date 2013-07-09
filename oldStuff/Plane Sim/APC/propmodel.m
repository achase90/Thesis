function [Q_out,Pair,T,J_des,CQ_out,CT_out,CP_out,eta_out]=propmodel(prop,diam,pitch,v,omega,h)
%{
TODO: update all inputs and outputs to metric.

This function interpolates UIUC APC prop data to output Power delivered to
air (Pair) in ft-lbf/s, Torque delivered to air (Q_out) in ft-lbf, 
Thrust (T) in lbf, and the corresponding non-dimensionalized coefficients, 
and the efficiency

%}
RPM=omega*60/2/pi;
n=RPM/60;

[~,rho]=stdatm(h,0);

diamnd=diam*.0254; %diam for non-dimensionalizing, in meters
J_des=v/(n*diamnd); % the advance ratio corresponding to the inputted RPM and velocity

[J,CT,CP,eta]=prop_data(prop,diam,pitch); %imports UIUC prop data
% CT(end+1)=0.0966;
% CP(end+1)=0.0399;
% J(end+1)=0;
% eta(end+1)=0;
CQ=CP/(2*pi);
%% Fitting

% interp1 is non-smooth and not unique, because of the multiple data sets, 
% so using polyfit for now
 
% [~,m]=unique(J);
% CQ=CQ(m);
% J=J(m);
% CT=CT(m);
% CP=CP(m);
% eta=eta(m);
% 
% CQ_out = interp1(J,CQ,J_des,'linear','extrap');
% CP_out = interp1(J,CP,J_des,'linear','extrap');
% CT_out = interp1(J,CT,J_des,'linear','extrap');
% eta_out = interp1(J,eta,J_des,'linear','extrap');

pCQ=polyfit(J,CQ,2);
CQ_out = polyval(pCQ,J_des);
pCP=polyfit(J,CP,2);
CP_out = polyval(pCP,J_des);
pCT=polyfit(J,CT,2);
CT_out = polyval(pCT,J_des);
peta=polyfit(J,eta,2);
eta_out = polyval(peta,J_des);
%%

% these are the coefficient relationships mentioned in UIUC and match what
% I'm familiar with, but using MIT for now

Pair=CP_out*rho*n^3*diamnd^5;
T=CT_out*rho*n^2*diamnd^4;
Q_out=CQ_out*rho*n^2*diamnd^5;

% Pair=.5*rho*pi*(diamnd/2)^5*n^2*CP_out; %MIT's version, converting diameter in
% % inches to radius in feet
% T=.5*rho*pi*(diamnd/2)^4*n^2*CT_out;
% Q_out=Pair/n;
