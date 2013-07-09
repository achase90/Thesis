function [cAero,fAero]=plant(state,plane)
g=state.g;

WVec=state.W*[0 0 1];
% QUESTION: if we really need a negative sign in the accelFun, does 
%that change our rotation matrices?
fWBody=inertToBody(WVec,state.eulerAngles);

m=state.W/g;

for i=1:length(m)
%     fBody(:,i)=m(i)*state.accel(i,:)+m(i)*cross(state.omega(i,:),state.V(i,:));
    fBody(:,i)=m(i)*state.accel(i,:); %% NOTE: XPLANE DOES NOT SUPPORT ROTATING EARTH

end
fAeroBody=fBody'-fWBody'-state.thrust;

% QUESTION: if we really need a negative sign in the accelFun, does 
%that change our rotation matrices?
fAero=bodyToWind(fAeroBody,state.windAngles);


% for i=1:length(fAero)
%     state.qbar(i)=nan;
%     cAero(:,i)=fAero(:,i)./(state.qbar(i)*plane.Sref);
% end
cAero=nan(size(fAero));

fAero=fAero';