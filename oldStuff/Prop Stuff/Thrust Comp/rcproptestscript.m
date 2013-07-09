clear all,close all,clc

v=30; %m/s
h=100; %m

omega=linspace(500*2*pi/60,10000*2*pi/60);
for i=1:length(omega)
[Qdes(i),Tdes(i),Pdes(i),etades(i),CTdes(i),CPdes(i),Jdes(i)]=rcprop('apce',19,12,omega(i),v,h);
end

plot(Jdes,CTdes,'-k','linewidth',2)
xlabel('Advance Ratio [ ]')
ylabel('C_T [ ]')

figure(2)
plot(Jdes,CTdes,'-k','linewidth',2)
xlabel('Advance Ratio [ ]')
ylabel('C_P [ ]')
