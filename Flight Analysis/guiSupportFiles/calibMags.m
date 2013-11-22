function [HMR2300,HMC5883,MHmrToHmc,rmsHMR2300,rmsHMC5883] = calibMags(HMR2300,HMC5883,calibFile)
calibData = dlmread(calibFile,'\t',2,0);

hmrCalib = calibData(:,2:4);
hmcCalib = calibData(:,5:7);

%iron corrections for both
[HMR2300,rmsHMR2300] = iron(HMR2300,hmrCalib);
[HMC5883,rmsHMC5883] = iron(HMC5883,hmcCalib);

%alignment of one to the other
MHmrToHmc = pinv(HMR2300)*HMC5883;

function [dataOut,rms] = iron(flightData,calibData)
[center, R] = ellipsoid_fit(calibData);

dataOut = flightData - (center*ones(1,length(flightData)))';

scaleMatrix = [1/R(1) 0 0;0 1/R(2) 0; 0 0 1/R(3)];

dataOut = dataOut*scaleMatrix;

%dataOut should be scaled to a sphere with radius = 1. Any different than
%that is considered noise

%todo: what units should noise be in?
for i=1:length(calibData)
expectedData = norm(dataOut(i,:));
end
rms = sqrt((expectedData-1)^2);
