function errorBnd = errorProp(state,plane,noise)

h=1e-2;

%% W contribution
stateP = state;
stateN = state;

stateP.W=state.W+h;
stateN.W = state.W-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

WContrib = (cAeroP-cAeroN)/h;

%% g contribution
stateP = state;
stateN = state;

stateP.gravity=state.gravity+h;
stateN.gravity = state.gravity-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

gContrib = (cAeroP-cAeroN)/h;

%% phi contribution
stateP = state;
stateN = state;

stateP.eulerAngles(:,1)=state.eulerAngles(:,1)+h;
stateN.eulerAngles(:,1) = state.eulerAngles(:,1)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

phiContrib = (cAeroP-cAeroN)/h;

%% theta contribution
stateP = state;
stateN = state;

stateP.eulerAngles(:,2)=state.eulerAngles(:,2)+h;
stateN.eulerAngles(:,2) = state.eulerAngles(:,2)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

thetaContrib = (cAeroP-cAeroN)/h;

%% psi contribution
stateP = state;
stateN = state;

stateP.eulerAngles(:,3)=state.eulerAngles(:,3)+h;
stateN.eulerAngles(:,3) = state.eulerAngles(:,3)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

psiContrib = (cAeroP-cAeroN)/h;

%% accelX contribution
stateP = state;
stateN = state;

stateP.accel(:,1)=state.accel(:,1)+h;
stateN.accel(:,1) = state.accel(:,1)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

accelXContrib = (cAeroP-cAeroN)/h;

%% accelY contribution
stateP = state;
stateN = state;

stateP.accel(:,1)=state.accel(:,1)+h;
stateN.accel(:,1) = state.accel(:,1)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

accelYContrib = (cAeroP-cAeroN)/h;

%% accelZ contribution
stateP = state;
stateN = state;

stateP.accel(:,3)=state.accel(:,3)+h;
stateN.accel(:,3) = state.accel(:,3)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

accelZContrib = (cAeroP-cAeroN)/h;

%% alpha contribution
stateP = state;
stateN = state;

stateP.windAngles(:,1)=state.windAngles(:,1)+h;
stateN.windAngles(:,1) = state.windAngles(:,1)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

alphaContrib = (cAeroP-cAeroN)/h;

%% beta contribution
stateP = state;
stateN = state;

stateP.windAngles(:,2)=state.windAngles(:,2)+h;
stateN.windAngles(:,2) = state.windAngles(:,2)-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

betaContrib = (cAeroP-cAeroN)/h;

%% qbar contribution
stateP = state;
stateN = state;

stateP.qbar=state.qbar+h;
stateN.qbar = state.qbar-h;
[cAeroP] = plant(stateP,plane);
[cAeroN] = plant(stateN,plane);

qbarContrib = (cAeroP-cAeroN)/h;

%% total
noise.eulerAngles = noise.eulerAngles*pi/180;
noise.windAngles = noise.windAngles*pi/180;

errorBnd = sqrt((WContrib*noise.W).^2+(gContrib*noise.gravity).^2+(phiContrib*noise.eulerAngles).^2+...
    (thetaContrib*noise.eulerAngles).^2+(psiContrib*noise.eulerAngles).^2+(accelXContrib*noise.accel).^2+...
    (accelYContrib*noise.accel).^2+(accelZContrib*noise.accel).^2+(alphaContrib*noise.windAngles).^2+...
    (betaContrib*noise.windAngles).^2+(qbarContrib*noise.qbar).^2);