% The input to this function is handles, but we only use the "Filtered"
% subset of handles in this function.

% The whole point is to take "Filtered" data and convert it to CL and CD
function [state]=plant(state,plane)


g = 32.2; %todo:do we want to define it like this?
m=plane.W/g;

fn=fieldnames(state);
kk = length(state.(fn{1}).data);

fWInert = [zeros(kk,2) plane.W*ones(kk,1)];
eulerAngles = [state.roll.data state.pitch.data state.yaw.data];

[fWBody] = inertToBody(fWInert,eulerAngles);

phi = state.roll.data;
theta=state.pitch.data;
psi = state.yaw.data;

fWBody = [-plane.W*sin(theta) plane.W*cos(theta).*cos(phi) plane.W*cos(theta).*cos(phi)];

%%
accels = [state.accelX.data state.accelY.data state.accelZ.data];
fAeroBody = m*double(accels) - fWBody;
fTotal=fAeroBody + fWBody;
%todo: define values as doubles in one common place, somewhere. Which
%means, look for all "double" declarations and fix them.

[fAeroWind] = bodyToWind(fAeroBody,[state.alpha.data state.beta.data]);

for i=1:length(fAeroWind)
    cAeroBody(i,:) = fAeroBody(i,:)/(double(state.qbar.data(i))*plane.SRef);
    cAero(i,:) = fAeroWind(i,:)/(double(state.qbar.data(i))*plane.SRef);
end
state.CD.data = -cAero(:,1);
state.CY.data = -cAero(:,2);
state.CL.data = -cAero(:,3);

state.CD.units = '-';
state.CY.units = '-';
state.CL.units = '-';

state.D.units = 'lbf';
state.Y.units = 'lbf';
state.L.units = 'lbf';

state.D.data = -fAeroWind(:,1);
state.Y.data = -fAeroWind(:,2);
state.L.data = -fAeroWind(:,3);

%todo: re-run simulator, with all the functions in this directory and make
%sure they're correct. Also, update noise.