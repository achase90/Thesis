clear all,close all,clc

%%
% TODO: Check body coefficients, might be a problem in that conversion.
% in fact, check every step.
%%
% clear all,close all,clc
% close all,clc
clear all,close all,clc
maxIter = 100;
    load simData_4_24_2013.mat
    tic

for i=1:maxIter
        run dataReadin

    %% Noise settings
    % noise.eulerAngles = 2; %deg
    % noise.euleRates = .1; %deg/s
    % noise.windAngles = 2; %deg
    % noise.accel = 1; %ft/s/s
    % noise.qbar = .25; %psf
    % noise.gravity = -.01; %ft/s/s
    noise.eulerAngles = 1; %deg
    noise.eulerRates = .1; %deg/s
    noise.windAngles = 3; %deg
    noise.accel = .1; %ft/s/s
    noise.qbar = .25; %psf
    noise.gravity = 0; %ft/s/s
    noise.W = .001;
    
    state = addNoise(state,noise);
    
%     errorBnd = errorProp(state,plane,noise);
    
    %%
    state = eulerKalman(state,noise);
    state = windKalman(state,noise);
    
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
    
    [pFit] = polyfit(CL,CD,2);
%     
%     fprintf('Input values : \n\n')
%     fprintf('%15.4f %15.4f %15.4f\n\n',[KCL2 0 CD0]);
%     fprintf('Percent Error : \n\n')
%     fprintf('%15.4f %15.4f %15.4f\n\n',[100*(KCL2-pFit(1))/pFit(1) 100*pFit(2) 100*(CD0-pFit(3))/pFit(3)]);
    percError(i,:) = [100*(KCL2-pFit(1))/pFit(1) 100*pFit(2) 100*(CD0-pFit(3))/pFit(3)];
    t=toc;
    fprintf('Finished : %i/%i in %8.2f seconds\n',[i maxIter t])
end

f=figure;
scatter(1:i,percError(:,1),100,'.b');
ylabel('CD0')

f=figure;
scatter(1:i,percError(:,3),100,'.b');
ylabel('KCL2')