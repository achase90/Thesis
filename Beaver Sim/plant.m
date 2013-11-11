function [cAero,fAeroWind,cAeroBody]=plant(state,plane)

g = state.gravity;
m=state.W/g(1);

fAeroBody = -m*state.accelerometer;

[fAeroWind] = bodyToWind(fAeroBody,state.windAngles);

for i=1:length(fAeroWind)
    cAeroBody(i,:) = fAeroBody(i,:)/(state.qbar(i)*plane.Sref);
    cAero(i,:) = fAeroWind(i,:)/(state.qbar(i)*plane.Sref);
end

