% Resizes struct from APM_parser to desired frequency
% function [DATA]=APM_resizer(logfile,new_freq,logdir,freq,method)
function [DATA]=APM_resizer(DATA,new_freq,freq,method)
%
% Adam Chase
% 10/24/2012
%
% This function takes in data from the Ardupilot DATA structure created using
% APM_parser,creates a time correlation, and resamples all data to matching
% data points.
%
% %=============================================================
%
% INPUTS:
% DATA : a structure containing data from APM_parser
% new_freq = desired data sampling rate, in Hz
% freq = Ardupilot sampling rates, in Hz. (optional, defaults to High speed ATT)
% method: interpolation method (optional, defaults to 'cubic')
% %=============================================================
%
% OUTPUTS:
% DATA structure, containing:
% ATT = Attitude data
% RAW = Gyro/accel data
% CTUN = control gain tuning data
% GPS = GPS data
% PM = Performance Management data
% CMD = Command data
%
% %=============================================================
%
% Improvements:
%
% %todo: error catch if fields in Time are not in DATA and/or freq
%
% %=============================================================
%%
%%

if nargin<3 % check for a provided frequency structure
    freq.ATT=50; %assume ATT loop is high speed
    freq.GPS=10;
    freq.PM=1/20;
    freq.CTUN=10;
    freq.NTUN=10;
    freq.RAW=50;
end

if nargin<4
    method='cubic' ;%if not otherwise specified, assume a cubic interp
end

%% Initialize
Time=struct('ATT',[],'GPS',[],'PM',[],'CTUN',[],'NTUN',[],'RAW',[]); %vector of fields to re-sample

%% Establish times based on sample rates and number of samples
datanames=fieldnames(Time);
for i=1:numel(datanames)
    Time.(datanames{i})=1/freq.(datanames{i}):1/freq.(datanames{i}):length(DATA.(datanames{i}).lineNo)/freq.(datanames{i});
end

%% Find the time where non-continuously sampled data occurs
%find where this data occurs
% get the closest line number
% find(DATA.DATA.MOD.lineNo-1 || DATA.MOD.lineNo+1
% figure out how line number relates to time

%% Begin interpolations
% find the last time stamp in each data set and find the minimum of them,
% this ensures there is no extrapolation, and only results in losing a
% small amount of time at the end of the flight

clear i
for i=1:numel(datanames)
    if ~isempty(Time.(datanames{i}))
        lasttime(i)=max(Time.(datanames{i}));
    end
end
endtime=min(lasttime);

%set up desired time vector based on ending time and desired frequency
tdes=linspace(0,endtime,new_freq*endtime);

%% Put a time on non-continuously sampled data
for i=1:length(DATA.MOD.lineNo)
    k=find(DATA.ATT.lineNo>DATA.MOD.lineNo(i),1,'first');
    DATA.MOD.Time(i)=k/freq.RAW;
end

for i=1:length(DATA.CMD.lineNo)
    k=find(DATA.ATT.lineNo>DATA.CMD.lineNo(i),1,'first');
    DATA.CMD.Time(i)=k/freq.ATT;
end

%% Interpolate
for i=1:numel(datanames)
    datafieldnames=fieldnames((DATA.(datanames{i}))); %interp ATT
    for j=1:numel(datafieldnames)
        if numel(DATA.(datanames{i}).(datafieldnames{j}))>1
            [DATA.(datanames{i}).(datafieldnames{j})]=interp1(Time.(datanames{i}),DATA.(datanames{i}).(datafieldnames{j}),tdes,method);
        end
    end
end
DATA.Time=tdes;
