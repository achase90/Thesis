function accel=plantInverse(fAero,FT,FW,windAngles,eulerAngles)

fAeroBody=bodyToWind(fAero,windAngles,true); %not sure you can take the
%inverse of a matrix like I am  here. might want to check
FW=[zeros(size(FW)) zeros(size(FW)) FW];
FWBody=inertToBody(FW,eulerAngles);
fBody=fAeroBody+FT'+FWBody;

for i=1:length(FW)
    m=norm(FW(i,:))/32.2;
end

accel=fBody./m;