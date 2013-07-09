function [error]=torque_error(prop,diam,pitch,V,omega,Kv,Ri,I0,v,h)
[~,rho]=stdatm(h,2);
n=omega/(2*pi);

[J,CT,CP]=prop_data(prop,diam,pitch);
Jdes=v/(n*diam);
CPdes=interp1(J,CP,Jdes,'cubic');

P=CPdes*rho*n^3*diam^5;
Qprop=P/omega; %check this equation

[Qshaft]=motormodel(V,omega,Kv,Ri,I0);

error=Qshaft-Qprop;