function [cAero,fAeroWind,cAeroBody]=plant(state,plane)
windAngles = [state.alpha state.beta];

g = state.gravity;
m=state.W/g(1);

fAeroBody = repmat(-m,1,3).*state.accelerometer;

[fAeroWind] = bodyToWind(fAeroBody,windAngles);

for i=1:length(fAeroWind)
    cAeroBody(i,:) = fAeroBody(i,:)/(state.qbar(i)*plane.Sref);
    cAero(i,:) = fAeroWind(i,:)/(state.qbar(i)*plane.Sref);
end

