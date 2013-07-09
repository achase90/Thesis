function [coeffCw,Cw] = stateToForces(X)
g=32.2;

T=X(1); %thrust in body axes
q=X(2);  %dynamic pressure
deltaT=X(3); %thrust angle, in radians
ax=X(4); % x axis acceleration, in body axes
ay=X(5);% y axis acceleration, in body axes
az=X(6);% z axis acceleration, in body axes
theta=X(7);%pitch angle, in radians
phi=X(8); %roll angle, in radians
psi=X(9);%heading angle, in radians
alpha=X(10);%angle of attack in radians
beta=X(11); %side slip angle, in radians
W=X(12); % weight (scalar)
Sref=2.333; %wing area in ft^2

T = [T*cos(deltaT);0;-T*sin(deltaT)]; % in body reference frame
a = [ax;ay;az]; % in body axes

Rvb = [cos(theta)*cos(psi) cos(theta)*sin(psi) -sin(theta);...
    sin(theta)*sin(phi)*cos(psi)-cos(phi)*sin(psi) sin(phi)*sin(theta)*sin(psi)-cos(phi)*cos(psi) sin(phi)*cos(theta);...
    cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*cos(theta)];% rotation from ned to body

% Rbv=[cos(theta)*cos(psi),sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi),cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
% cos(theta)*sin(psi),sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi),cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
% -sin(theta),sin(phi)*cos(theta),cos(phi)*cos(theta)];

Rbw = [cos(beta)*cos(alpha) sin(beta) cos(beta)*sin(alpha);...
    -sin(beta)*cos(alpha) cos(beta) -sin(beta)*sin(alpha);...
    -sin(alpha) 0 cos(alpha)]; % rotation from body to wind

WVec=[0;0;W]; % in NED reference frame

Cw = Rbw*(W*a/g-T-Rvb*WVec);

coeffCw=Cw/(q*Sref);