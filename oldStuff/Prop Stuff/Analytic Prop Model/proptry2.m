% clear all,close all,clc

omega=500;
L=.35;
D=.01;
r=19/12/2;
J=linspace(.1,.9);
c=1.5/12;
rho=.00237;

for i=1:length(J)
    v=J(i)*omega/2/pi*2*r;
    T(i)=(.5*rho*c)*(v^4*omega^2/24)*(3*log(sqrt(1/(J(i)^2*4*pi^2)+1)+1/(J(i)*2*pi))*(L-4*D/(J(i)*2*pi))+sqrt(1/...
        (J(i)^2*4*pi^2)+1)*(-4*D/(J(i)^2*4*pi^2)+8*D+2*L/(J(i)^3*8*pi^3)+5*L/(J(i)*2*pi)));
    CT(i)=T(i)/(rho*(omega*2*pi)^2*(2*r)^4);
end

plot(J,CT,'-k','linewidth',2)