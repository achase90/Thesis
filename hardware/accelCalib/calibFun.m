function rms = calibFun(data,s)
xCalc = s(1)*data(:,1) + s(4);
yCalc = s(2)*data(:,2) + s(5);
zCalc = s(3)*data(:,3) + s(6);

accelCalc = sqrt(xCalc.^2+ yCalc.^2 +zCalc.^2);

rms = sqrt(sum((32.1740 - accelCalc).^2));