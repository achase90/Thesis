clear all,close all,clc

%% Desired error values as a percent
kError(1)=.05;
kError(2)=100; %set large so it doesn't influence the decision
kError(3)=.05;

%%
M=xlsread('statesAndSigmas.xlsx','','B7:S9');
sigmas=M(1,:);
state=M(2,:);
deltaXKnown=M(3,:);

sigmaXKnown=deltaXKnown.^2;

[J,F]=jacobiancsd(@stateToForces2,state);

dFDesired=F.*kError';% find percent error desired
sigF=dFDesired.^2;
sigTemp=sigF-J.^2*sigmaXKnown';
sigRemain=length(state)-length(sigmaXKnown(sigmaXKnown>0));

for i=1:length(state)
    for j=1:length(F)
    if sigmaXKnown(i)==0
                desiredSigmas(i,j)=(1/J(j,i)^2)*sigTemp(j)/sigRemain;
    else
        desiredSigmas(i,j)=sigmaXKnown(i);
    end
    end
end
desiredDeltaX=sqrt(min(desiredSigmas,[],2));

%% handle units
desiredDeltaX(4:6)=desiredDeltaX(4:6)*180/pi; %rad to deg
desiredDeltaX(10:12)=desiredDeltaX(10:12)*16; %lb to oz
desiredDeltaX(14:17)=desiredDeltaX(14)*180/pi;%rad to deg

%% print results
chosen=strvcat((sigmaXKnown==0)'*'no '+(sigmaXKnown~=0)'*'yes');
% chosen=strvcat((sigmaXKnown~=0)'*'yes');
titles=strvcat('ax','ay','az','p','q','r','u','v','w','Tx','Ty','Tz','W','alpha','beta','theta','phi','qbar');
units=strvcat('ft/s^2','ft/s^2','ft/s^2','deg/s','deg/s','deg/s','ft/s','ft/s','ft/s','oz','oz','oz','lb','deg','deg','deg','deg','psf');
[a,b]=size(titles);
kk=' '*ones(a,b);
% Jacobian=[num2str(100*abs(J'),3),kk,titles]; % this doesn't tell you much without the order of expected error
% disp(sprintf('  Drag   Side Force    Lift'))
% disp(Jacobian)
Required_sensors=[kk,num2str(desiredDeltaX,3),kk,kk,titles,kk,units,kk,chosen];
disp(sprintf('Sensor requirements for %3.1f%s accuracy on lift and %3.1f%s on drag',100*kError(3),'%',100*kError(1),'%'))
disp(sprintf(' Required Accuracy    State       Units        Chosen?'))
disp(Required_sensors);
disp(sprintf('\n'))