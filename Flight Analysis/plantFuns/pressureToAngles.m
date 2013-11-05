function [alpha,beta] = pressureToAngles(data)

load probeCalibData.mat

% P16 = P1 - P6;
% P23 = P2 - P6;
% P45 = P3 - P6;
%TODO: check if these are mapping to the correct pressure transducers
%TEMPORARY
cAlpha = data.press0.data./data.press1.data;
cBeta = data.press0.data./data.press1.data;
%TEMPORARY
cAlpha = rand(size(data.press0.data));
cBeta = rand(size(data.press0.data));

alpha = interp1(cAlphaCalib,alphaCalib,cAlpha);
beta = interp1(cBetaCalib,betaCalib,cBeta);