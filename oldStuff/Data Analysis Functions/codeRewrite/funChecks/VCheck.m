clear all,close all,clc

logfile='XPlaneData-3-5-2013.mat';

[state,plane]=dataReadin(logfile);

for i=1:length(state.V)
    magV(i)=norm(state.V(i,:));
end

plot(magV,'-ok')
hold on
plot(state.VCheck,'-b')

figure
plot(100*(magV'-state.VCheck)./state.VCheck)