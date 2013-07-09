function [xWind]=bodyToWind(xBody,windAngles,invFlag)
global RbwOut

if nargin<3
    invFlag=false;
end
for i=1:length(windAngles)
    alpha=windAngles(i,1);
    beta=windAngles(i,2);
    
    
    Rbw = [cos(beta)*cos(alpha) sin(beta) cos(beta)*sin(alpha);...
        -sin(beta)*cos(alpha) cos(beta) -sin(beta)*sin(alpha);...
        -sin(alpha) 0 cos(alpha)];
    RbwOut(:,:,i)=Rbw;
    if invFlag
        Rbw=inv(Rbw);
    end
    
    xWind(:,i)=Rbw*xBody(i,:)';
end