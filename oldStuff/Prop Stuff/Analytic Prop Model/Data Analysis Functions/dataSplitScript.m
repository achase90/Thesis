clearflag=false;

if clearflag==true
    clear all, close all,clc
    
    [dataToSplit]=APM_readin('2012-10-24 12-09 3.log');
end
clf

[DATA]=APM_splitter(dataToSplit,'rtl');
for k=1:numel(DATA)
% plot(DATA(6).RAW.Accel_X)
for i=1:length(DATA(k).ATT.Pitch)
    X(1)=zeros(size(DATA(k).ATT.Pitch(i))); %thrust
    X(2)=20*ones(size(DATA(k).ATT.Pitch(i))); %q
    X(3)=X(1); %thrust angle
    X(4)=DATA(k).RAW.Accel_X(i); %ax
    X(5)=DATA(k).RAW.Accel_Y(i);%ay
    X(6)=DATA(k).RAW.Accel_Z(i);%az
    X(7)=DATA(k).ATT.Pitch(i); %theta
    X(8)=DATA(k).ATT.Roll(i); %phi
    X(9)=DATA(k).ATT.Yaw(i); %psi
    X(10)=10*rand(1)*pi/180; %alpha
    X(11)=10*rand(1)*pi/180; %beta
    X(12)=2.5; %weight
% X=rand(12,1);
    [coeffCw(:,i),Cw(:,i)] = stateToForces(X);
end

figure(k)
scatter(coeffCw(1,:),coeffCw(3,:),50,'.')
p=polyfit(coeffCw(3,:),coeffCw(1,:),2);
hold on
CL=linspace(-.1,.2);
CD=polyval(p,CL);
temp=polyder(p);
temp=abs(temp(2))/abs(temp(1));
cd0(k)=polyval(p,temp);
plot(CD,CL,'--r','linewidth',2);
end
cd0
std(cd0)/mean(cd0)
% plot(50*DATAInt(1).RAW.Gyro_X)
% hold all
% plot(DATA(1).ATT.Roll)