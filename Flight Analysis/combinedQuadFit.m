function handles = combinedQuadFit(handles)
% CITVal = 2.576;
% CI = 99;
% CITVal = 2.326; % 98%
% CI = 98;
CITVal = 1.96; % 95%
CI = 95;
% CITVal = 1.645; % 90%
% CI = 90;

xData = handles.data.State.CL.data;
yData = handles.data.State.CD.data;
[p1,statsRobust] = robustfit([xData xData.^2],yData);
p1 = flipud(p1);
%regressions and confidence intervals output to the command window
fprintf(' Estimated coefficients using ''robustfit'' function: \n')
fprintf(' %10s %17s %20s\n','CD0','C1','C2');
fprintf('%12.6f %18.6f %18.6f\n',[p1(3) p1(2) p1(1)]);
fprintf(' %i%% CI from ''robustfit'' function : \n',CI)
fprintf('%9.4f/%6.4f %14.4f/%6.4f %10.4f/%6.4f\n',[p1(3)+CITVal*statsRobust.se(3) p1(3)-CITVal*statsRobust.se(3)...
    p1(2)+CITVal*statsRobust.se(2) p1(2)-CITVal*statsRobust.se(2) p1(1)+CITVal*statsRobust.se(1) p1(1)-CITVal*statsRobust.se(1)]);
% fprintf(' As a percentage (+/-) : \n')
% fprintf('%12.4f %19.4f %19.4f\n\n',[(p1(3)+CITVal*statsRobust.se(3))/p1(3)...
%     (p1(2)+CITVal*statsRobust.se(2))/p1(2)  (p1(1)+CITVal*statsRobust.se(1))/p1(1)]*100-100);
