function [Cw,FAeroWind] = stateToForces2(X)
g=32.2;
Vdot=X(1:3);
omega=X(4:6);
V=X(7:9);
Ft=X(10:12);
W=X(13);
alpha=X(14);
beta=X(15);
theta=X(16);
phi=X(17);
qbar=X(18);
psi=X(19);

% Fw=[-W*sin(theta) W*sin(phi)*cos(theta) W*cos(phi)*cos(theta)];
m=W/g;
Sref=88.1100; %actually decently sure about this now

% Cbody=[(m*(Vdot(1)+q*V(3)-r*V(2))-Ft(1)-Fw(1))./(qbar*Sref);
%     (m*(Vdot(2)+r*V(1)-p*V(3))-Ft(2)-Fw(2))./(qbar*Sref);
%     (m*(Vdot(3)+p*V(2)-q*V(1))-Ft(3)-Fw(3))./(qbar*Sref)];
Rib=[cos(theta)*cos(psi) sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);...
    cos(theta)*sin(psi) sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);...
    -sin(theta) sin(phi)*cos(theta) cos(phi)*cos(theta)];

Fw=Rib*[0;0;W];

% FBody=m*Vdot+m*cross(omega,V);
FBody=m*Vdot;

FAeroBody=FBody-Fw'-Ft;
Rbw = [cos(beta)*cos(alpha) sin(beta) cos(beta)*sin(alpha);...
    -sin(beta)*cos(alpha) cos(beta) -sin(beta)*sin(alpha);...
    -sin(alpha) 0 cos(alpha)]; % rotation from body to wind

% Cd=Cbody*[cos(alpha)*cos(beta);-sin(beta);-sin(alpha)];
% Cl=Cbody*[sin(alpha);0;-cos(alpha)];

FAeroWind=Rbw*FAeroBody';

Cw=FAeroWind/(qbar*Sref);