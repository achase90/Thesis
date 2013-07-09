%{
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
%}
% verbose should be BOOL true or false
function [dF,F,dFdX]=errorProp(plant,state,deltaX)

[dFdX,F]=jacobiancsd(plant,state);

dF=sqrt((dFdX*deltaX').^2);
end