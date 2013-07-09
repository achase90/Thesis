clear all,close all,clc

joy=vrjoystick(1);

i=0;

f=figure(1);

roll=[];
pitch=roll;
yaw=roll;
throttle=roll;

while i<10000
    [roll(end+1) pitch(end+1) yaw(end+1) throttle(end+1)]=joyInput(joy);
    if i>100
        set(f,'Name',sprintf('Iter = %i/10,000',i));
        
        %% Plotting
        subplot(2,2,1)
        plot(roll(end-100:end))
        
        subplot(2,2,2)
        plot(pitch(end-100:end))
        
        subplot(2,2,3)
        plot(yaw(end-100:end))
        
        subplot(2,2,4)
        plot(throttle(end-100:end))
        
        pause(.01)
        %%
    end
    i=i+1;
end



