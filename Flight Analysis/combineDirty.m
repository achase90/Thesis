clear all,close all,clc

load('./oldData/flight5Dirty/205880.mat')
mask = ~handles.hasThrust;
alpha1 = handles.data.State.alphaP.data(mask);
CL1 = handles.data.State.CL.data(mask);
CD1 = handles.data.State.CD.data(mask);
pwm71 = handles.data.Units.pwm7.data(mask);
time1 = handles.data.Units.time.data(mask);
% clear handles mask

load('./oldData/flight6Dirty/19175760.mat')
mask = ~handles.hasThrust;
alpha2 = handles.data.State.alphaP.data(mask);
CL2 = handles.data.State.CL.data(mask);
CD2 = handles.data.State.CD.data(mask);
pwm72 = handles.data.Units.pwm7.data(mask);
time2 = handles.data.Units.time.data(mask);
% clear handles mask
% 
% load('./oldData/flight1/20374160.mat')
load 22492860.mat
mask = ~handles.hasThrust;
alpha3 = handles.data.State.alphaP.data(mask);
CL3 = handles.data.State.CL.data(mask);
CD3 = handles.data.State.CD.data(mask);
pwm73 = handles.data.Units.pwm7.data(mask);
time3 = handles.data.Units.time.data(mask);
% clear handles mask

handlesComb.data.State.CD.data = [CD1;CD2;CD3];
handlesComb.data.State.CL.data = [CL1;CL2;CL3];
% handlesComb.data.State.CD.data = [CD1;CD2];
% handlesComb.data.State.CL.data = [CL1;CL2];
combinedQuadFit(handlesComb);

CLVec = linspace(min([min(CL1) min(CL2) min(CL3)]),max([max(CL1) max(CL2) max(CL3)]));
% CLVec = linspace(min([min(CL1) min(CL2)]),max([max(CL1) max(CL2)]));
p1 = fliplr([0.131369 -0.012798 0.112656]);
p2 = fliplr([0.119239 0.039097 0.080350]);
p3 = fliplr([0.133284 -0.003498 0.118024]);
CDVec1 = polyval(p1,CLVec);
CDVec2 = polyval(p2,CLVec);
CDVec3 = polyval(p3,CLVec);
% h3 = 0;

figure(3)
hold on
h1D = scatter(CL1,CD1,30,'.r');
% hold on
box on
% plot(CLVec,CDVec1,'--r');
h2D = scatter(CL2,CD2,30,'.b');
% plot(CLVec,CDVec2,'--b');
h3D = scatter(CL3,CD3,30,'.k');
% plot(CLVec,CDVec3,'--k');
% legend([h1 h1D],'Clean','Dirty')
legend([h1D h2D h3D],'First Flight','Second Flight','Third Flight','location','northwest')
xlabel('C_L')
ylabel('C_D');

figure(2)
box on
h1 = scatter(alpha1,CL1,30,'.r');
hold on
box on
h2 = scatter(alpha2,CL2,30,'.b');
h3 = scatter(alpha3,CL3,30,'.k');
legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','northwest')
xlabel('\alpha');
ylabel('C_L')

% figure(4)
% h1 = scatter(alpha1,CD1,30,'.r');
% hold on
% box on
% h2 = scatter(alpha2,CD2,30,'.b');
% % h3 = scatter(alpha3,CD3,30,'.k');
% legend([h1 h2 h3],'First Flight','Second Flight','Third Flight','location','northwest')
% xlabel('\alpha')
% ylabel('C_D')

% figure(5)
% h1 = scatter(time1,pwm71,30,'.r');
% hold on
% h2 = scatter(time2,pwm72,30,'.b');
% h4 = scatter(time4,pwm74,30,'.k');
% legend([h1 h2 h4],'First Flight','Second Flight','Third Flight')
% xlabel('Time')
% ylabel('pwm7')

% figure(6)
% h1 = scatter(time1,pwm71,30,'.r');
% hold on
% % h2 = scatter(time2,pwm72,30,'.b');
% h4 = scatter(time4,pwm74,30,'.k');
% legend([h1 h2 h4],'First Flight','Second Flight','Third Flight')
% xlabel('Time')
% ylabel('pwm7')

% figure(7)
% h1 = scatter(time1,alpha1,30,'.r');
% hold on
% h2 = scatter(time2,alpha2,30,'.b');
% h4 = scatter(time4,alpha4,30,'.k');
% legend([h1 h2 h4],'First Flight','Second Flight','Third Flight','location','northeast')
% xlabel('Time')
% ylabel('\alpha')