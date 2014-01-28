% clear all,close all,clc
close all
load clarkyData.mat
mask = ~handles.hasThrust;
alphaFlight = handles.data.State.alphaP.data(mask);
CDFlight = handles.data.State.CD.data(mask);
CLFlight = handles.data.State.CL.data(mask);
time = handles.data.State.time.data(mask);

ii = CL<1 & CL > 0;
jj = alphaFlight<8 & alphaFlight > 0;

CLmin = CL(CD == min(CD)); 

p1 = polyfit((CL(ii)-CLmin).^2,CD(ii),1);
p3 = polyfit(alpha(alpha<8),CL(alpha<8),1);
p3(1)*180/pi;
p2 = polyfit(alphaFlight(jj),CLFlight(jj),1);
b = robustfit(alphaFlight(jj),CLFlight(jj));
b = flipud(b)';
CDvisc = polyval(p1,(CL-CLmin).^2);

figure(1)
cla
hXfoil = plot(alpha,CL,'--k','linewidth',1.5);
hold on
hFlight = scatter(alphaFlight,CLFlight,30,'.b');
% errorbar(alphaFlight,CLFlight,handles.errorBnd(mask,1))
hSlope = plot([-5:10],polyval(b,[-5:10]),'--g','linewidth',1.5);
[hHoriz,hVert] = errorbar2(handles,handles.errorBnd);
uistack(hHoriz,'bottom');
uistack(hFlight,'top');
uistack(hSlope,'top');
liftCurve = b(1)*180/pi
xlabel('\alpha [deg]')
ylabel('Lift Coefficient [-]')
legend([hXfoil hFlight hSlope],'Sectional Lift Coefficient - XFOIL','3-D Lift Coefficient - Flight','Lift Curve Slope','location','southeast')
% figure(2)
% plot(CD,CL,'-k','linewidth',1.5)
% xlabel('C_d')
% ylabel('C_l')

figure(3)
plot((CL-CLmin).^2,CD,'-k','linewidth',1.5)
hold on
plot((CL-CLmin).^2,CDvisc,'--r','linewidth',1.5)
str=sprintf('K_1 = %s',num2str(p1(1)));
text(0.45,0.03,str)
legend('XFOIL Data','Linear Fit','location','northwest')
xlabel('(C_l - C_{l_{MIN}})^2')
ylabel('C_d')

figure(4)
pCD = [0.079243 0.036290 0.092005];
scatter(CLFlight,CDFlight - polyval(pCD,CLFlight),200,'.b');
box on
xlabel('C_L')
ylabel('C_D Residuals')

figure(5)
mask = (time < 717 & time > 700);
scatter(time(mask),alphaFlight(mask),30,'or');
hold on
box on
plot(time(mask),alphaFlight(mask),'--b')
xlabel('Time [sec]')
ylabel('\alpha [deg]')

K1 = p1(1);
CLmin = CL(CD == min(CD))
fprintf('Expected C_1 regression coefficient : %6.4f\n\n',-2*p1(1)*CLmin);
a0 = interp1(CL,alpha,0)
clt = polyval(b,[-5:10]);
at = [-5:10];
a0Xfoil = interp1(clt,at,0)