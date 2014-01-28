function [adsR] = alignCalib(accel,adsAccel)
adsAccel = normr(adsAccel);
accel = normr(accel);
gp = adsAccel';
gb = accel';
adsR = (gp*gb')\(gb*gb');