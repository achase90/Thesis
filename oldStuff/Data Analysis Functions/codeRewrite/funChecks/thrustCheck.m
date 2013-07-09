clear all,close all,clc

logfile='XPlaneData-4-3-2013.mat';

[state,plane]=dataReadin(logfile);

for i=1:length(state.thrust)
    magT(i)=norm(state.thrust(i,:));
end

plot(magT,'-ok')
hold on
plot(state.thrustCheck,'-b')