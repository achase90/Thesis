%%
close all,clc
% clear all,clc

load simData_12_10_2013.mat

run dataReadin

CI = .05;
%% Estimate coefficients
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

%% Fits
errorBnd = errorProp(state,plane,noise);
% [hHoriz,hVert,hPoints] = errorbar2(CD,CL,[errorBnd(:,1) errorBnd(:,3)]);
% set(hPoints,'markerfacecolor','r','markeredgecolor','r');

[pFit] = polyfit(CL,CD,2);
[bRegress,bIntRegress]=regress(CD,[ones(length(CL),1) CL CL.^2],CI);
[bRobust,statsRobust] = robustfit([CL CL.^2],CD);
% stats=regstats2(CD,[ones(length(CL),1) CL CL.^2]);
fprintf(' Actual coefficients : \n')
fprintf('%15.4f %15.4f %15.4f\n\n',[KCL2 0 CD0]);
fprintf(' Estimated coefficients : \n')
fprintf('%15.4f %15.4f %15.4f\n\n',[bRegress(3) bRegress(2) bRegress(1)]);
fprintf(' Estimated coefficients using ''robustfit'' function: \n')
fprintf('%15.4f %15.4f %15.4f\n\n',[bRobust(3) bRobust(2) bRobust(1)]);
fprintf(' %3.1f%% CI from ''regress'' function : \n',100*(1-CI))
fprintf('%9.4f/%6.4f %15.4f/%6.4f %15.4f/%6.4f\n\n',[bIntRegress(3,2) bIntRegress(3,1) bIntRegress(2,2) bIntRegress(2,1) bIntRegress(1,2) bIntRegress(1,1)]);
fprintf(' 95%% CI from ''robustfit'' function : \n')
fprintf('%9.4f/%6.4f %15.4f/%6.4f %15.4f/%6.4f\n\n',[bRobust(3)+1.96*statsRobust.se(3) bRobust(3)-1.96*statsRobust.se(3)...
    bRobust(2)+1.96*statsRobust.se(2) bRobust(2)-1.96*statsRobust.se(2) bRobust(1)+1.96*statsRobust.se(1) bRobust(1)-1.96*statsRobust.se(1)]);
fprintf(' Percent error in estimated coefficients: \n')
fprintf('%15.4f %15.4f %15.4f\n\n',[100*(KCL2-pFit(1))/pFit(1) 100*pFit(2) 100*(CD0-pFit(3))/pFit(3)]);
fprintf(' Percent error in estimated coefficients from ''robustfit'': \n')
fprintf('%15.4f %15.4f %15.4f\n\n',[100*(KCL2-bRobust(3))/bRobust(3) 100*bRobust(2) 100*(CD0-bRobust(1))/bRobust(1)]);
CLvec = linspace(min(CL),max(CL));
CDvec = polyval(pFit,CLvec);
CDvecRobust = polyval(flipud(bRobust),CLvec);
%% Plots

marksize=100;
marktype='.';

%% Polar plot
% try
% clf(1)
% catch
% end
f = figure(1);
set(f,'name','Polar Comp','numbertitle','off');
hold on
hSim = scatter(simCD,simCL,marksize,'or');
hPoints = scatter(CD,CL,marksize,'xb');
hFit = plot(CDvec,CLvec,'--k','linewidth',2);
hFitRobust = plot(CDvecRobust,CLvec,'--g','linewidth',2);
xlabel('C_D [-]')
ylabel('C_L [-]')
% title('Drag Polar with Error Bounds')
% title('Drag Polar with Zero Noise')
legend([hSim hPoints],'Simulator Input','Output from EoMs','location','best')
% legend([hSim hFit hPoints hVert],'Simulink','Curve Fit','EoMs','Error','location','southeast');
legend([hSim hPoints hFit hFitRobust],'System Input','Calculated','OLS Regression','Robust Regression','location','best');
% legend([hPoints hHoriz],'Simulated Data','Error Bars');
xlim([0 .13]);
hold off