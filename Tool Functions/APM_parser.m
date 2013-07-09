% Parses APM data into struct
% function [DATA] = APM_parser(logFolder, logNo, verbose)
function [DATA] = APM_parser(logFolder, logNo, verbose)
%
% APM_parser.m reads-in all available flight data from pre-downloaded APM
% 2.0 or APM 2.5 flash memory data log files.
%
%
% logFolder     -  filepath to the folder containing the desired log
%                  (string)
%
% logNo         -  the name of the log file to be read-in  (string)
%                  eg:  '2012-10-03 13-07 33.log'
%
% verbose       -  prints entire log file and error report to screen if on,
%                  only displays real-time warnings if off (default)
%
%
% This function will only read in data that was set to be recorded prior to
% flight. In the case that data expected by this function is not available,
% the field will be replaced by an empty array.i.e. if RAW was set to
% 'disabled' prior to flight, it will not be available in the log files and
% will be replaced having empty arrays for 'Gyro_X','Gyro_Y', etc.
%
% NOTE: To add new user-defined 'groups' of data to be logged, add cell
% arrays as needed below.  (Adding groups requires modifing the APM
% firmware through the Arduino IDE.)  Numerical variable groups of
% variables must be kept separate from string-type variable groups.
%
% CAUTION:  This function reads in the data WITHOUT making any conversions.
% All values are in same units as provided by Mission Planner.  i.e. m/s
% is not converted to fps, 100*deg/s not converted to deg/s, UTC.
%
%
%
% Michael Darling
% mdarling@calpoly.edu
% #mikejobs
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modify these cells arrays to define what signal each column corresponds
% to:

% Numerical
NUM.ATT.names = {'Roll', 'Pitch', 'Yaw'};
NUM.GPS.names = {'Time', 'Fix', 'Sats', 'Lat','Long','Son_Alt_Trash','Mix_Alt','GPS_Alt','GR_Speed','CRS'};
NUM.PM.names = {'perf_mon_timer', 'mainLoop_count', 'G_Dt_max', 'gyro_sat_count','renorm_sqrt_count', 'renorm_blowup_count', 'gps_fix_count', 'health', 'Integrator_X', 'Integrator_Y', 'Integrator_Z'};
NUM.CTUN.names = {'Servo_Roll', 'nav_roll', 'roll_sensor', 'Servo_Pitch', 'nav_pitch', 'pitch_sensor', 'Servo_Throttle', 'Servo_Rudder', 'AN4'};
NUM.NTUN.names = {'Yaw', 'WP_dist', 'Target_Bear', 'Nav_Bear', 'Alt_Err', 'AS', 'NavGScaler'};
NUM.RAW.names = {'Gyro_X', 'Gyro_Y', 'Gyro_Z', 'Accel_X', 'Accel_Y','Accel_Z'};
NUM.CMD.names = {'num', 'id', 'pl', 'alt', 'lat', 'lng'};

% Strings
STR.MOD.names = {'MODE'};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3
    verbose = false;
end


logFile = fullfile(logFolder,logNo);
numberoflines=str2num(perl('countlines.pl',logFile));
hwaitbar=waitbar(0,'Parsing data file...','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(hwaitbar,'canceling',0);
%% Initialize

% initialize logs
loggedNames = union(fieldnames(NUM),fieldnames(STR));

% initialize all structure fields to empty
for i = 1:length(loggedNames)
    DATA.(loggedNames{i}).lineNo = [];
    if any(strcmpi(loggedNames{i}, fieldnames(NUM)));
        for j = 1:length(NUM.(loggedNames{i}).names)
            DATA.(loggedNames{i}).(NUM.(loggedNames{i}).names{j}) = [];
        end
        
    elseif any(strcmpi(loggedNames{i}, fieldnames(STR)));
        for j = 1:length(STR.(loggedNames{i}).names)
            DATA.(loggedNames{i}).(STR.(loggedNames{i}).names{j}) = {};
        end
    end
end





%% Read-in

% load in log file and read line-by-line
fid = fopen(logFile,'r');

lineNo = 0;
failures = 0;
WARNINGS = {};
while failures < 10;        % stop trying to read-in after 10 subsequent empty lines
    if getappdata(hwaitbar,'canceling')
        delete(hwaitbar);
        error('Parsing canceled by user');
    end
    if rem(lineNo,2000)==0
        waitbar(lineNo/numberoflines)
    end
    tline = fgetl(fid);
    lineNo = lineNo + 1;
    
    if tline == -1  % if the line is empty, continue to next
        failures = failures + 1;
        tline = ' ';
        if verbose
            disp(' ')
        end
        continue
    else failures = 0;  % reset failure count
    end
    
    
    
    [logName, remdr] = strtok(tline,':');
    is_a_name = isempty(remdr) & ~regexp(logName,'Free RAM');  %protect against missed names
    remdr = remdr(2:end);   % get rid of colon delimiter
    
    
    
    
    
    
    % is a numeric-type
    if any(strcmpi(logName, fieldnames(NUM)))
        name_idx = strcmpi(logName, loggedNames);
        tname = loggedNames{name_idx};
        
        DATA.(tname).lineNo(end+1,:) = lineNo;
        
        % separate the data according to delimiters
        rowData = cell2mat(textscan(remdr,'%f','delimiter',','));
        for j = 1:length(NUM.(tname).names)
            try
                DATA.(tname).(NUM.(tname).names{j})(end+1,:) = rowData(j);
            catch
                DATA.(tname).(NUM.(tname).names{j})(end+1,:) = NaN;
                wrn = ['Failure in line ',num2str(lineNo),' in field "',tname,'.',NUM.(tname).names{j},'".'];
                warning(wrn)
                WARNINGS{end+1,1} = wrn;
            end
        end
        
        
        
        
    % is a string-type
    elseif any(strcmpi(logName, fieldnames(STR)))
        name_idx = strcmpi(logName, loggedNames);
        tname = loggedNames{name_idx};
        
        DATA.(tname).lineNo(end+1,:) = lineNo;
        
        % separate the data according to delimiters
        rowData = textscan(remdr,'%s','delimiter',',');
        for j = 1:length(STR.(tname).names)
            try
                DATA.(tname).(STR.(tname).names{j}){end+1,1} = cell2mat(rowData{j});
            catch
                DATA.(tname).(STR.(tname).names{j}){end+1,1} = 'Not Available';
                wrn = ['Failure in line ',num2str(lineNo),' in field "',tname,'.',NUM.(tname).names{j},'".'];
                warning(wrn)
                WARNINGS{end+1,1} = wrn;
            end
        end
        
        
        
        
    elseif is_a_name
        error(['Log group ' logName 'not recognized by function.'])
    end
    
    
    
 
    
    
    if verbose
        disp(tline)
    end
end

fclose(fid);
delete(hwaitbar)



% Assign data into the caller function's workspace
for i = 1:length(loggedNames)
    assignin('caller',loggedNames{i},DATA.(loggedNames{i}));
end


% Inform user of any read-in failures
if verbose
    disp(' ')
    disp(' ')
    if isempty(WARNINGS)
        disp('File read-in with no errors.')
    else
        disp('---- ERROR REPORT ----')
        disp(' ')
        disp(WARNINGS)
    end
end
