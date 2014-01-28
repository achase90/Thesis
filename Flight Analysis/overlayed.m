clear all,close all,clc
pClean = fliplr([ 0.100037           0.011454           0.101002]);
pDirty = fliplr([    0.132458           0.007363           0.123563]);

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
p1 = fliplr([0.131369 -0.012798 0.112656]);
p2 = fliplr([0.119239 0.039097 0.080350]);
p3 = fliplr([0.133284 -0.003498 0.118024]);
CDVec1 = polyval(p1,CLVec);
CDVec2 = polyval(p2,CLVec);
CDVec3 = polyval(p3,CLVec);
% h3 = 0;

figure(3)
hold on
h1D = scatter(CL1,CD1,30,'.b');
box on
h2D = scatter(CL2,CD2,30,'.b');
h3D = scatter(CL3,CD3,30,'.b');
xlabel('C_L')
ylabel('C_D');

figure(4)
hold on
h1D = scatter(alpha1,CL1,30,'.b');
box on
h2D = scatter(alpha2,CL2,30,'.b');
h3D = scatter(alpha3,CL3,30,'.b');
xlabel('C_L')
ylabel('C_D');

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
handlesComb.xAxisDefined = true;
handlesComb.yAxisDefined = true;
combinedQuadFit(handlesComb);

CLVec = linspace(min([min(CL1) min(CL2) min(CL3)]),max([max(CL1) max(CL2) max(CL3)]));
p1 = fliplr([0.097872 0.020783 0.090236]);
p2 = fliplr([0.104202 -0.003354 0.123907]);
p3 = fliplr([0.092005 0.036290 0.079243]);
CDVec1 = polyval(p1,CLVec);
CDVec2 = polyval(p2,CLVec);
CDVec3 = polyval(p3,CLVec);

figure(3)
h1 = scatter(CL1,CD1,30,'.r');
box on
h2 = scatter(CL2,CD2,50,'.r');
h3 = scatter(CL3,CD3,50,'.r');
uistack(h1,'bottom');
uistack(h2,'bottom');
uistack(h3,'bottom');
xlabel('C_L')
ylabel('C_D');
CL = linspace(-.5,1.5);
hC = plot(CL,polyval(pClean,CL),'-k','linewidth',2);
hD = plot(CL,polyval(pDirty,CL),'--k','linewidth',2);
legend([h1 h1D hC hD],'Clean','Dirty','Clean Model','Dirty Model','location','northwest')


figure(4)
h1 = scatter(alpha1,CL1,30,'.r');
box on
h2 = scatter(alpha2,CL2,30,'.r');
h3 = scatter(alpha3,CL3,30,'.r');
uistack(h1,'bottom');
uistack(h2,'bottom');
uistack(h3,'bottom');
xlabel('\alpha [deg]')
ylabel('C_L [-]');
legend([h1 h1D],'Clean','Dirty','Third Flight','location','northwest')

