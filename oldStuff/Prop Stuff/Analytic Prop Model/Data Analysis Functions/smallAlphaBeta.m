clear all,close all,clc

vector=[1;1;1];
vector=vector/norm(vector,2);

alpha=linspace(0,25,20)*pi/180;
beta=linspace(0,45,21)*pi/180;

for i=1:length(alpha)
    for j=1:length(beta)
Rbw = [cos(beta(j))*cos(alpha(i)) sin(beta(j)) cos(beta(j))*sin(alpha(i));...
    -sin(beta(j))*cos(alpha(i)) cos(beta(j)) -sin(beta(j))*sin(alpha(i));...
    -sin(alpha(i)) 0 cos(alpha(i))];
temp=Rbw*vector;
force1(i,j)=temp(1);
force2(i,j)=temp(2);
force3(i,j)=temp(3);
    end
end

Rbw2 = [cos(0)*cos(0) sin(0) cos(0)*sin(0);...
    -sin(0)*cos(0) cos(0) -sin(0)*sin(0);...
    -sin(0) 0 cos(0)];

noAngles=Rbw2*vector;

error1=noAngles(1)-force1;
error2=noAngles(2)-force2;
error3=noAngles(3)-force3;


figure(1)
[c1,h1]=contour(alpha*180/pi,beta*180/pi,error1');
clabel(c1,h1);
xlabel('\alpha [deg]')
ylabel('\beta [deg]')
title('Drag Error between known \alpha,\beta and \alpha,\beta = 0')

figure(2)
[c2,h2]=contour(alpha*180/pi,beta*180/pi,error2');
clabel(c2,h2);
xlabel('\alpha [deg]')
ylabel('\beta [deg]')
title('Side Force Error between known \alpha,\beta and \alpha,\beta = 0')

figure(3)
[c3,h3]=contour(alpha*180/pi,beta*180/pi,error3');
clabel(c3,h3);
xlabel('\alpha [deg]')
ylabel('\beta [deg]')
title('Lift Error between known \alpha,\beta and \alpha,\beta = 0')

figure(4)
[c3,h3]=contour(alpha*180/pi,beta*180/pi,sqrt(error1.^2+error2.^2+error3.^2)');
clabel(c3,h3);
xlabel('\alpha [deg]')
ylabel('\beta [deg]')
title('Norm of Error between known \alpha,\beta and \alpha,\beta = 0')

figure(5)
[c3,h3]=contour(alpha*180/pi,beta*180/pi,sqrt(error1.^2+error3.^2)');
clabel(c3,h3);
xlabel('\alpha [deg]')
ylabel('\beta [deg]')
title('L/D Error between known \alpha,\beta and \alpha,\beta = 0')