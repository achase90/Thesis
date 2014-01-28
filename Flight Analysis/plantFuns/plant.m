function [state,cAero,fAeroWind]=plant(state,plane)
windAngles = [state.alphaP.data state.betaP.data]*pi/180; %convert to radians for the rotation
% adsR = plane.adsR;
% RAdsAccelP = plane.RAdsAccelP;

g = 32.2087;
m=plane.W.data/g;
accelerometer = [state.accelY.data state.accelX.data state.accelZ.data]; %accelX is negative because of installation
fAeroBody = -m*ones(size(accelerometer)).*accelerometer;

[fAeroWind] = bodyToWind(fAeroBody,windAngles);

for i=1:length(fAeroWind)
    cAeroBody(i,:) = fAeroBody(i,:)/(state.qbar.data(i)*plane.SRef);
    cAero(i,:) = fAeroWind(i,:)/(state.qbar.data(i)*plane.SRef);
end
state.CD.data = -cAero(:,1);
state.CY.data = -cAero(:,2);
state.CL.data = -cAero(:,3);
state.D.data = -fAeroWind(:,1);
state.Y.data = -fAeroWind(:,2);
state.L.data = -fAeroWind(:,3);


state.CD.units = '-';
state.CY.units = '-';
state.CL.units = '-';
state.D.units = 'lbf';
state.Y.units = 'lbf';
state.L.units = 'lbf';