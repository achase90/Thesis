clear all,close all,clc

h=100;
v=40;
prop='apce';
diam=19;
pitch=12;

[~,rho]=stdatm(h,0);

diamnd=diam*.0254; %diam for non-dimensionalizing, in meters

[J,CT,CP]=prop_data(prop,diam,pitch);
%having problems with J not being unique, so removing non-unique points
% J=J(diff(J)~=0);
% CT=CT(diff(J)~=0);
% CP=CP(diff(J)~=0);
[~,m]=unique(J);

J=J(m);
CT=CT(m);
CP=CP(m);

omega=linspace(200*2*pi/60,10000*2*pi/60);
for i=1:length(omega)
n(i)=omega(i)*2*pi;
Jdes(i)=v/(n(i)*diamnd);

CPdes(i)=interp1(J,CP,Jdes(i),'linear');
CTdes(i)=interp1(J,CT,Jdes(i),'linear');
end

plot(Jdes,CTdes,'-k','linewidth',2)
ylabel('C_T')

figure(2)
plot(Jdes,CPdes,'-k','linewidth',2)
ylabel('C_P')
