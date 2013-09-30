function [alpha,beta] = pressureToAngles(data)

load probeCalibData.mat

% P16 = P1 - P6;
% P23 = P2 - P6;
% P45 = P3 - P6;
cAlpha = P45./P16;
cBeta = P23./P16;

alpha = interp1(cAlphaCalib,alphaCalib,cAlpha);
beta = interp1(cBetaCalib,betaCalib,cBeta);