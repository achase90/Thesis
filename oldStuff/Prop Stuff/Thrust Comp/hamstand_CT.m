clear all,close all,clc

Nblade=2;
AF=140;
CLi=.35;
d=8; %assume a 6 ft prop
Beta34=18;
[~,~,~,A]=stdatm(10000,2);
v=linspace(0,400);
Minf=v/A;

n=linspace(5000,20000,4)/60; %rps

for i=1:length(Minf)
    for j=1:length(n)
        Jadvance(i,j)=v(i)/(n(j)*d);
        [CP]=HSp_CP_fixed(Nblade,AF,CLi,Jadvance(i,j),Beta34);
        [CT(i,j)] = HSp_CT(Nblade,AF,CLi,Minf(i),Jadvance(i,j),CP);
    end
end

figure(1)
plot(Jadvance(:,1),CT(:,1),'-k','linewidth',2)
hold on
plot(Jadvance(:,2),CT(:,2),'-r','linewidth',2)
plot(Jadvance(:,3),CT(:,3),'-g','linewidth',2)
plot(Jadvance(:,4),CT(:,4),'-b','linewidth',2)
