clear all
close all
clc

std_dev1 = 2;
mean1 = 1;
x = -6+mean1:.01:6+mean1;
y1 = (std_dev1*sqrt(2*pi))^-1*exp(-.5*((x-mean1)/std_dev1).^2);

std_dev2 = 1.5;
mean2 = 2;
y2 = (std_dev2*sqrt(2*pi))^-1*exp(-.5*((x-mean2)/std_dev1).^2);

plot(x,y1);
hold all
plot(x,y1+y2)
plot(x,y2)
xlim([-10 10]);
ylim([0 .5]);