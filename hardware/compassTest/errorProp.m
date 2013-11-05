clear all,clc

load calibData.mat
syms x1 x2 x3
angleNoise = [2 2 2]';

J(1,:) = jacobian(acos(x1/norm([x1,x2,x3])),[x1,x2,x3]);
J(2,:) = jacobian(acos(x2/norm([x1,x2,x3])),[x1,x2,x3]);
J(3,:) = jacobian(acos(x3/norm([x1,x2,x3])),[x1,x2,x3]);

for i=1:length(magData)
    JAngle = subs(J,[x1 x2 x3],magData(i,:));
    angleError(i,:) = JAngle*angleNoise;
end
angleError = angleError*180/pi;

std(angleError)