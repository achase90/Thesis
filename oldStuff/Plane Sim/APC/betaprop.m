clear all,close all,clc

files=dir('apce_*.txt');

for i=1:numel(files)
% M=regexpi(files(1).name,'apce_[0-9]{1,2}x[0-9]{1,2}_*')
M(:,i)=sscanf(files(i).name,'apce_%fx%f_*');
diam(i)=M(1,i);
pitch(i)=M(2,i);
theta(i)=90-atand(0.7*diam(i)*pi/pitch(i));
end

scatter(theta,pitch,20)
ylabel('Pitch Distance [in]')
xlabel('Pitch Angle [deg]')

figure(2)
scatter(theta,diam,20)
ylabel('Diameter [in]')
xlabel('Pitch Angle [deg]')
