clear all,close all,clc

load simData_12_10_2013.mat


run dataReadin

%% Noise settings
noise.alpha = 0.25*pi/180; % calibrated accuracy of 1% FS (I have better) in degrees converted rads
noise.beta = 0.25*pi/180; % calibrated accuracy of 1% FS (I have better) in degrees converted rads
noise.accelerometer =  0.0214;
noise.qbar = .26; % 0.5% of 10" H20 to psf

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
