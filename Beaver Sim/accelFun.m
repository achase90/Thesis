function [accelNoG,V]=accelFun(accel,eulerAngles,time,V0)

if nargin<4
    V0=zeros(3,1);
end

%% Remove gravity component
downVec=ones(length(eulerAngles),1)*[0 0 1];
[gVec]=inertToBody(downVec,eulerAngles);
accelNoG=accel-gVec';

%% Change units to ft/s/s
accelNoG=accelNoG*32.2;

%% Integrate to get velocity in ft/s
V(:,1) = cumtrapz(time,accelNoG(:,1))+V0(1);
V(:,2) = cumtrapz(time,accelNoG(:,2))+V0(2);
V(:,3) = cumtrapz(time,accelNoG(:,3))+V0(3);