function [state,cAero,fAeroWind]=plant(state,plane)
windAngles = [state.alphaP.data state.betaP.data]*pi/180; %convert to radians for the rotation
adsR = plane.adsR;

g = 32.174;
m=plane.W/g;
accelerometer = [state.accelX.data state.accelY.data state.accelZ.data];
fAeroBody = -m*ones(size(accelerometer)).*accelerometer;

[fAeroWind] = bodyToWind(fAeroBody,windAngles,adsR);

for i=1:length(fAeroWind)
    cAeroBody(i,:) = fAeroBody(i,:)/(state.qbar.data(i)*plane.SRef);
    cAero(i,:) = fAeroWind(i,:)/(state.qbar.data(i)*plane.SRef);
end
state.CD = cAero(:,1);
state.CY = cAero(:,2);
state.CL = cAero(:,3);
state.D = fAeroWind(:,1);
state.Y = fAeroWind(:,2);
state.L = fAeroWind(:,3);