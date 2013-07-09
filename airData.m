%% Inputs
%{
minSpeed = minimum flight speed, mph
maxSpeed = maximum flight speed,mph
CPdeg = CP/deg of the angle probe
qSense = one sided qbar sensor range, in inches of water
angSense = one sided angle sensor range, in inches of water


%}
%%
function [angAcc,qAcc,maxAng,maxSpeedSense]=airData(minSpeed,maxSpeed,CPdeg,qSense,angSense)
minSpeed = minSpeed*5280/3600;
maxSpeed = maxSpeed*5280/3600;
qSense=qSense*5.2; %convert inch water to psf
angSense = angSense*5.2; %convert inch water to psf

maxSpeedSense = (qSense/(.5*.00237))^.5;

qbarMax = maxSpeed^2*.5*.00237;

qbarMin = minSpeed^2*.5*.00237;

if qbarMax > qSense
    warning('Max flight speed greater than range of sensor');
end

maxAng = angSense/qbarMax/CPdeg;

LSBAng = 2*angSense/(2^14);

LSBqbar = 2*qSense/(2^14);

angAcc = 3*LSBAng/qbarMin/CPdeg;

qAcc = 3*LSBqbar/qbarMin/CPdeg;