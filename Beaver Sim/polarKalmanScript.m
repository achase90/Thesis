clear all,close all,clc

load simData_5_9_2013.mat


run dataReadin

%% Noise settings
% noise.eulerAngles = 2; %deg
% noise.euleRates = .1; %deg/s
% noise.windAngles = 2; %deg
% noise.accel = 1; %ft/s/s
% noise.qbar = .25; %psf
% noise.gravity = -.01; %ft/s/s
noise.eulerAngles = .01; %deg
noise.eulerRates = .0875; %deg/s
noise.windAngles = 2; %deg
noise.accel = .0483; %ft/s/s
noise.qbar = 0; %psf
noise.gravity = .01; %ft/s/s
noise.W = 0.001;
noise.GPSSpeed=.1*3.28;

% state.gravity = state.gravity+noise.gravity;
state = addNoise(state,noise);

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

time=state.time;

regCoeffs = polarKalman([CD CL],state,plane,noise)';

figure(1)
subplot(2,1,1)
scatter(1:length(regCoeffs),regCoeffs(:,1),100,'.r')
hold on
plot(1:length(regCoeffs),CD0*ones(size(regCoeffs(:,1))),'--k')
ylabel('C_{D_0}')

subplot(2,1,2)
scatter(1:length(regCoeffs),regCoeffs(:,2),100,'.r');
hold on
plot(1:length(regCoeffs),KCL2*ones(size(regCoeffs(:,2))),'--k')
ylabel('K2')


fprintf('Input values : \n\n')
fprintf('%15.4f %15.4f %15.4f\n\n',[CD0 0 KCL2]);
fprintf('Percent Error : \n\n')
fprintf('%15.4f %15.4f %15.4f\n\n',[100*(CD0-regCoeffs(end,1))/CD0 100*(KCL2-regCoeffs(end,2))/KCL2]);
fprintf('\n')
