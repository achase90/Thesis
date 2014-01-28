function [alpha,beta,alphaNoise,betaNoise] = pressureToAngles(data,adsR)
%adsR is rotation from body to probe's accel
load probeCalibData.mat

%{
Pressure 0 : beta
Pressure 1 : q
Pressure 2 : alpha
Pressure 3 : static
%}

cAlpha = -data.press2.data./data.press1.data; %pressure coefficients
cBeta = data.press0.data./data.press1.data;
[r1 r2 r3] = dcm2angle(adsR);

% alpha1 = interp1(cAlphaCalib,alphaCalib,cAlpha)-(pi/2+r3)*180/pi; %lookup table
% beta1 = interp1(cBetaCalib,betaCalib,cBeta)-(r1-pi/2)*180/pi;
% alpha = alpha1*cos(r2)+beta1*sin(r2);
% beta = alpha1*sin(r2)+beta1*cos(r2);
alpha = interp1(cAlphaCalib,alphaCalib,cAlpha)+6; %todo: go back to above lines when you have new alignment calibration
beta = interp1(cBetaCalib,betaCalib,cBeta);

cAlphaNoise = sqrt((data.press2.noise./data.press1.data).^2+((data.press2.noise./data.press1.data.^2)*data.press1.noise).^2); %pressure coefficients
cBetaNoise = sqrt((data.press0.noise./data.press1.data).^2+((data.press0.noise./data.press1.data.^2)*data.press1.noise).^2); %pressure coefficients

alphaNoise = interp1(cAlphaCalib,alphaCalib,cAlphaNoise); %lookup table
betaNoise = interp1(cBetaCalib,betaCalib,cBetaNoise);