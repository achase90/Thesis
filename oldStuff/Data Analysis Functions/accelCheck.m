clear all,close all,clc

load ('C:\Users\mufasa\Documents\Dropbox\Thesis\Data Logs\XPlaneData-3-5-2013.mat')
index=isfinite(Gloadaxial);
t=totltime-totltime(1);

accelVec=[Gloadaxial Gloadside Gloadnorml]';
theta=pitchdeg*pi/180;
phi=rolldeg*pi/180;
psi=hdingtrue*pi/180;
for i=1:length(psi)
    Rib(:,:,i)=[cos(theta(i))*cos(psi(i)) cos(theta(i))*sin(psi(i)) -sin(theta(i));...
        -cos(phi(i))*sin(psi(i))+sin(phi(i))*sin(theta(i))*cos(psi(i)) cos(phi(i))*cos(psi(i))+sin(phi(i))*sin(theta(i))*sin(psi(i)) sin(phi(i))*cos(theta(i));...
        sin(phi(i))*sin(psi(i))+cos(phi(i))*sin(theta(i))*cos(psi(i)) -sin(phi(i))*cos(psi(i))+cos(phi(i))*sin(theta(i))*sin(psi(i)) cos(phi(i))*cos(theta(i))];
    accelNoG(:,i)=32.2*(accelVec(:,i)-Rib(:,:,i)*[0;0;1]);
end
Vaxial=cumtrapz(t,accelNoG(1,:));
Vnorml=cumtrapz(t,accelNoG(2,:));
Vside=cumtrapz(t,accelNoG(3,:));

figure(1)
scatter(1:length(accelNoG(1,:)),accelNoG(1,:))
title('X Accel')
figure(2)
scatter(1:length(accelNoG(2,:)),accelNoG(2,:))
title('Y Accel')

figure(3)
scatter(1:length(accelNoG(3,:)),accelNoG(3,:))
title('Z Accel')