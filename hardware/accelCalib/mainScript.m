close all,clc
load accelCalibData.mat

s0 = [.06 .06 .06 2 2 7];
opts = optimset('maxFunEvals',2000,'TolX',1e-9);
lb = [0 0 0 -10000 -10000 -10000];
ub = 10000*ones(6,1);
A=[];
b=[];
Aeq=[];
beq=[];
[s1,fval,exitflag] = fmincon(@(s) calibFun(data,s),s0,A,b,Aeq,beq,lb,ub)
[s2,fval,exitflag] = fmincon(@(s) calibFun(data2,s),s0,A,b,Aeq,beq,lb,ub)
[s3,fval,exitflag] = fmincon(@(s) calibFun(data3,s),s0,A,b,Aeq,beq,lb,ub)

s1
s2
s3

dataX = data2(:,1)*s2(1)+s2(4);
dataY = data2(:,2)*s2(2)+s2(5);
dataZ = data2(:,3)*s2(3)+s2(6);
figure(2)
plot(dataX)
hold all
plot(dataY)
plot(dataZ)
xlabel('Sample [-]');
ylabel('Accelerometer Reading [ft/{s^2}]');
legend('X Axis','Y Axis','Z Axis','location','best');
% Identify one orientation.
% mask = ones(length(data),1);

N=length(longData);

g0 = 32.1740;

ax = longData(:,1)*s1(1)+s1(4);
ay = longData(:,2)*s1(2)+s1(5);
az = longData(:,3)*s1(3)+s1(6);

mx = sum(ax)/N;
my = sum(ay)/N;
mz = sum(az)/N;

sx = sqrt(sum((ax-mx).^2)/N)
sy = sqrt(sum((ay-my).^2)/N)
sz = sqrt(sum((az-mz).^2)/N)


% expected noise density - listed as micro-g/sqrt(Hz)
Hz = 1./(longData(:,4)/1e6); %longData(:,4) is deltaT in microsec
ndX = (1e6*sx/g0)./sqrt(Hz); %convert ft/s/s to micro-g's then divide by sqrt(Hz) to compare to data sheet
ndY = (1e6*sy/g0)./sqrt(Hz);
ndZ = (1e6*sz/g0)./sqrt(Hz);
fprintf('Noise density : \t%6.2f\t\t%6.2f\t\t%6.2f \tin micro-g/sqrt(Hz)\n',mean(ndX),mean(ndY),mean(ndZ))
fprintf('Expected density :\t%6.2f\t\t%6.2f\t\t%6.2f \t\tin micro-g/sqrt(Hz)\n',350,175,250)
% mean(ndX) %average noise density in micro-g's/sqrt(Hz)
% mean(ndY)
% mean(ndZ)

nbins=100;
figure(3)
hist((ax-mx),nbins)


figure(4)
hist((ay-my),nbins)

figure(5)
hist((az-mz),nbins)