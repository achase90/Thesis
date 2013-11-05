%%
% close all,clc
clear all,clc

% load simData_5_9_2013.mat

% run dataReadin
[state] = fileParser(filename);

CI = .05;
%% Noise settings
noise.eulerAngles = .5; %deg
noise.eulerRates = .0875; %deg/s
noise.windAngles = .5; %deg
noise.accel = .0483; %ft/s/s
noise.qbar = .008; %psf
noise.gravity = .01; %ft/s/s
noise.W = 0.001;
% noise.GPSSpeed=.1*3.28;
% errorBnd = errorProp(state,plane,noise);

%% Estimate coefficients
state = eulerKalman(state,noise);
% state = windAngleCalc(state,noise);
state = windKalman(state,noise);

[cAero,fAero,cAeroBody]=plant(state,plane);

CD = -cAero(:,1);
CY = -cAero(:,2);
CL = -cAero(:,3);
drag = -fAero(:,1);
side = -fAero(:,2);
lift = -fAero(:,3);
time=state.time;

%% Fits
% [hHoriz,hVert,hPoints] = errorbar2(CD,CL,[errorBnd(:,1) errorBnd(:,3)]);

% fit simple polynomial
[pFit] = polyfit(CL,CD,2);
% use regress to get confidence interval of polyfit regression (this
% doesn't produce a fit, just CIs)
[bRegress,bIntRegress]=regress(CD,[ones(length(CL),1) CL CL.^2],CI);

% find heteroskedastically robust confidence interval estimates and
% regression
[bRobust,statsRobust] = robustfit([CL CL.^2],CD);
fprintf(' Estimated coefficients : \n')
fprintf('%15.4f %15.4f %15.4f\n\n',[bRegress(3) bRegress(2) bRegress(1)]);
fprintf(' Estimated coefficients using ''robustfit'' function: \n')
fprintf('%15.4f %15.4f %15.4f\n\n',[bRobust(3) bRobust(2) bRobust(1)]);


%% output confidence intervals
% confidence interval that are not heteroskedastically robust
fprintf(' %3.1f%% CI from ''regress'' function : \n',100*(1-CI))
fprintf('%9.4f/%6.4f %15.4f/%6.4f %15.4f/%6.4f\n\n',[bIntRegress(3,2) bIntRegress(3,1) bIntRegress(2,2) bIntRegress(2,1) bIntRegress(1,2) bIntRegress(1,1)]);
%confidence interval for heteroskedastically robust
fprintf(' 95%% CI from ''robustfit'' function : \n')
fprintf('%9.4f/%6.4f %15.4f/%6.4f %15.4f/%6.4f\n\n',[bRobust(3)+1.96*statsRobust.se(3) bRobust(3)-1.96*statsRobust.se(3)...
    bRobust(2)+1.96*statsRobust.se(2) bRobust(2)-1.96*statsRobust.se(2) bRobust(1)+1.96*statsRobust.se(1) bRobust(1)-1.96*statsRobust.se(1)]);

%% Create data to plot fits
CLvec = linspace(min(CL),max(CL));
CDvec = polyval(pFit,CLvec);
CDvecRobust = polyval(flipud(bRobust),CLvec);
%% Plots
marksize=100;
marktype='.';

%% Polar plot
f=figure(1);
set(f,'name','Drag Polar','numbertitle','off');
hold on
hPoints=scatter(CD,CL,marksize,'xb');
hFit = plot(CDvec,CLvec,'--k','linewidth',2); % polyfit
hFitRobust = plot(CDvecRobust,CLvec,'--g','linewidth',2); % robust fit
xlabel('C_D [-]')
ylabel('C_L [-]')
% title('Drag Polar with Error Bounds')
legend('Data','Least Squares','Robust LS','location','best')
% xlim([.0 .13])
hold off

