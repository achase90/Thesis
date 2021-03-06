function [realtime,totltime,missntime,timertime,zulutime,localtime,hobbstime,Vindkias,Vindkeas,Vtruektas,Vtruektgs,Vindmph,Vtruemphas,Vtruemphgs,Machratio,VVIfpm,Gloadnorml,Gloadaxial,Gloadside,sweep1deg,sweep2deg,sweephdeg,vectratio,sweepratio,incidratio,dihedratio,retraratio,trimelev,trimailrn,trimruddr,flaphandl,flappostn,slatratio,sbrakhandl,sbrakpostn,gear01,wbrakpart,lbrakpart,rbrakpart,Qds,Pds,Rds,pitchdeg,rolldeg,hdingtrue,hdingmag,magcomp,mavardeg,alphadeg,betadeg,hpathdeg,vpathdeg,slipdeg,Xm,Ym,Zm,vXms,vYms,vZms,distft,distnm,alt1ftmsl,alt2ftmsl,alt3ftmsl,alt4ftmsl,alt5ftmsl,alt6ftmsl,alt7ftmsl,alt8ftmsl,thrst1lb,fuel1lb,fuel2lb,fuel3lb,fuel4lb,fuel5lb,fuel6lb,fuel7lb,fuel8lb,emptylb,payldlb,fueltotlb,jettilb,curntlb,maximlb,cgftref,liftlb,draglb,sidelb,normllb,axiallb,sidelb1,gearlb,gearlb1,gearlb2,LDratio,cltotal,cdtotal,vert1tvect,latr1tvect,wing1lift,wing1lift1,wing2lift,wing2lift1,wing1drag,wing1drag1,wing2drag,wing2drag1,hstablift,hstablift1,vstb1lift,vstb2lift,hstabdrag,hstabdrag1,vstb1drag,vstb2drag] = XPlaneReadin_3_28_2013(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [REALTIME,TOTLTIME,MISSNTIME,TIMERTIME,ZULUTIME,LOCALTIME,HOBBSTIME,VINDKIAS,VINDKEAS,VTRUEKTAS,VTRUEKTGS,VINDMPH,VTRUEMPHAS,VTRUEMPHGS,MACHRATIO,VVIFPM,GLOADNORML,GLOADAXIAL,GLOADSIDE,SWEEP1DEG,SWEEP2DEG,SWEEPHDEG,VECTRATIO,SWEEPRATIO,INCIDRATIO,DIHEDRATIO,RETRARATIO,TRIMELEV,TRIMAILRN,TRIMRUDDR,FLAPHANDL,FLAPPOSTN,SLATRATIO,SBRAKHANDL,SBRAKPOSTN,GEAR01,WBRAKPART,LBRAKPART,RBRAKPART,QDS,PDS,RDS,PITCHDEG,ROLLDEG,HDINGTRUE,HDINGMAG,MAGCOMP,MAVARDEG,ALPHADEG,BETADEG,HPATHDEG,VPATHDEG,SLIPDEG,XM,YM,ZM,VXMS,VYMS,VZMS,DISTFT,DISTNM,ALT1FTMSL,ALT2FTMSL,ALT3FTMSL,ALT4FTMSL,ALT5FTMSL,ALT6FTMSL,ALT7FTMSL,ALT8FTMSL,THRST1LB,FUEL1LB,FUEL2LB,FUEL3LB,FUEL4LB,FUEL5LB,FUEL6LB,FUEL7LB,FUEL8LB,EMPTYLB,PAYLDLB,FUELTOTLB,JETTILB,CURNTLB,MAXIMLB,CGFTREF,LIFTLB,DRAGLB,SIDELB,NORMLLB,AXIALLB,SIDELB1,GEARLB,GEARLB1,GEARLB2,LDRATIO,CLTOTAL,CDTOTAL,VERT1TVECT,LATR1TVECT,WING1LIFT,WING1LIFT1,WING2LIFT,WING2LIFT1,WING1DRAG,WING1DRAG1,WING2DRAG,WING2DRAG1,HSTABLIFT,HSTABLIFT1,VSTB1LIFT,VSTB2LIFT,HSTABDRAG,HSTABDRAG1,VSTB1DRAG,VSTB2DRAG]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [REALTIME,TOTLTIME,MISSNTIME,TIMERTIME,ZULUTIME,LOCALTIME,HOBBSTIME,VINDKIAS,VINDKEAS,VTRUEKTAS,VTRUEKTGS,VINDMPH,VTRUEMPHAS,VTRUEMPHGS,MACHRATIO,VVIFPM,GLOADNORML,GLOADAXIAL,GLOADSIDE,SWEEP1DEG,SWEEP2DEG,SWEEPHDEG,VECTRATIO,SWEEPRATIO,INCIDRATIO,DIHEDRATIO,RETRARATIO,TRIMELEV,TRIMAILRN,TRIMRUDDR,FLAPHANDL,FLAPPOSTN,SLATRATIO,SBRAKHANDL,SBRAKPOSTN,GEAR01,WBRAKPART,LBRAKPART,RBRAKPART,QDS,PDS,RDS,PITCHDEG,ROLLDEG,HDINGTRUE,HDINGMAG,MAGCOMP,MAVARDEG,ALPHADEG,BETADEG,HPATHDEG,VPATHDEG,SLIPDEG,XM,YM,ZM,VXMS,VYMS,VZMS,DISTFT,DISTNM,ALT1FTMSL,ALT2FTMSL,ALT3FTMSL,ALT4FTMSL,ALT5FTMSL,ALT6FTMSL,ALT7FTMSL,ALT8FTMSL,THRST1LB,FUEL1LB,FUEL2LB,FUEL3LB,FUEL4LB,FUEL5LB,FUEL6LB,FUEL7LB,FUEL8LB,EMPTYLB,PAYLDLB,FUELTOTLB,JETTILB,CURNTLB,MAXIMLB,CGFTREF,LIFTLB,DRAGLB,SIDELB,NORMLLB,AXIALLB,SIDELB1,GEARLB,GEARLB1,GEARLB2,LDRATIO,CLTOTAL,CDTOTAL,VERT1TVECT,LATR1TVECT,WING1LIFT,WING1LIFT1,WING2LIFT,WING2LIFT1,WING1DRAG,WING1DRAG1,WING2DRAG,WING2DRAG1,HSTABLIFT,HSTABLIFT1,VSTB1LIFT,VSTB2LIFT,HSTABDRAG,HSTABDRAG1,VSTB1DRAG,VSTB2DRAG]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [realtime,totltime,missntime,timertime,zulutime,localtime,hobbstime,Vindkias,Vindkeas,Vtruektas,Vtruektgs,Vindmph,Vtruemphas,Vtruemphgs,Machratio,VVIfpm,Gloadnorml,Gloadaxial,Gloadside,sweep1deg,sweep2deg,sweephdeg,vectratio,sweepratio,incidratio,dihedratio,retraratio,trimelev,trimailrn,trimruddr,flaphandl,flappostn,slatratio,sbrakhandl,sbrakpostn,gear01,wbrakpart,lbrakpart,rbrakpart,Qds,Pds,Rds,pitchdeg,rolldeg,hdingtrue,hdingmag,magcomp,mavardeg,alphadeg,betadeg,hpathdeg,vpathdeg,slipdeg,Xm,Ym,Zm,vXms,vYms,vZms,distft,distnm,alt1ftmsl,alt2ftmsl,alt3ftmsl,alt4ftmsl,alt5ftmsl,alt6ftmsl,alt7ftmsl,alt8ftmsl,thrst1lb,fuel1lb,fuel2lb,fuel3lb,fuel4lb,fuel5lb,fuel6lb,fuel7lb,fuel8lb,emptylb,payldlb,fueltotlb,jettilb,curntlb,maximlb,cgftref,liftlb,draglb,sidelb,normllb,axiallb,sidelb1,gearlb,gearlb1,gearlb2,LDratio,cltotal,cdtotal,vert1tvect,latr1tvect,wing1lift,wing1lift1,wing2lift,wing2lift1,wing1drag,wing1drag1,wing2drag,wing2drag1,hstablift,hstablift1,vstb1lift,vstb2lift,hstabdrag,hstabdrag1,vstb1drag,vstb2drag]
%   = importfile('Data-3-28-2013.txt',2, 474);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2013/03/28 13:47:17

%% Initialize variables.
delimiter = '|';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
%   column13: double (%f)
%	column14: double (%f)
%   column15: double (%f)
%	column16: double (%f)
%   column17: double (%f)
%	column18: double (%f)
%   column19: double (%f)
%	column20: double (%f)
%   column21: double (%f)
%	column22: double (%f)
%   column23: double (%f)
%	column24: double (%f)
%   column25: double (%f)
%	column26: double (%f)
%   column27: double (%f)
%	column28: double (%f)
%   column29: double (%f)
%	column30: double (%f)
%   column31: double (%f)
%	column32: double (%f)
%   column33: double (%f)
%	column34: double (%f)
%   column35: double (%f)
%	column36: double (%f)
%   column37: double (%f)
%	column38: double (%f)
%   column39: double (%f)
%	column40: double (%f)
%   column41: double (%f)
%	column42: double (%f)
%   column43: double (%f)
%	column44: double (%f)
%   column45: double (%f)
%	column46: double (%f)
%   column47: double (%f)
%	column48: double (%f)
%   column49: double (%f)
%	column50: double (%f)
%   column51: double (%f)
%	column52: double (%f)
%   column53: double (%f)
%	column54: double (%f)
%   column55: double (%f)
%	column56: double (%f)
%   column57: double (%f)
%	column58: double (%f)
%   column59: double (%f)
%	column60: double (%f)
%   column61: double (%f)
%	column62: double (%f)
%   column63: double (%f)
%	column64: double (%f)
%   column65: double (%f)
%	column66: double (%f)
%   column67: double (%f)
%	column68: double (%f)
%   column69: double (%f)
%	column70: double (%f)
%   column71: double (%f)
%	column72: double (%f)
%   column73: double (%f)
%	column74: double (%f)
%   column75: double (%f)
%	column76: double (%f)
%   column77: double (%f)
%	column78: double (%f)
%   column79: double (%f)
%	column80: double (%f)
%   column81: double (%f)
%	column82: double (%f)
%   column83: double (%f)
%	column84: double (%f)
%   column85: double (%f)
%	column86: double (%f)
%   column87: double (%f)
%	column88: double (%f)
%   column89: double (%f)
%	column90: double (%f)
%   column91: double (%f)
%	column92: double (%f)
%   column93: double (%f)
%	column94: double (%f)
%   column95: double (%f)
%	column96: double (%f)
%   column97: double (%f)
%	column98: double (%f)
%   column99: double (%f)
%	column100: double (%f)
%   column101: text (%s)
%	column102: text (%s)
%   column103: text (%s)
%	column104: text (%s)
%   column105: text (%s)
%	column106: text (%s)
%   column107: text (%s)
%	column108: text (%s)
%   column109: text (%s)
%	column110: text (%s)
%   column111: text (%s)
%	column112: text (%s)
%   column113: text (%s)
%	column114: text (%s)
%   column115: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

realtime = [];
totltime = [];
missntime = [];
timertime = [];
zulutime = [];
localtime = [];
hobbstime = [];
Vindkias = [];
Vindkeas = [];
Vtruektas = [];
Vtruektgs = [];
Vindmph = [];
Vtruemphas = [];
Vtruemphgs = [];
Machratio = [];
VVIfpm = [];
Gloadnorml = [];
Gloadaxial = [];
Gloadside = [];
sweep1deg = [];
sweep2deg = [];
sweephdeg = [];
vectratio = [];
sweepratio = [];
incidratio = [];
dihedratio = [];
retraratio = [];
trimelev = [];
trimailrn = [];
trimruddr = [];
flaphandl = [];
flappostn = [];
slatratio = [];
sbrakhandl = [];
sbrakpostn = [];
gear01 = [];
wbrakpart = [];
lbrakpart = [];
rbrakpart = [];
Qds = [];
Pds = [];
Rds = [];
pitchdeg = [];
rolldeg = [];
hdingtrue = [];
hdingmag = [];
magcomp = [];
mavardeg = [];
alphadeg = [];
betadeg = [];
hpathdeg = [];
vpathdeg = [];
slipdeg = [];
Xm = [];
Ym = [];
Zm = [];
vXms = [];
vYms = [];
vZms = [];
distft = [];
distnm = [];
alt1ftmsl = [];
alt2ftmsl = [];
alt3ftmsl = [];
alt4ftmsl = [];
alt5ftmsl = [];
alt6ftmsl = [];
alt7ftmsl = [];
alt8ftmsl = [];
thrst1lb = [];
fuel1lb = [];
fuel2lb = [];
fuel3lb = [];
fuel4lb = [];
fuel5lb = [];
fuel6lb = [];
fuel7lb = [];
fuel8lb = [];
emptylb = [];
payldlb = [];
fueltotlb = [];
jettilb = [];
curntlb = [];
maximlb = [];
cgftref = [];
liftlb = [];
draglb = [];
sidelb = [];
normllb = [];
axiallb = [];
sidelb1 = [];
gearlb = [];
gearlb1 = [];
gearlb2 = [];
LDratio = [];
cltotal = [];
cdtotal = [];
vert1tvect = [];
latr1tvect = [];
wing1lift = [];
%% Initialize column outputs.
% columnIndices = cumsum(~I);

%% Allocate imported array to column variable names
realtime = dataArray{:, 1};
totltime = dataArray{:, 2};
missntime = dataArray{:, 3};
timertime = dataArray{:, 4};
zulutime = dataArray{:, 5};
localtime = dataArray{:, 6};
hobbstime = dataArray{:, 7};
Vindkias = dataArray{:, 8};
Vindkeas = dataArray{:, 9};
Vtruektas = dataArray{:, 10};
Vtruektgs = dataArray{:, 11};
Vindmph = dataArray{:, 12};
Vtruemphas = dataArray{:, 13};
Vtruemphgs = dataArray{:, 14};
Machratio = dataArray{:, 15};
VVIfpm = dataArray{:, 16};
Gloadnorml = dataArray{:, 17};
Gloadaxial = dataArray{:, 18};
Gloadside = dataArray{:, 19};
sweep1deg = dataArray{:, 20};
sweep2deg = dataArray{:, 21};
sweephdeg = dataArray{:, 22};
vectratio = dataArray{:, 23};
sweepratio = dataArray{:, 24};
incidratio = dataArray{:, 25};
dihedratio = dataArray{:, 26};
retraratio = dataArray{:, 27};
trimelev = dataArray{:, 28};
trimailrn = dataArray{:, 29};
trimruddr = dataArray{:, 30};
flaphandl = dataArray{:, 31};
flappostn = dataArray{:, 32};
slatratio = dataArray{:, 33};
sbrakhandl = dataArray{:, 34};
sbrakpostn = dataArray{:, 35};
gear01 = dataArray{:, 36};
wbrakpart = dataArray{:, 37};
lbrakpart = dataArray{:, 38};
rbrakpart = dataArray{:, 39};
Qds = dataArray{:, 40};
Pds = dataArray{:, 41};
Rds = dataArray{:, 42};
pitchdeg = dataArray{:, 43};
rolldeg = dataArray{:, 44};
hdingtrue = dataArray{:, 45};
hdingmag = dataArray{:, 46};
magcomp = dataArray{:, 47};
mavardeg = dataArray{:, 48};
alphadeg = dataArray{:, 49};
betadeg = dataArray{:, 50};
hpathdeg = dataArray{:, 51};
vpathdeg = dataArray{:, 52};
slipdeg = dataArray{:, 53};
Xm = dataArray{:, 54};
Ym = dataArray{:, 55};
Zm = dataArray{:, 56};
vXms = dataArray{:, 57};
vYms = dataArray{:, 58};
vZms = dataArray{:, 59};
distft = dataArray{:, 60};
distnm = dataArray{:, 61};
alt1ftmsl = dataArray{:, 62};
alt2ftmsl = dataArray{:, 63};
alt3ftmsl = dataArray{:, 64};
alt4ftmsl = dataArray{:, 65};
alt5ftmsl = dataArray{:, 66};
alt6ftmsl = dataArray{:, 67};
alt7ftmsl = dataArray{:, 68};
alt8ftmsl = dataArray{:, 69};
thrst1lb = dataArray{:, 70};
fuel1lb = dataArray{:, 71};
fuel2lb = dataArray{:, 72};
fuel3lb = dataArray{:, 73};
fuel4lb = dataArray{:, 74};
fuel5lb = dataArray{:, 75};
fuel6lb = dataArray{:, 76};
fuel7lb = dataArray{:, 77};
fuel8lb = dataArray{:, 78};
emptylb = dataArray{:, 79};
payldlb = dataArray{:, 80};
fueltotlb = dataArray{:, 81};
jettilb = dataArray{:, 82};
curntlb = dataArray{:, 83};
maximlb = dataArray{:, 84};
cgftref = dataArray{:, 85};
liftlb = dataArray{:, 86};
draglb = dataArray{:, 87};
sidelb = dataArray{:, 88};
normllb = dataArray{:, 89};
axiallb = dataArray{:, 90};
sidelb1 = dataArray{:, 91};
gearlb = dataArray{:, 92};
gearlb1 = dataArray{:, 93};
gearlb2 = dataArray{:, 94};
LDratio = dataArray{:, 95};
cltotal = dataArray{:, 96};
cdtotal = dataArray{:, 97};
vert1tvect = dataArray{:, 98};
latr1tvect = dataArray{:, 99};
wing1lift = dataArray{:, 100};
wing1lift1 = dataArray{:, 101};
wing2lift = dataArray{:, 102};
wing2lift1 = dataArray{:, 103};
wing1drag = dataArray{:, 104};
wing1drag1 = dataArray{:, 105};
wing2drag = dataArray{:, 106};
wing2drag1 = dataArray{:, 107};
hstablift = dataArray{:, 108};
hstablift1 = dataArray{:, 109};
vstb1lift = dataArray{:, 110};
vstb2lift = dataArray{:, 111};
hstabdrag = dataArray{:, 112};
hstabdrag1 = dataArray{:, 113};
vstb1drag = dataArray{:, 114};
vstb2drag = dataArray{:, 115};

