function [xWind]=bodyToWind(xBody,windAngles,adsR)

for i=1:length(windAngles)
    alpha=windAngles(i,1);
    beta=windAngles(i,2);
    
    RpW = [cos(beta)*cos(alpha) sin(beta) cos(beta)*sin(alpha);...
        -sin(beta)*cos(alpha) cos(beta) -sin(beta)*sin(alpha);...
        -sin(alpha) 0 cos(alpha)]; %rotation from probe to wind vector
    
    RbP = adsR; %rotation from body to probe orientation
    
    xWind(i,:)=(RpW*RbP*xBody(i,:)')';
end