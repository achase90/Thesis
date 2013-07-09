function [xBody]=inertToBody(xInert,eulerAngles,invFlag)
global RibOut

if nargin<3
    invFlag=false;
end
for i=1:length(eulerAngles)
    phi=eulerAngles(i,1);
    theta=eulerAngles(i,2);
    psi=eulerAngles(i,3);
    
    Rib=[cos(theta)*cos(psi) sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);...
        cos(theta)*sin(psi) sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);...
        -sin(theta) sin(phi)*cos(theta) cos(phi)*cos(theta)];
    RibOut(:,:,i)=Rib;
    if invFlag
        Rib=inv(Rib);
    end
    xBody(:,i)=Rib*xInert(i,:)';
end