function [covCw,errorVal,funValue,percentError] = vectorErrorProp(state,covState)
g = 32.2;
psi = 0; %set to 0 to override built in matlab function
alpha = 0;%set to 0 to override built in matlab function
beta = 0;%set to 0 to override built in matlab function

%% make symbolic variables
syms theta;
syms phi;
syms psi;
syms alpha;
syms beta;
syms W;
syms Tx;
syms Ty;
syms Tz;
syms ax;
syms ay;
syms az;

X = [theta;phi;psi;alpha;beta;W;Tx;Ty;Tz;ax;ay;az];

T = [Tx;Ty;Tz];
a = [ax;ay;az];

Rvb = [cos(theta)*sin(psi) cos(theta)*sin(psi) -sin(theta);...
    sin(theta)*sin(phi)*cos(psi)-cos(phi)*sin(psi) sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*cos(theta);...
    cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(psi)*sin(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*cos(theta)];

Rbw = [cos(beta)*cos(alpha) sin(beta) cos(beta)*sin(alpha);...
    -sin(beta)*cos(alpha) cos(beta) -sin(beta)*sin(alpha);...
    -sin(alpha) 0 cos(alpha)];

WVec=[0;0;W];

Cw = Rbw*[W*a/g-T-Rvb*WVec];

J = jacobian(Cw,X);

covCw = J*covState;

errorVal = subs(covCw,X,state);

funValue = subs(Cw,X,state);

percentError=100*errorVal./funValue;
