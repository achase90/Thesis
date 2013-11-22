function [s1,fval] = accelCalib(MatrixIn)
data = MatrixIn(:,2:4); %accelerometer is columns 2:4

s0 = [.06 .06 .06 2 2 7];
opts = optimset('maxFunEvals',2000,'TolX',1e-9);
lb = [0 0 0 -10000 -10000 -10000];
ub = 10000*ones(6,1);
A=[];
b=[];
Aeq=[];
beq=[];
[s1,fval,exitflag] = fmincon(@(s) calibFun(data,s),s0,A,b,Aeq,beq,lb,ub);


function rms = calibFun(data,s)
xCalc = s(1)*data(:,1) + s(4);
yCalc = s(2)*data(:,2) + s(5);
zCalc = s(3)*data(:,3) + s(6);

accelCalc = sqrt(xCalc.^2+ yCalc.^2 +zCalc.^2);

rms = sqrt(sum((32.1740 - accelCalc).^2));