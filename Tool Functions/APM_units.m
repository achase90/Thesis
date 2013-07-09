% Converts struct from APM_resizer into usable units
% function [DATA_NEW]=APM_units(DATA)
function [DATA_NEW]=APM_units(DATA)
%%
%Adam Chase
%10/24/12

% todo: add units table
%%
m2ft=3.28084;
DATA_NEW=DATA;
%% ATT
DATA_NEW.ATT.Roll=DATA.ATT.Roll/100; %scaling
DATA_NEW.ATT.Pitch=DATA.ATT.Pitch/100; %scaling
DATA_NEW.ATT.Yaw=DATA.ATT.Yaw/100; %scaling %TODO: this is heading

%% GPS
DATA_NEW.GPS.Mix_Alt=DATA.GPS.Mix_Alt*m2ft; %cm to ft 
DATA_NEW.GPS.GR_Speed=DATA.GPS.GR_Speed*m2ft; %m/s to ft/s %NOT CORRECT
DATA_NEW.GPS.GPS_Alt=DATA.GPS.GPS_Alt*m2ft; %m/s to ft/s
%% PM
DATA_NEW.PM.perf_mon_timer=DATA.PM.perf_mon_timer/1000; %ms to s
DATA_NEW.PM.G_Dt_max=DATA.PM.G_Dt_max/1000; %ms to s
DATA_NEW.PM.Integrator_Z=DATA.PM.Integrator_Z/1000;
DATA_NEW.PM.Integrator_X=DATA.PM.Integrator_X/1000;
DATA_NEW.PM.Integrator_Y=DATA.PM.Integrator_Y/1000;
DATA_NEW.PM.Integrator_Z=DATA.PM.Integrator_Z/1000;

%% CTUN
DATA_NEW.CTUN.AN4=DATA.CTUN.AN4*m2ft; %m/s^2 to ft/s^2

%% NTUN
DATA_NEW.NTUN.Yaw=DATA.NTUN.Yaw/100; %scaling
DATA_NEW.NTUN.WP_dist=DATA.NTUN.WP_dist*m2ft; %m to ft
DATA_NEW.NTUN.Alt_Err=DATA.NTUN.Alt_Err*m2ft; %m to ft
DATA_NEW.NTUN.AS=DATA.NTUN.AS*m2ft; %m/s to ft/s
DATA_NEW.NTUN.NavGScaler=DATA.NTUN.NavGScaler; %scaling

%% RAW
DATA_NEW.RAW.Accel_X=DATA.RAW.Accel_X*m2ft; %m/s^2 to ft/s^2
DATA_NEW.RAW.Accel_Y=DATA.RAW.Accel_Y*m2ft; %m/s^2 to ft/s^2
DATA_NEW.RAW.Accel_Z=DATA.RAW.Accel_Z*m2ft; %m/s^2 to ft/s^2

%% CMD
DATA_NEW.CMD.alt=DATA.CMD.alt*m2ft/100; %cm to ft 
DATA_NEW.CMD.lat=DATA.CMD.lat/1e7; %scaling 
DATA_NEW.CMD.long=DATA.CMD.lng/1e7; %scaling 
