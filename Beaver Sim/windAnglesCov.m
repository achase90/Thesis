function [sigmaAlpha] = windAnglesCov(state,noise,i)
u = state.vBodyBody(i,1);
v = state.vBodyBody(i,2);
w = state.vBodyBody(i,3);

sigmaU = noise.GPSSpeed;
sigmaV = sigmaU;
sigmaW = sigmaU;

sigmaTheta = noise.eulerAngles;

sigmaAlpha = [ -(u*w)/((u^2 + v^2)^(3/2)*(w^2/(u^2 + v^2) + 1)),...
    -(v*w)/((u^2 + v^2)^(3/2)*(w^2/(u^2 + v^2) + 1)),...
    1/((u^2 + v^2)^(1/2)*(w^2/(u^2 + v^2) + 1)), 1]*[sigmaU;sigmaV;sigmaW;sigmaTheta];