
prop='apce';
diam=15;
pitch=6;
v=88;
h=100;
V=20;
Kv=2450/4.4;
Ri=.019;
I0=.9;
[J]=prop_data(prop,diam,pitch);
omega1=2*pi*v/(max(J)*diam/12)/60;
omega2=2*pi*v/(min(J)*diam/12)/60;
% omega1=100*2*pi/60;
% omega2=200*2*pi/60;

[Tprop,Q,P,eta]=rcpropulsion(prop,diam,pitch,v,h,V,Kv,Ri,I0,omega1,omega2)