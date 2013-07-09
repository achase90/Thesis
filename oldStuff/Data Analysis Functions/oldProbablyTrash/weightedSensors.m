function [prob,x] = weightedSensors(mu,sigma,lsb,xvec)
if length(mu)~=length(sigma)
    error('Length of mu and sigma must be the same')
end
if nargin<3
    lsb=.001; % least significant bit, this will be the precision maximums are calculated with
end
i=1;
prob=0;
xmin=min(mu-5*sigma); %% set lower endpoint to encompass 3 std's below most constraining sensor
xmax=max(mu+5*sigma);%% set upper endpoint to encompass 3 std's above most constraining sensor
if nargin<4
    x=linspace(xmin,xmax,ceil((xmax-xmin)/lsb));
else
    x=xvec;
end

while i<length(mu)+1
    prob=prob+((1/sigma(i)*sqrt(2*pi))*exp(-(x-mu(i)).^2/(2*sigma(i)^2)));
    i=i+1;
end