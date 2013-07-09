% clear all,close all,clc
% close all,clc
close all,clc
clear state
clear plane
maxIter = 10000;
for i = 1:maxIter
    
    run dataReadin
    %% Noise settings
    eulerAngAcc = 1; %deg
    windAngAcc = 2; %deg
    accelAcc = .322; %ft/s/s
    qbarAcc = .01; %psf
    gravityAcc = -.01; %ft/s/s
    
    %% Add noise in
    state.eulerAngles = state.eulerAngles + normrnd(0,eulerAngAcc*pi/180,size(state.eulerAngles));
    state.windAngles = state.windAngles + normrnd(0,windAngAcc*pi/180,size(state.windAngles));
    state.accel = state.accel + normrnd(0,accelAcc,size(state.accel));
    state.qbar = state.qbar + normrnd(0,qbarAcc,size(state.qbar));
    state.gravity = state.gravity+gravityAcc;
    
    %% Noise values
    % eulerAnglesNoise = normrnd(0,.1)
    %%
    [cAero,fAero,cAeroBody]=plant(state,plane);
    simDrag = -state.drag;
    simLift = -state.lift;
    simSide = -state.side;
    simCD = -state.cDrag;
    simCL = -state.cLift;
    simCY = -state.cSide;
    
    CD = -cAero(:,1);
    CY = -cAero(:,2);
    CL = -cAero(:,3);
    drag = -fAero(:,1);
    side = -fAero(:,2);
    lift = -fAero(:,3);
    
    time=state.time;
    
    pFit = polyfit(CL,CD,2);
    percError(:,i) = [100*(KCL2-pFit(1))/pFit(1) 100*pFit(2) 100*(CD0-pFit(3))/pFit(3)];
    clear state plant
    
    if ~mod(i,10)
        fprintf('Progress : %i iterations of %i\n',[i,maxIter]);
    end
end
%% Plots

marksize=100;
marktype='.';

%% Polar plot
f=figure(1);
set(f,'name','KCL2 Error','numbertitle','off');
scatter(1:i,percError(1,:),marksize,marktype)
xlabel('Iteration [-]')
ylabel('Percent Error')
title('Error in KCL2')

f=figure(2);
set(f,'name','Second Term Error','numbertitle','off');
scatter(1:i,percError(2,:),marksize,marktype)
xlabel('Iteration [-]')
ylabel('Percent Error')
title('Error in Second Term')

f=figure(3);
set(f,'name','CD0 Error','numbertitle','off');
scatter(1:i,percError(3,:),marksize,marktype)
xlabel('Iteration [-]')
ylabel('Percent Error')
title('Error in CD0')
