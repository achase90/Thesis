function [adsR] = alignCalib(accel,adsAccel)
gp = adsAccel';
gb = accel';
adsR = (gp*gb')\(gb*gb');