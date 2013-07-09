%%
% close all,clc
clear all,clc

load simData_5_9_2013.mat

run dataReadin

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

noise.eulerAngles = .0; %deg
noise.eulerRates = .0; %deg/s
noise.windAngles = 0; %deg
noise.accel = .0; %ft/s/s
noise.qbar = 0; %psf
noise.gravity = .0; %ft/s/s
noise.W = 0.0;
noise.GPSSpeed=.0*3.28;

state = addNoise(state,noise);

% errorBnd = errorProp(state,plane,noise);

%% Estimate coefficients
state = eulerKalman(state,noise);
% state = windAngleCalc(state,noise);
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

%% Fits
% [hHoriz,hVert,hPoints] = errorbar2(CD,CL,[errorBnd(:,1) errorBnd(:,3)]);


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
f=figure(1);
set(f,'name','Polar Comp','numbertitle','off');
hold on
hSim = scatter(simCD,simCL,marksize,'or');
hPoints=scatter(CD,CL,marksize,'xb');
% hFit = plot(CDvec,CLvec,'--k','linewidth',2);
% hFitRobust = plot(CDvecRobust,CLvec,'--g','linewidth',2);
xlabel('C_D [-]')
ylabel('C_L [-]')
% title('Drag Polar with Error Bounds')
% title('Drag Polar with Zero Noise')
legend('Simulator Input','Output from EoMs','location','best')
% legend([hSim hFit hPoints hVert],'Simulink','Curve Fit','EoMs','Error','location','southeast');
% legend([hSim hPoints hFit hFitRobust],'System Input','Calculated','OLS Regression','Robust Regression','location','best');
xlim([.0 .13])
hold off

%% Forces Plots
% f=figure;
% set(f,'name','Drag Comp','numbertitle','off');
% scatter(time,drag,marksize,marktype);
% hold on
% scatter(time,simDrag,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Drag Force [lb]')
% title('Drag Force vs. Time')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','Lift Comp','numbertitle','off');
% scatter(time,lift,marksize,marktype);
% hold on
% scatter(time,simLift,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Lift Force [lb]')
% title('Lift Force vs. Time')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','Side Comp','numbertitle','off');
% scatter(time,side,marksize,marktype);
% hold on
% scatter(time,simSide,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Side Force [lb]')
% title('Side Force vs. Time')
% legend('Model','Simulink','location','southeast')

%% Deflections plot
% f=figure(2);
% set(f,'name','Deflections','numbertitle','off');
% subplot(4,1,1)
% plot(time,deflections.signals.values(:,1),marktype);
% ylabel('Elevator')
% xlim([0 time(end)]);
% 
% subplot(4,1,2)
% plot(time,deflections.signals.values(:,2),marktype);
% ylabel('Aileron')
% xlim([0 time(end)]);
% 
% subplot(4,1,3)
% plot(time,deflections.signals.values(:,3),marktype);
% ylabel('Rudder')
% xlim([0 time(end)]);
% 
% subplot(4,1,4)
% plot(time,CD,marktype);
% ylim([-2 0])
% xlim([0 time(end)]);
% ylabel('C_D')
% xlabel('Time [sec]')
% % ylabel('C_L [-]')
% title('Deflections')
% hold off

%% Body Coeff Comparison
% f=figure;
% set(f,'name','CX Comp','numbertitle','off');
% scatter(time,cAeroBody(:,1),marksize,marktype);
% hold on
% scatter(time,aeroForceCoeffsBody.signals.values(:,1),marksize,marktype);
% xlabel('Time [sec]')
% ylabel('C_X [-]')
% title('C_X Comparison')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','CY Comp','numbertitle','off');
% scatter(time,cAeroBody(:,2),marksize,marktype);
% hold on
% scatter(time,aeroForceCoeffsBody.signals.values(:,2),marksize,marktype);
% xlabel('Time [sec]')
% ylabel('C_Y [-]')
% title('C_Y Comparison')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','CZ Comp','numbertitle','off');
% scatter(time,cAeroBody(:,3),marksize,marktype);
% hold on
% scatter(time,aeroForceCoeffsBody.signals.values(:,3),marksize,marktype);
% xlabel('Time [sec]')
% ylabel('C_Z [-]')
% title('C_Z Comparison')
% legend('Model','Simulink','location','southeast')

%% Weight Vector Check
% f=figure;
% set(f,'name','X Gravity','numbertitle','off');
% scatter(time,fWBody(:,1),marksize,marktype);
% hold on
% scatter(time,fGravityBody.signals.values(:,1)*0.224808943,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('X Gravity [lbf]')
% title('X Gravity Comparison')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','Y Gravity','numbertitle','off');
% scatter(time,fWBody(:,2),marksize,marktype);
% hold on
% scatter(time,fGravityBody.signals.values(:,2)*0.224808943,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Y Gravity [lbf]')
% title('Y Gravity Comparison')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','Z Gravity','numbertitle','off');
% scatter(time,fWBody(:,3),marksize,marktype);
% hold on
% scatter(time,fGravityBody.signals.values(:,3)*0.224808943,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Z Gravity [lbf]')
% title('Z Gravity Comparison')
% legend('Model','Simulink','location','southeast')

%% F = ma check
% f=figure;
% set(f,'name','F = ma check','numbertitle','off');
% scatter(time,totalBodyForces.signals.values(:,1)*0.224808943-m*(state.accel(:,1)),marksize,marktype);
% hold all
% scatter(time,totalBodyForces.signals.values(:,2)*0.224808943-m*(state.accel(:,2)),marksize,marktype);
% scatter(time,totalBodyForces.signals.values(:,3)*0.224808943-m*(state.accel(:,3)),marksize,marktype);
% xlabel('Time [sec]')
% ylabel('F-m*a [lbf]')
% title('F = ma check')

%% Total Body forces check
% 
% f=figure;
% set(f,'name','Total X Body Forces','numbertitle','off');
% scatter(time,fTotal(:,1),marksize,marktype);
% hold on
% scatter(time,totalBodyForces.signals.values(:,1)*0.224808943,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Total X Body Forces [lbf]')
% title('Total X Body Forces')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','Total Y Body Forces','numbertitle','off');
% scatter(time,fTotal(:,2),marksize,marktype);
% hold on
% scatter(time,totalBodyForces.signals.values(:,2)*0.224808943,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Total Y Body Forces [lbf]')
% title('Total Y Body Forces')
% legend('Model','Simulink','location','southeast')
% 
% f=figure;
% set(f,'name','Total Z Body Forces','numbertitle','off');
% scatter(time,fTotal(:,3),marksize,marktype);
% hold on
% scatter(time,totalBodyForces.signals.values(:,3)*0.224808943,marksize,marktype);
% xlabel('Time [sec]')
% ylabel('Total Z Body Forces [lbf]')
% title('Total Z Body Forces')
% legend('Model','Simulink','location','southeast')
