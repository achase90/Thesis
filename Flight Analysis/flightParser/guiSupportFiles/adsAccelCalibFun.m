load adsAccelCalib.mat

[s1,fval] = accelCalib(accelData);

% apply scale and zero offset corrections to accel
accelX = s1(1)*accel(:,1)+s1(4);
accelY = s1(2)*accel(:,2)+s1(5);
accelZ = s1(3)*accel(:,3)+s1(6);

roll = accelZ./sqrt(accelX.^2+accelY.^2);
pitch = atan2(-accelX,accelY);

pitch = mean(pitch);
roll = mean(roll);