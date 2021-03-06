function [realtime,totltime,missntime,timertime,zulutime,localtime,hobbstime,Machratio,VVIfpm,Gloadnorml,Gloadaxial,Gloadside,Qrads,Prads,Rrads,pitchdeg,rolldeg,hdingtrue,hdingmag,alphadeg,betadeg,hpathdeg,vpathdeg,slipdeg,latdeg,londeg,altftmsl,altftagl,onrunwy,altind,latsouth,lonwest,alt1ftmsl,alt2ftmsl,alt3ftmsl,alt4ftmsl,alt5ftmsl,alt6ftmsl,alt7ftmsl,alt8ftmsl,thrst1lb,fuel1lb,fuel2lb,fuel3lb,fuel4lb,fuel5lb,fuel6lb,fuel7lb,fuel8lb,emptylb,payldlb,fueltotlb,jettilb,curntlb,maximlb,cgftref,liftlb,draglb,sidelb,normllb,axiallb,sidelb1,LDratio,cltotal,cdtotal,LDetaP] = XPlaneReadin_4_3_2013(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [REALTIME,TOTLTIME,MISSNTIME,TIMERTIME,ZULUTIME,LOCALTIME,HOBBSTIME,MACHRATIO,VVIFPM,GLOADNORML,GLOADAXIAL,GLOADSIDE,QRADS,PRADS,RRADS,PITCHDEG,ROLLDEG,HDINGTRUE,HDINGMAG,ALPHADEG,BETADEG,HPATHDEG,VPATHDEG,SLIPDEG,LATDEG,LONDEG,ALTFTMSL,ALTFTAGL,ONRUNWY,ALTIND,LATSOUTH,LONWEST,ALT1FTMSL,ALT2FTMSL,ALT3FTMSL,ALT4FTMSL,ALT5FTMSL,ALT6FTMSL,ALT7FTMSL,ALT8FTMSL,THRST1LB,FUEL1LB,FUEL2LB,FUEL3LB,FUEL4LB,FUEL5LB,FUEL6LB,FUEL7LB,FUEL8LB,EMPTYLB,PAYLDLB,FUELTOTLB,JETTILB,CURNTLB,MAXIMLB,CGFTREF,LIFTLB,DRAGLB,SIDELB,NORMLLB,AXIALLB,SIDELB1,LDRATIO,CLTOTAL,CDTOTAL,LDETAP]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [REALTIME,TOTLTIME,MISSNTIME,TIMERTIME,ZULUTIME,LOCALTIME,HOBBSTIME,MACHRATIO,VVIFPM,GLOADNORML,GLOADAXIAL,GLOADSIDE,QRADS,PRADS,RRADS,PITCHDEG,ROLLDEG,HDINGTRUE,HDINGMAG,ALPHADEG,BETADEG,HPATHDEG,VPATHDEG,SLIPDEG,LATDEG,LONDEG,ALTFTMSL,ALTFTAGL,ONRUNWY,ALTIND,LATSOUTH,LONWEST,ALT1FTMSL,ALT2FTMSL,ALT3FTMSL,ALT4FTMSL,ALT5FTMSL,ALT6FTMSL,ALT7FTMSL,ALT8FTMSL,THRST1LB,FUEL1LB,FUEL2LB,FUEL3LB,FUEL4LB,FUEL5LB,FUEL6LB,FUEL7LB,FUEL8LB,EMPTYLB,PAYLDLB,FUELTOTLB,JETTILB,CURNTLB,MAXIMLB,CGFTREF,LIFTLB,DRAGLB,SIDELB,NORMLLB,AXIALLB,SIDELB1,LDRATIO,CLTOTAL,CDTOTAL,LDETAP]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [realtime,totltime,missntime,timertime,zulutime,localtime,hobbstime,Machratio,VVIfpm,Gloadnorml,Gloadaxial,Gloadside,Qrads,Prads,Rrads,pitchdeg,rolldeg,hdingtrue,hdingmag,alphadeg,betadeg,hpathdeg,vpathdeg,slipdeg,latdeg,londeg,altftmsl,altftagl,onrunwy,altind,latsouth,lonwest,alt1ftmsl,alt2ftmsl,alt3ftmsl,alt4ftmsl,alt5ftmsl,alt6ftmsl,alt7ftmsl,alt8ftmsl,thrst1lb,fuel1lb,fuel2lb,fuel3lb,fuel4lb,fuel5lb,fuel6lb,fuel7lb,fuel8lb,emptylb,payldlb,fueltotlb,jettilb,curntlb,maximlb,cgftref,liftlb,draglb,sidelb,normllb,axiallb,sidelb1,LDratio,cltotal,cdtotal,LDetaP]
%   = importfile('Data_4_3_2013.txt',2, 328);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2013/04/03 14:16:57

%% Initialize variables.
delimiter = '|';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = [dataArray{:,1:end-1}];
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
realtime = cell2mat(raw(:, 1));
totltime = cell2mat(raw(:, 2));
missntime = cell2mat(raw(:, 3));
timertime = cell2mat(raw(:, 4));
zulutime = cell2mat(raw(:, 5));
localtime = cell2mat(raw(:, 6));
hobbstime = cell2mat(raw(:, 7));
Machratio = cell2mat(raw(:, 8));
VVIfpm = cell2mat(raw(:, 9));
Gloadnorml = cell2mat(raw(:, 10));
Gloadaxial = cell2mat(raw(:, 11));
Gloadside = cell2mat(raw(:, 12));
Qrads = cell2mat(raw(:, 13));
Prads = cell2mat(raw(:, 14));
Rrads = cell2mat(raw(:, 15));
pitchdeg = cell2mat(raw(:, 16));
rolldeg = cell2mat(raw(:, 17));
hdingtrue = cell2mat(raw(:, 18));
hdingmag = cell2mat(raw(:, 19));
alphadeg = cell2mat(raw(:, 20));
betadeg = cell2mat(raw(:, 21));
hpathdeg = cell2mat(raw(:, 22));
vpathdeg = cell2mat(raw(:, 23));
slipdeg = cell2mat(raw(:, 24));
latdeg = cell2mat(raw(:, 25));
londeg = cell2mat(raw(:, 26));
altftmsl = cell2mat(raw(:, 27));
altftagl = cell2mat(raw(:, 28));
onrunwy = cell2mat(raw(:, 29));
altind = cell2mat(raw(:, 30));
latsouth = cell2mat(raw(:, 31));
lonwest = cell2mat(raw(:, 32));
alt1ftmsl = cell2mat(raw(:, 33));
alt2ftmsl = cell2mat(raw(:, 34));
alt3ftmsl = cell2mat(raw(:, 35));
alt4ftmsl = cell2mat(raw(:, 36));
alt5ftmsl = cell2mat(raw(:, 37));
alt6ftmsl = cell2mat(raw(:, 38));
alt7ftmsl = cell2mat(raw(:, 39));
alt8ftmsl = cell2mat(raw(:, 40));
thrst1lb = cell2mat(raw(:, 41));
fuel1lb = cell2mat(raw(:, 42));
fuel2lb = cell2mat(raw(:, 43));
fuel3lb = cell2mat(raw(:, 44));
fuel4lb = cell2mat(raw(:, 45));
fuel5lb = cell2mat(raw(:, 46));
fuel6lb = cell2mat(raw(:, 47));
fuel7lb = cell2mat(raw(:, 48));
fuel8lb = cell2mat(raw(:, 49));
emptylb = cell2mat(raw(:, 50));
payldlb = cell2mat(raw(:, 51));
fueltotlb = cell2mat(raw(:, 52));
jettilb = cell2mat(raw(:, 53));
curntlb = cell2mat(raw(:, 54));
maximlb = cell2mat(raw(:, 55));
cgftref = cell2mat(raw(:, 56));
liftlb = cell2mat(raw(:, 57));
draglb = cell2mat(raw(:, 58));
sidelb = cell2mat(raw(:, 59));
normllb = cell2mat(raw(:, 60));
axiallb = cell2mat(raw(:, 61));
sidelb1 = cell2mat(raw(:, 62));
LDratio = cell2mat(raw(:, 63));
cltotal = cell2mat(raw(:, 64));
cdtotal = cell2mat(raw(:, 65));
LDetaP = cell2mat(raw(:, 66));

