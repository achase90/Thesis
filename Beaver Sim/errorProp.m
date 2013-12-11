function errorBnd = errorProp(state,plane,noise)

h=1e-2;

%% W contribution
[WContrib,totalError] = partial(state,plane,noise,h,'W');
%% accelX contribution
[accelerometerContrib,error] = partial(state,plane,noise,h,'accelerometer');
totalError = totalError+error;

%% alpha contribution
[alphaContrib,error] = partial(state,plane,noise,h,'alpha');
totalError = totalError+error;

%% beta contribution
[betaContrib,error] = partial(state,plane,noise,h,'beta');
totalError = totalError+error;

%% qbar contribution
[qbarContrib,error] = partial(state,plane,noise,h,'qbar');
totalError = totalError+error;

%% total
errorBnd = sqrt(totalError);

function [contrib,totalContrib] = partial(state,plane,noise,step,fieldname)
stateP = state;
stateN = state;

stateP.(fieldname)=state.(fieldname)+step;
stateN.(fieldname) = state.(fieldname)-step;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

contrib = (cAeroP-cAeroN)/step;

totalContrib = (contrib*noise.(fieldname)).^2;