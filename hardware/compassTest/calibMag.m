function [realData] = calibMag(calibData)
dataX = calibData(:,1);
dataY = calibData(:,2);
dataZ = calibData(:,3);

realData = [dataX dataY dataZ];
[ center, R] = ellipsoid_fit(calibData);


realData = realData - (center*ones(1,length(realData)))';
R = R/norm(R);

scaleMatrix = [1/R(1) 0 0;0 1/R(2) 0; 0 0 1/R(3)];

realData = realData*scaleMatrix;