function X=randState(XStd)
W=3;
if nargin<1
    XStd=[.2*32.2,.1*32.2,.2*32.2,...
        10,10,10,...
        10,3,6,...
        .1,.01,.01,...
        .001,...
        2,2,2,2,...
        1];
end
% Vdot=X(1:3);
% omega=X(4:6);
% V=X(7:9);
% Ft=X(10:12);
% W=X(13);
% alpha=X(14);
% beta=X(15);
% theta=X(16);
% phi=X(17);
% qbar=X(18);
XMean=[0 0 0 0 0 0 40 0 0 1 0 0 W 4 0 0 0 20];
X=normrnd(0,XStd)+XMean;
