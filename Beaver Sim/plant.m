function [cAero,fAeroWind,cAeroBody]=plant(state,plane)
global fWBody
global fTotal

g = state.gravity;
global m
m=state.W/g(1);

kk = length(state.accel);

fWInert = [zeros(kk,2) state.W*ones(kk,1)];

[fWBody] = inertToBody(fWInert,state.eulerAngles);
phi = state.eulerAngles(:,1);
theta=state.eulerAngles(:,2);
psi = state.eulerAngles(:,3);

fWBody = [-state.W*sin(theta) state.W*cos(theta).*sin(phi) state.W*cos(theta).*cos(phi)];
%%
% p = state.eulerRates(:,1);
% q = state.eulerRates(:,2);
% r = state.eulerRates(:,3);
% u = state.vBodyEarth(:,1);
% v = state.vBodyEarth(:,2);
% w = state.vBodyEarth(:,3);
% 
% coriolis = [q.*w-r.*v r.*u-p.*w p.*v-q.*u];
    
%%
% fAeroBody = m*state.accel + m*cross(state.vBody,state.eulerRates,2) - state.fThrust - fWBody;
fAeroBody = m*state.accel - state.fThrust - fWBody;
fTotal=fAeroBody + state.fThrust+fWBody;
% state.windAngles(:,2)=0;
% state.windAngles = zeros(size(state.windAngles));
% state.windAngles(:,2) = tan(state.windAngles(:,2))./cos(state.windAngles(:,1));
[fAeroWind] = bodyToWind(fAeroBody,state.windAngles);
% fAeroWind(:,3) = fAeroWind(:,3).*cos(state.windAngles(:,2))-fAeroWind(:,2).*sin(state.windAngles(:,2));
% fAeroWind(:,3) = (fAeroWind(:,3) + fAeroWind(:,2).*sin(state.windAngles(:,2)))./cos(state.windAngles(:,2));

for i=1:length(fAeroWind)
    cAeroBody(i,:) = fAeroBody(i,:)/(state.qbar(i)*plane.Sref);
    cAero(i,:) = fAeroWind(i,:)/(state.qbar(i)*plane.Sref);
end

