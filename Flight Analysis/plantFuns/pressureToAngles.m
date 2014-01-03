function [alpha,beta,alphaNoise,betaNoise] = pressureToAngles(data)

load probeCalibData.mat

%{
Pressure 0 : beta
Pressure 1 : q
Pressure 2 : alpha
Pressure 3 : static
%}

cAlpha = data.press2.data./data.press1.data; %pressure coefficients
cBeta = data.press0.data./data.press1.data;

alpha = interp1(cAlphaCalib,alphaCalib,cAlpha); %lookup table
beta = interp1(cBetaCalib,betaCalib,cBeta);

cAlphaNoise = sqrt((data.press2.noise./data.press1.data)^2+((data.press2.noise./data.press1.data.^2)*data.press1.noise)^2); %pressure coefficients
cBetaNoise = sqrt((data.press0.noise./data.press1.data)^2+((data.press0.noise./data.press1.data.^2)*data.press1.noise)^2); %pressure coefficients

alphaNoise = interp1(cAlphaCalib,alphaCalib,cAlphaNoise); %lookup table
betaNoise = interp1(cBetaCalib,betaCalib,cBetaNoise);