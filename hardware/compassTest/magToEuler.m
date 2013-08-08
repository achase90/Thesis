function [roll,pitch,yaw] = magToEuler(magX,magY,magZ)

R = sqrt(magX^2+magY^2+magZ^2);

roll = acos(magX/R);

pitch = acos(magY/R);

yaw = acos(magZ/R);