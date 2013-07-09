function [Qerror]=torqueerror(prop,diam,pitch,omega,v,h,V,Kv,Ri,I0)

% [Qprop]=rcprop(prop,diam,pitch,omega,v,h);
[Qprop]=propmodel(prop,diam,pitch,v,omega,h);
[Qmotor]=electricmotor(omega,V,Kv,Ri,I0);

Qerror=Qprop-Qmotor;