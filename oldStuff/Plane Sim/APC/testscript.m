clear all,close all,clc

prop='apce';
diam=11;
pitch=85;
v=linspace(0,150,15);
h=100;
V=10;
Kv=700;
Ri=.019;
I0=.9;
[J1]=prop_data(prop,diam,pitch);
for i=1:length(v)
% omega1=2*pi*v(i)/(max(J1)*diam/12)/60;
% omega2=2*pi*v(i)/(min(J1)*diam/12)/60;
% % omega1=100*2*pi/60;
% % omega2=200*2*pi/60;

[Tprop(i),QProp(i),QMotor(i),PMotor(i),PProp(i),PReq(i),etaTotal(i),...
    etaMotor(i),etaProp(i),CT(i),CP(i),J(i),omega(i),Imotor(i)]...
    =rcpropulsion(prop,diam,pitch,v(i),h,V,Kv,Ri,I0);
i
end

figure(1)
plot(J,etaTotal,'-k','linewidth',2)
xlabel('Advance Ratio [ ]')
ylabel('\eta')
xlim([0 1])
ylim([0 1]);

figure(2)
plot(J,Tprop,'-k','linewidth',2)
ylabel('Thrust [lbf]')
xlim([0 1])

figure(3)
plot(J,CT,'-k','linewidth',2)
ylabel('C_T [ ]')
xlim([0 1])
hold on
[Jdata,CTdata,CPdata,etadata]=prop_data(prop,diam,pitch);
scatter(Jdata,CTdata,20)

figure(4)
plot(J,PMotor,'-k','linewidth',2)
ylabel('Motor Shaft Power [Watts]')
xlim([0 1]);

figure(4)
plot(J,omega*60/2/pi,'-k','linewidth',2)
ylabel('RPM [rot/min]')
xlim([0 1]);

figure(5)
plot(J,Imotor,'-k','linewidth',2)
ylabel('Motor Current [Amp]')
xlim([0 1]);