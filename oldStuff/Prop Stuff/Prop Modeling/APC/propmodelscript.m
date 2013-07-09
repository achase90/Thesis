%this script checks that the trends are correct for propmodel.m
clear all,close all,clc

h=100;
v=88;
diam=10;
pitch=7;
prop='apce';
Kv=1020;
I0=1.1;
Rm=.06;
V=10;
RPM=linspace(0,12000,12);
for i=1:length(RPM)
[Q_out(i),Pair(i),T(i),J_out(i),CQ_out(i),CT_out(i),CP_out(i),eta_out(i)]=propmodel(prop,diam,pitch,v,RPM(i),h);
[Pshaft(i),Qshaft(i),I]=rcmotor(I0,Rm,Kv,V,RPM(i));
end

figure(1)
hold all
plot(RPM,Q_out,'linewidth',2)
plot(RPM,Qshaft,'linewidth',2)
xlabel('RPM')
ylabel('Torque [ft-lbf]')
legend('Prop Torque','Motor Torque')

figure(2)
hold all
plot(RPM,Pair,'linewidth',2)
xlabel('RPM')
ylabel(' Power [ft-lbf/s]')

figure(3)
hold all
plot(RPM,T,'linewidth',2)
xlabel('RPM')
ylabel('Thrust [lbf]')

% figure(4)
% plot(n,J_out,'-b','linewidth',2)
% xlabel('n [rad/s]')
% ylabel(' J []')

