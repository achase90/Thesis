% Reads in APM data, resizes, and converts units
% [DATA]=APM_readin(logfile,new_freq,logdir,freq,method)
function [DATA]=APM_readin(logfile,new_freq,logdir,freq,method)
%%

% This function reads in data from the Ardupilot log file, creates a time
% correlation, and resamples all data to matching data points. The data
% will then be converted to English units using APM_units.

% Adam Chase
% 10/24/2012
% %=============================================================

% UPDATES:
% 2/24/2013 : changed logdir handling to be more generic and not user
% specific. Also updated comments.
%
% 
% 
% %=============================================================
%
% INPUTS:
% logfile = name of the log file to be read in
% new_freq = desired interpolated frequency. To leave the data in original
% form, set new_freq = 0. (If not passed in, new_freq = 0, ie, no data resizing)

% logdir = directory where logfile is located. (If not passed in,
% logdir=pwd.

% freq = structure that containts the frequency at which the data was
% sampled. (If not passed in, the default is maximum speed settings, based
% on the logging software on the Ardupilot.)

% method = interpolation method used to resize the data. (If not passed in,
% default is cubic)

% %=============================================================
%
% OUTPUTS:
% DATA structure, containing the following fields:
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
% % Not sure what GPS.GR_Speed or NTUN.Yaw are in
% NTUN.Alt_Err is weird. Should all be positive or all be negative, not switching.

% %=============================================================

%% Input checking
if nargin<2 %don't resize the data
    new_freq=0;
end

if nargin<3 %check for a provided log directory
    logdir=pwd;
end

if nargin<4% check for a provided frequency structure
    freq.ATT=50; %assume ATT loop is high speed
    freq.GPS=10;
    freq.PM=1/20;
    freq.CTUN=10;
    freq.NTUN=10;
    freq.RAW=50;
end

if nargin<5
    method='cubic' ;%if not otherwise specified, assume a cubic interp
end

%% Read in data
[DATAin] = APM_parser(logdir, logfile);

%% make discontinuous phase angles continuous
[DATAin.ATT.Yaw]=(360/2/pi)*unwrap(DATAin.ATT.Yaw*2*pi/360);
DATAin.GPS.CRS=(360/2/pi)*unwrap(DATAin.GPS.CRS*2*pi/360);

%% resize if desired and change units
if new_freq==0
    DATA=APM_units(DATAin);
else
    disp('')
    disp('Resizing Data...')
    [DATAresized]=APM_resizer(DATAin,new_freq);
    [DATA]=APM_units(DATAresized);
end

disp('Finished reading in data')