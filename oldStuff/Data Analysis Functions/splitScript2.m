clearflag=false;

if clearflag==true
    clear all, close all,clc
    
    [dataToSplit]=APM_readin('2012-10-24 12-09 3.log');
end
clf
[DATAToResize]=APM_splitter(dataToSplit,'rtl');
for k=1:numel(DATAToResize)
    [DATA]=APM_resizer(DATAToResize(k),50);
    for i=1:length(DATA.ATT.Pitch)
        X(1)=zeros(size(DATA.ATT.Pitch(i))); %thrust
        X(2)=.5*.00237*(DATA.GPS.GR_Speed(i))^2; %qbar
        X(3)=DATA.RAW.Accel_X(i); %ax
        X(4)=DATA.RAW.Accel_Y(i);%ay
        X(5)=DATA.RAW.Accel_Z(i);%az
        X(6)=DATA.ATT.Pitch(i); %theta
        X(7)=DATA.ATT.Roll(i); %phi
        X(8)=DATA.RAW.Gyro_X(i)*pi/180; %p
        X(9)=DATA.RAW.Gyro_Y(i)*pi/180; %q
        X(10)=DATA.RAW.Gyro_Z(i)*pi/180;%r
        X(11)=2.5; %weight
        X(12)=DATA.GPS.GR_Speed(i);
        [Cw] = stateToForces2(X);
    end
    
    figure(k)
    scatter(Cw(1),Cw(3),50,'.')
    hold on
end