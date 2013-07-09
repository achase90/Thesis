clear all,close all,clc

prop='apce';
diam=14;
pitch=12;
v=linspace(10,100,15);
h=100;
V=20;
Kv=2450/4.4;
Ri=.019;
I0=.9;
[J1]=prop_data(prop,diam,pitch);
for i=1:length(v)
omega1=2*pi*v(i)/(max(J1)*diam/12)/60;
omega2=2*pi*v(i)/(min(J1)*diam/12)/60;
% omega1=100*2*pi/60;
% omega2=200*2*pi/60;

[Tprop(i),QProp(i),QMotor(i),PMotor(i),PProp(i),PReq(i),etaTotal(i),etaMotor(i),etaProp(i),CT(i),CP(i),J(i)]=rcpropulsion(prop,diam,pitch,v(i),h,V,Kv,Ri,I0,omega1,omega2);
i
end

figure(1)
plot(J,etaTotal,'-k','linewidth',2)
xlabel('Advance Ratio [ ]')
ylabel('\eta')

figure(2)
plot(J,Tprop,'-k','linewidth',2)
ylabel('Thrust [lbf]')