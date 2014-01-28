clear all,close all,clc

load('./oldData/flight4/17385180.mat')
mask = ~handles.hasThrust;
alpha3 = handles.data.State.alphaP.data(mask);
CL3 = handles.data.State.CL.data(mask);
CD3 = handles.data.State.CD.data(mask);
pwm73 = handles.data.Units.pwm7.data(mask);
time3 = handles.data.Units.time.data(mask);
clear handles mask

load('./oldData/flight2/18424240.mat')
mask = ~handles.hasThrust;
alpha2 = handles.data.State.alphaP.data(mask);
CL2 = handles.data.State.CL.data(mask);
CD2 = handles.data.State.CD.data(mask);
pwm72 = handles.data.Units.pwm7.data(mask);
time2 = handles.data.Units.time.data(mask);
clear handles mask

load('./oldData/flight1/20374160.mat')
mask = ~handles.hasThrust;
alpha1 = handles.data.State.alphaP.data(mask);
CL1 = handles.data.State.CL.data(mask);
CD1 = handles.data.State.CD.data(mask);
pwm71 = handles.data.Units.pwm7.data(mask);
time1 = handles.data.Units.time.data(mask);
clear handles mask

handlesComb.data.State.CD.data = [CD1;CD2;CD3];
handlesComb.data.State.CL.data = [CL1;CL2;CL3];
% handlesComb.data.State.CD.data = [CD1;CD3];
% handlesComb.data.State.CL.data = [CL1;CL3];
handlesComb.xAxisDefined = true;
handlesComb.yAxisDefined = true;
combinedQuadFit(handlesComb);

CLVec = linspace(min([min(CL1) min(CL2) min(CL3)]),max([max(CL1) max(CL2) max(CL3)]));
p1 = fliplr([0.097872 0.020783 0.090236]);
p2 = fliplr([0.104202 -0.003354 0.123907]);
p3 = fliplr([0.092005 0.036290 0.079243]);
jj1 = alpha1<10 & alpha1> 0;
p4 = polyfit(CL1(jj1),alpha1(jj1),1);
p5 = polyfit(CL2(jj1),alpha2(jj1),1);
p6 = polyfit(CL3(jj1),alpha3(jj1),1);
CLalpha1 = 180/pi/p4(1)
CLalpha2 = 180/pi/p5(1)
CLalpha3 = 180/pi/p6(1)

a01 = polyval(p4,0)
a02 = polyval(p5,0)
a03 = polyval(p6,0)

CDVec1 = polyval(p1,CLVec);
CDVec2 = polyval(p2,CLVec);
CDVec3 = polyval(p3,CLVec);

figure(8)
h1=scatter(CL1,polyval(p1,CL1)-CD1,100,'.r');
hold on
box on
h2=scatter(CL2,polyval(p2,CL2)-CD2,100,'.b');
h3=scatter(CL3,polyval(p3,CL3)-CD3,100,'.k');
xlabel('C_L')
ylabel('C_D Residual');
legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','southwest')

figure(10)
CDR21 = (polyval(p1,CL1)-CD1).^2;
CDR22 = (polyval(p2,CL2)-CD2).^2;
CDR23 = (polyval(p3,CL3)-CD3).^2;

h1=scatter(CL1,CDR21,100,'.r');
hold on
box on
h2=scatter(CL2,CDR22,100,'.b');
h3=scatter(CL3,CDR23,100,'.k');
xlabel('C_L')
ylabel('C_D R^2');
legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','northwest')
SSE = [CDR21;CDR22;CDR23];
SSE = SSE(isfinite(SSE));
SSE = sum(SSE);
SST = [(CD1-mean(CD1(isfinite(CD1)))).^2;(CD2-mean(CD2(isfinite(CD2)))).^2;(CD3-mean(CD3(isfinite(CD3)))).^2];
SST = sum(SST(isfinite(SST)));
R2 = 1 - SSE/SST

figure(9)
h1=scatter(CD1,polyval(p1,CL1),100,'.r');
hold on
box on
h2=scatter(CD2,polyval(p2,CL2),100,'.b');
h3=scatter(CD3,polyval(p3,CL3),100,'.k');
xlim([0 1.02*max([CD1;CD2;CD3])])
ylim([0 1.02*max([CD1;CD2;CD3])])
plot(linspace(0,1),linspace(0,1),'--k')
xlabel('Measured C_D');
ylabel('Regression C_D');
legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','northwest')

figure(3)
h1 = scatter(CL1,CD1,100,'.r');
hold on
box on
plot(CLVec,CDVec1,'--r');
h2 = scatter(CL2,CD2,100,'.b');
plot(CLVec,CDVec2,'--b');
h3 = scatter(CL3,CD3,100,'.k');
plot(CLVec,CDVec3,'--k');
legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','northwest')
xlabel('C_L')
ylabel('C_D');

figure(2)
box on
h1 = scatter(alpha1,CL1,100,'.r');
hold on
box on
h2 = scatter(alpha2,CL2,100,'.b');
h3 = scatter(alpha3,CL3,100,'.k');
legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','northwest')
xlabel('\alpha');
ylabel('C_L')

% figure(4)
% h1 = scatter(alpha1,CD1,100,'.r');
% hold on
% box on
% h2 = scatter(alpha2,CD2,100,'.b');
% h3 = scatter(alpha3,CD3,100,'.k');
% legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','northwest')
% xlabel('\alpha')
% ylabel('C_D')

% figure(5)
% h1 = scatter(time1,pwm71,100,'.r');
% hold on
% h2 = scatter(time2,pwm72,100,'.b');
% h4 = scatter(time4,pwm74,100,'.k');
% legend([h1 h2 h4],'First Flight','Second Flight','Third Flight')
% xlabel('Time')
% ylabel('pwm7')

% figure(6)
% h1 = scatter(time1,pwm71,100,'.r');
% hold on
% % h2 = scatter(time2,pwm72,100,'.b');
% h4 = scatter(time4,pwm74,100,'.k');
% legend([h1 h2 h4],'First Flight','Second Flight','Third Flight')
% xlabel('Time')
% ylabel('pwm7')

% figure(7)
% h1 = scatter(time1,alpha1,100,'.r');
% hold on
% h2 = scatter(time2,alpha2,100,'.b');
% h4 = scatter(time4,alpha4,100,'.k');
% legend([h1 h2 h4],'First Flight','Second Flight','Third Flight','location','northeast')
% xlabel('Time')
% ylabel('\alpha')