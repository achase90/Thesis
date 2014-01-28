function [xWind]=bodyToWind(xBody,windAngles)

for i=1:length(windAngles)
%     alphaP(i)=windAngles(i,1)+r1; %calibrated to remove pitch angle of accel to mount
%     betaP(i)=windAngles(i,2)+r3; %calibrated to remove yaw angle of accel to mount
        alphaP(i)=windAngles(i,1);
    betaP(i)=windAngles(i,2); 

    RpW = [cos(betaP(i))*cos(alphaP(i)) sin(betaP(i)) cos(betaP(i))*sin(alphaP(i));...
        -sin(betaP(i))*cos(alphaP(i)) cos(betaP(i)) -sin(betaP(i))*sin(alphaP(i));...
        -sin(alphaP(i)) 0 cos(alphaP(i))]; %rotation from probe to wind vector

    xWind(i,:)= RpW*xBody(i,:)';
end