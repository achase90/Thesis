clear all,close all,clc

load ('C:\users\adam\documents\dropbox\Thesis\Data Logs\XPlaneData-2-1-2013.mat')
index=isfinite(Gloadaxial);
t=[1/10:1/10:length(index~=0)/10-2/10];
Vaxial=cumtrapz(t,Gloadaxial(index)*32.2)/10;
Vnorml=cumtrapz(t,Gloadnorml(index)*32.2)/10;
Vside=cumtrapz(t,Gloadside(index)*32.2)/10;

for i=2:length(Qrads)-1
    
X(1:3)=[Gloadaxial(i)*32.2 Gloadside(i)*32.2 (Gloadnorml(i)-1)*32.2]'; %Vdot
X(4:6)=[Prads(i);Qrads(i);Rrads(i)]'; %omega
X(7:9)=(5280/3600)*[Vtruemphgs(i) 0 0]'; %V
X(10:12)=[thrst1lb(i) 0 0]'; %Ft
X(13)=emptylb(i); %W
X(14)=alphadeg(i)*pi/180; %alpha
X(15)=betadeg(i)*pi/180; %beta
X(16)=pitchdeg(i)*pi/180; %theta
X(17)=rolldeg(i)*pi/180; %phi

[Cl(i),Cd(i)] = stateToForces2(X);
end

figure(1)
scatter(1:i,Cd,50,'.k')
hold on
scatter(2:i,cdtotal(2:end-1),50,'.b')
xlabel('Index [-]')
ylabel('C_D [-]')

figure(2)
scatter(1:i,Cl,50,'.k')
hold on
scatter(2:i,cltotal(2:end-1),50,'.b')
xlabel('Index [-]')
ylabel('C_L [-]')


figure(3)
scatter(Cd,Cl,20,'k')
hold on
scatter(cdtotal,cltotal,20,'b')