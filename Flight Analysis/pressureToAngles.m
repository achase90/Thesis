function [alpha,beta] = pressureToAngles(data)

torr2psf = 2.784495557;
load probeCalibData.mat

P1 = P1Torr*torr2psf;
P2 = P2Torr*torr2psf;
P3 = P3Torr*torr2psf;
P4 = P4Torr*torr2psf;
P5 = P5Torr*torr2psf;
P6 = P6Torr*torr2psf;
PrefAbs = PrefAbsTorr*torr2psf;
PsAbs = PsAbsTorr*torr2psf;
Pt = PtTorr*torr2psf;
T = 9*TsC/5 + 32.2;

alpha = 0;
beta = 0;