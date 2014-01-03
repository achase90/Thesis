clear all,close all,clc
%%
% TODO: Check body coefficients, might be a problem in that conversion.
% in fact, check every step.
%%
% clear all,close all,clc
% close all,clc
clear all,close all,clc
maxIter = 10000;
percErrorPFit = nan(maxIter,3);
percErrorKalman = nan(maxIter,3);
percErrorRobust= nan(maxIter,3);

    load simData_12_10_2013.mat
    tic
run dataReadin
stateNew = state;
CI = 0.95;
for i=1:maxIter
    deltaT = tic;
state = stateNew;
    noise.W = .001;
noise.alpha = 0.25*pi/180; % calibrated accuracy of 1% FS (I have better) in degrees converted rads
noise.beta = 0.25*pi/180; % calibrated accuracy of 1% FS (I have better) in degrees converted rads
noise.accelerometer =  0.0214;
noise.qbar = .26; % 0.5% of 10" H20 to psf

state = addNoise(state,noise);

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

[pFit] = polyfit(CL,CD,2);
[bRegress,bIntRegress]=regress(CD,[ones(length(CL),1) CL CL.^2],CI);
[bRobust,statsRobust] = robustfit([CL CL.^2],CD);
[bKalman,sigmaKalman] = polarKalman([CD CL],state,plane,noise);   

percErrorPFit(i,:) = [100*(KCL2-pFit(1))/pFit(1) 100*pFit(2) 100*(CD0-pFit(3))/pFit(3)];
percErrorKalman(i,:) = [100*(KCL2-bKalman(3))/bKalman(3) 100*bKalman(2) 100*(CD0-bKalman(1))/bKalman(1)];
percErrorRobust(i,:) = [100*(KCL2-bRobust(3))/bRobust(3) 100*bRobust(2) 100*(CD0-bRobust(1))/bRobust(1)];


t=toc;
time2 = toc(deltaT);
if ~mod(i,20)
    fprintf('Finished : %i/%i took %8.2f seconds after %8.2f seconds\n',[i maxIter time2 t])
end
    if ~mod(i,1000)
    figure(1)
scatter(1:maxIter,percErrorPFit(:,1),100,'.b');
hold on
scatter(1:maxIter,percErrorKalman(:,1),100,'.r');
scatter(1:maxIter,percErrorRobust(:,1),100,'.g');
legend('Poly Fit','Kalman','Robust')
ylabel('C_{D_0} Coefficient [-]')
xlabel('Iteration [-]');
hold off

figure(2)
scatter(1:maxIter,percErrorPFit(:,2),100,'.b');
hold on
scatter(1:maxIter,percErrorKalman(:,2),100,'.r');
scatter(1:maxIter,percErrorRobust(:,2),100,'.g');
legend('Poly Fit','Kalman','Robust')
ylabel('C_1 Coefficient [-]')
xlabel('Iteration [-]');
hold off

figure(3)
scatter(1:maxIter,percErrorPFit(:,3),100,'.b');
hold on
scatter(1:maxIter,percErrorKalman(:,3),100,'.r');
scatter(1:maxIter,percErrorRobust(:,3),100,'.g');
legend('Poly Fit','Kalman','Robust')
ylabel('C_2 Coefficient [-]')
xlabel('Iteration [-]');
hold off
    end
end
save monteCarloSim02.mat