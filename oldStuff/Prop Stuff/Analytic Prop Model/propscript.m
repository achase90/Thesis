clear all,close all,clc
B=2; %#of blades
c=1/12; %chord length [ft];
h=0;
[~,rho]=stdatm(h,2);
CL=.35;
CD=.05;

J=linspace(.1,.8,50);

rpm=[1500:500:3000];
rps=rpm./60;
w=rps*2*pi;

R=19/12/2; %prop radius [ft]
for i=1:length(J)
    for j=1:length(w)
        v(i)=J(i)*rps(j)*R*2;
        [T(i,j),T1(i,j),T2(i,j)]=prop(B,c,rho,w(j),R,v(i),CL,CD);
        CT(i,j)=T(i,j)/(rho*rps(j)^2*(R*2)^4);
    end
end

figure(1)
plot(J,CT(:,1),'-k','linewidth',2)
hold on
plot(J,CT(:,2),'-r','linewidth',2)
plot(J,CT(:,3),'-b','linewidth',2)
plot(J,CT(:,4),'-g','linewidth',2)
legend(['RPS = ',num2str(rpm(1,1))],['RPM = ',num2str(rpm(1,2))],['RPM = ',num2str(rpm(1,3))],['RPM = ',num2str(rpm(1,4))],'location','southwest')