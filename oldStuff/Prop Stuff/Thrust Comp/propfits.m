clear all,close all,clc
%todo: make 3-d model and compare to this 2-d model
d=19/12;
pts=80;

%% Read in datasets
A1=importdata('apce_19x12_jb1079_1500.txt');
J1=A1.data(:,1);
CT1=A1.data(:,2);
CP1=A1.data(:,3);
eta1=A1.data(:,4);
CQ1=CP1/(2*pi);
n1=1500*ones(size(eta1))/60;
v1=J1.*n1*d;

A2=importdata('apce_19x12_jb1080_2096.txt');
J2=A2.data(:,1);
CT2=A2.data(:,2);
CP2=A2.data(:,3);
eta2=A2.data(:,4);
CQ2=CP2/(2*pi);
n2=2096*ones(size(eta2))/60;
v2=J2.*n2*d;

A3=importdata('apce_19x12_jb1081_2502.txt');
J3=A3.data(:,1);
CT3=A3.data(:,2);
CP3=A3.data(:,3);
eta3=A3.data(:,4);
CQ3=CP3/(2*pi);
n3=2502*ones(size(eta3))/60;
v3=J3.*n3*d;

A4=importdata('apce_19x12_jb1082_2508.txt');
J4=A4.data(:,1);
CT4=A4.data(:,2);
CP4=A4.data(:,3);
eta4=A4.data(:,4);
CQ4=CP4/(2*pi);
n4=2508*ones(size(eta4))/60;
v4=J4.*n4*d;

A5=importdata('apce_19x12_jb1083_2991.txt');
J5=A5.data(:,1);
CT5=A5.data(:,2);
CP5=A5.data(:,3);
eta5=A5.data(:,4);
CQ5=CP5/(2*pi);
n5=2991*ones(size(eta5))/60;
v5=J5.*n5*d;

A6=importdata('apce_19x12_jb1084_3007.txt');
J6=A6.data(:,1);
CT6=A6.data(:,2);
CP6=A6.data(:,3);
eta6=A6.data(:,4);
CQ6=CP6/(2*pi);
n6=3007*ones(size(eta6))/60;
v6=J6.*n6*d;

Jvec=[J1;J2;J3;J4;J5;J6];
CTvec=[CT1;CT2;CT3;CT4;CT5;CT6];
nvec=[n1;n2;n3;n4;n5;n6];
vvec=[v1;v2;v3;v4;v5;v6];
data=[Jvec CTvec nvec vvec];
data=sortrows(data);
Jvec=data(:,1);
CTvec=data(:,2);
nvec=data(:,3);
vvec=data(:,4);
%% Plots for individual runs
npts=max([length(J1) length(J2) length(J3) length(J4) length(J5) length(J6)]);

J1resize=linspace(min(J1),max(J1),npts);
CT1resize=interp1(J1,CT1,J1resize,'spline');
figure(5)
scatter(J1,CT1,pts,'ok','linewidth',2)
hold on
plot(J1resize,CT1resize,'-r','linewidth',2)
xlabel('Advance Ratio')
ylabel('C_T')
title(['C_T vs J for APCE 19x12 at ',num2str(n1(1),3),' rps'])

J2resize=linspace(min(J2),max(J2),npts);
CT2resize=interp1(J2,CT2,J2resize,'spline');
figure(6)
scatter(J2,CT2,pts,'ok','linewidth',2)
hold on
plot(J2resize,CT2resize,'-r','linewidth',2)
xlabel('Advance Ratio')
ylabel('C_T')
title(['C_T vs J for APCE 19x12 at ',num2str(n2(1),3),' rps'])

J3resize=linspace(min(J3),max(J3),npts);
CT3resize=interp1(J3,CT3,J3resize,'spline');
figure(7)
scatter(J3,CT3,pts,'ok','linewidth',2)
hold on
plot(J3resize,CT3resize,'-r','linewidth',2)
xlabel('Advance Ratio')
ylabel('C_T')
title(['C_T vs J for APCE 19x12 at ',num2str(n3(1),3),' rps'])

J4resize=linspace(min(J4),max(J4),npts);
CT4resize=interp1(J4,CT4,J4resize,'spline');
figure(8)
scatter(J4,CT4,pts,'ok','linewidth',2)
hold on
plot(J4resize,CT4resize,'-r','linewidth',2)
xlabel('Advance Ratio')
ylabel('C_T')
title(['C_T vs J for APCE 19x12 at ',num2str(n4(1),3),' rps'])

J5resize=linspace(min(J5),max(J5),npts);
CT5resize=interp1(J5,CT5,J5resize,'spline');
figure(9)
scatter(J5,CT5,pts,'ok','linewidth',2)
hold on
plot(J5resize,CT5resize,'-r','linewidth',2)
xlabel('Advance Ratio')
ylabel('C_T')
title(['C_T vs J for APCE 19x12 at ',num2str(n5(1),3),' rps'])

J6resize=linspace(min(J6),max(J6),npts);
CT6resize=interp1(J6,CT6,J6resize,'spline');
figure(10)
scatter(J6,CT6,pts,'ok','linewidth',2)
hold on
plot(J6resize,CT6resize,'-r','linewidth',2)
xlabel('Advance Ratio')
ylabel('C_T')
title(['C_T vs J for APCE 19x12 at ',num2str(n6(1),3),' rps'])

figure(11)
scatter(J1,CT1,pts,'ok','markerfacecolor','k','markeredgecolor','k','linewidth',1.5)
xlabel('Advance Ratio')
ylabel('Thrust Coefficient')
title('C_T vs J for an APCE 19x12 Prop')
hold on
scatter(J2,CT2,pts,'or','markerfacecolor','r','markeredgecolor','k','linewidth',1.5)
scatter(J3,CT3,pts,'ob','markerfacecolor','b','markeredgecolor','k','linewidth',1.5)
scatter(J4,CT4,pts,'og','markerfacecolor','g','markeredgecolor','k','linewidth',1.5)
scatter(J5,CT5,pts,'oy','markerfacecolor','y','markeredgecolor','k','linewidth',1.5)
scatter(J6,CT6,pts,'om','markerfacecolor','m','markeredgecolor','k','linewidth',1.5)
plot(J1resize,CT1resize,'--k','linewidth',2)
plot(J2resize,CT2resize,'--r','linewidth',2)
plot(J3resize,CT3resize,'--b','linewidth',2)
plot(J4resize,CT4resize,'--g','linewidth',2)
plot(J5resize,CT5resize,'--y','linewidth',2)
plot(J6resize,CT6resize,'--m','linewidth',2)
legend(['n = ',num2str(n1(1),3),' rps'],['n = ',num2str(n6(1),3),' rps'],['n = ',num2str(n3(1),3),' rps'],['n = ',num2str(n4(1),3),' rps'],['n = ',num2str(n5(1),3),' rps'],['n = ',num2str(n6(1),3),' rps'],'location','southwest')

%% 2-D CT Fit
xtrash=[1:1:length(CTvec)];

figure(1)
scatter(J1,CT1,pts,'ok','markerfacecolor','k','markeredgecolor','k','linewidth',1.5)
xlabel('Advance Ratio')
ylabel('Thrust Coefficient')
title('C_T vs J for an APCE 19x12 Prop')
hold on
scatter(J2,CT2,pts,'or','markerfacecolor','r','markeredgecolor','k','linewidth',1.5)
scatter(J3,CT3,pts,'ob','markerfacecolor','b','markeredgecolor','k','linewidth',1.5)
scatter(J4,CT4,pts,'og','markerfacecolor','g','markeredgecolor','k','linewidth',1.5)
scatter(J5,CT5,pts,'oy','markerfacecolor','y','markeredgecolor','k','linewidth',1.5)
scatter(J6,CT6,pts,'om','markerfacecolor','m','markeredgecolor','k','linewidth',1.5)

[p1,S1]=polyfit(Jvec,CTvec,2);
CTvar=polyval(p1,Jvec);
plot(Jvec,CTvar,'--k','linewidth',2)
legend(['n = ',num2str(n1(1),3),' rps'],['n = ',num2str(n6(1),3),' rps'],['n = ',num2str(n3(1),3),' rps'],['n = ',num2str(n4(1),3),' rps'],['n = ',num2str(n5(1),3),' rps'],['n = ',num2str(n6(1),3),' rps'],'location','southwest')
% errorbar(Jvec,CTvar,.42*std(CTvar)*ones(size(CTvar)))

figure(2)
hold on
scatter(Jvec,100*(CTvec-CTvar)./CTvec,pts,'ok','linewidth',1.5)
xlabel('Advance Ratio')
ylabel('Percent Error')
title('Thrust Coefficient Percent Error vs Advance Ratio')
% ylim([-12 2])
grid on
% 
figure(3)
hold on
scatter(Jvec,sqrt((100*(CTvec-CTvar)./CTvec).^2),pts,'ok','linewidth',1.5)
ylabel('Percent Error')
title('Thrust Coefficient RMS Error vs Advance Ratio')
% ylim([-12 2])
grid on

%% 3-D CT Fit
clear CTvar Jvar nvar
A=[Jvec.^2 Jvec nvec.^2 nvec Jvec.*nvec ones(size(Jvec))];
b=CTvec;
x=pinv(A)*b;

Jvar=linspace(min(Jvec),max(Jvec))';
nvar=linspace(min(nvec),max(nvec),60)';
for i=1:length(Jvar)
    for j=1:length(nvar)
        Avar=[Jvar(i).^2 Jvar(i) nvar(j).^2 nvar(j) Jvar(i).*nvar(j) 1];
        CTvar(i,j)=Avar*x;
    end
end
figure(4)
surf(Jvar,nvar,CTvar');
shading flat
hold on
scatter3(Jvec,nvec,CTvec,pts,'ok','linewidth',2)
% [c1,h1]=contour(Jvar,nvar,CTvar');
% clabel(c1,h1);
xlabel('Advance Ratio')
ylabel('Propeller Speed [rot/s]')
title('C_T vs J and Prop Speed (n)')

figure(2)
CTreg=A*x;
scatter(Jvec,100*(CTvec-CTreg)./CTvec,pts,'or','linewidth',1.5)
xlabel('Advance Ratio []')
ylabel('C_T Percent Error')
title('C_T Percent Error')
legend('2-D Fit','3-D Fit','location','northwest')

figure(3)
scatter(Jvec,sqrt((100*(CTvec-CTreg)./CTvec).^2),pts,'or','linewidth',2)
xlabel('Data index []')
ylabel('C_T RMS of Percent Error')
title('C_T RMS of Percent Error')
legend('2-D Fit','3-D Fit','location','northwest')
% ylim([-12 2])
grid on