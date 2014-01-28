function errorBnd = errorProp(handles)
state=handles.data.State;
plane = handles.plane;
h=1e-2;

%% W contribution
% [WContrib,totalError] = partial(state,plane,h,'W');
totalError = 0;
%% accelX contribution
[accelXContrib,error] = partial(state,plane,h,'accelX');
totalError = totalError+error;

%% accelY contribution
[accelYContrib,error] = partial(state,plane,h,'accelY');
totalError = totalError+error;

%% accelZ contribution
[accelZContrib,error] = partial(state,plane,h,'accelZ');
totalError = totalError+error;

%% alpha contribution
[alphaContrib,error] = partial(state,plane,h,'alphaP');
totalError = totalError+error;

%% beta contribution
[betaContrib,error] = partial(state,plane,h,'betaP');
totalError = totalError+error;

%% qbar contribution
[qbarContrib,error] = partial(state,plane,h,'qbar');
totalError = totalError+error;

%% total
errorBnd = sqrt(totalError);
function [contrib,totalContrib] = partial(state,plane,step,fieldname)
if strcmpi(fieldname,'alphaP') | strcmpi(fieldname,'betaP')
    state.(fieldname).data = state.(fieldname).data*pi/180;
end
stateP = state;
stateN = state;

stateP.(fieldname).data=state.(fieldname).data+step;
stateN.(fieldname).data = state.(fieldname).data-step;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

contrib = ([cAeroP.CD.data-cAeroN.CD.data cAeroP.CL.data-cAeroN.CL.data])/step;
for i = 1:length(contrib)
totalContrib(i,:) = (contrib(i,:)*state.(fieldname).noise(i)).^2;
end