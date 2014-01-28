clear all,close all,clc
warning off
load('./oldData/flight4/17385180.mat')
disp('Flight 3 - Clean')
mask = ~handles.hasThrust;
alpha3 = handles.data.State.alphaP.data(mask);
CL3 = handles.data.State.CL.data(mask);
CD3 = handles.data.State.CD.data(mask);
pwm73 = handles.data.Units.pwm7.data(mask);
time3 = handles.data.Units.time.data(mask);
handles.data.State.CD.data = CD3;
handles.data.State.CL.data = CL3;
combinedQuadFit(handles);
clear all

load('./oldData/flight2/18424240.mat')
disp('Flight 2 - Clean')
mask = ~handles.hasThrust;
alpha2 = handles.data.State.alphaP.data(mask);
CL2 = handles.data.State.CL.data(mask);
CD2 = handles.data.State.CD.data(mask);
pwm72 = handles.data.Units.pwm7.data(mask);
time2 = handles.data.Units.time.data(mask);
handles.data.State.CD.data = CD2;
handles.data.State.CL.data = CL2;
combinedQuadFit(handles);
clear all

load('./oldData/flight1/20374160.mat')
disp('Flight 1 - Clean')
mask = ~handles.hasThrust;
alpha1 = handles.data.State.alphaP.data(mask);
CL1 = handles.data.State.CL.data(mask);
CD1 = handles.data.State.CD.data(mask);
pwm71 = handles.data.Units.pwm7.data(mask);
time1 = handles.data.Units.time.data(mask);
handles.data.State.CD.data = CD1;
handles.data.State.CL.data = CL1;
combinedQuadFit(handles);
clear all

load('./oldData/flight5Dirty/205880.mat')
disp('Flight 1 - Dirty')
mask = ~handles.hasThrust;
alpha1D = handles.data.State.alphaP.data(mask);
CL1D = handles.data.State.CL.data(mask);
CD1D = handles.data.State.CD.data(mask);
pwm71D = handles.data.Units.pwm7.data(mask);
time1D = handles.data.Units.time.data(mask);
handles.data.State.CD.data = CD1D;
handles.data.State.CL.data = CL1D;
combinedQuadFit(handles);
clear all

load('./oldData/flight6Dirty/19175760.mat')
disp('Flight 2 - Dirty')
mask = ~handles.hasThrust;
alpha2D = handles.data.State.alphaP.data(mask);
CL2D = handles.data.State.CL.data(mask);
CD2D = handles.data.State.CD.data(mask);
pwm72D = handles.data.Units.pwm7.data(mask);
time2D = handles.data.Units.time.data(mask);
handles.data.State.CD.data = CD2D;
handles.data.State.CL.data = CL2D;
combinedQuadFit(handles);
clear all
% 
% load('./oldData/flight1/20374160.mat')
load 22492860.mat
disp('Flight 3 - Dirty')
mask = ~handles.hasThrust;
alpha3D = handles.data.State.alphaP.data(mask);
CL3D = handles.data.State.CL.data(mask);
CD3D = handles.data.State.CD.data(mask);
pwm73D = handles.data.Units.pwm7.data(mask);
time3D = handles.data.Units.time.data(mask);
handles.data.State.CD.data = CD3D;
handles.data.State.CL.data = CL3D;
combinedQuadFit(handles);