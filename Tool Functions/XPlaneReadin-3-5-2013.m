% Reads in XPlane data in the format collected on 3/5/2013
% [(bunch of vectors)]=APM_splitter(datafile,startrow,endrow)
function [freqsec,timeratio,visratio,grndratio,flitratio,realtime,totltime,missntime,timertime,zulutime,localtime,hobbstime,exploDIM,exploUSE,cratrDIM,cratrUSE,puffsTOT,puffsVIS,trisvis,qdepth,Vindkias,Vindkeas,Vtruektas,Vtruektgs,Vindmph,Vtruemphas,Vtruemphgs,Machratio,VVIfpm,Gloadnorml,Gloadaxial,Gloadside,sweep1deg,sweep2deg,sweephdeg,vectratio,sweepratio,incidratio,dihedratio,retraratio,trimelev,trimailrn,trimruddr,flaphandl,flappostn,slatratio,sbrakhandl,sbrakpostn,Qds,Pds,Rds,pitchdeg,rolldeg,hdingtrue,hdingmag,magcomp,mavardeg,alphadeg,betadeg,hpathdeg,vpathdeg,slipdeg,latdeg,londeg,altftmsl,altftagl,altind,latsouth,lonwest,Xm,Ym,Zm,vXms,vYms,vZms,distft,distnm,lat1deg,lat2deg,lat3deg,lat4deg,lat5deg,lat6deg,lat7deg,lat8deg,lon1deg,lon2deg,lon3deg,lon4deg,lon5deg,lon6deg,lon7deg,lon8deg,alt1ftmsl,alt2ftmsl,alt3ftmsl,alt4ftmsl,alt5ftmsl,alt6ftmsl,alt7ftmsl,alt8ftmsl,thrst1lb,emptylb,payldlb,fueltotlb,jettilb,curntlb,maximlb,cgftref,liftlb,draglb,sidelb,normllb,axiallb,sidelb1,gearlb,gearlb1,gearlb2,pitchlb,rolllb,hdnglb,lbrklb,rbrklb,vert1tvect,latr1tvect,wing1lift,wing1lift1,wing1drag,wing1drag1,hstablift,hstablift1,vstb1lift,hstabdrag,hstabdrag1,vstb1drag] = XPlaneReadin(filename, startRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [FREQSEC,TIMERATIO,VISRATIO,GRNDRATIO,FLITRATIO,REALTIME,TOTLTIME,MISSNTIME,TIMERTIME,ZULUTIME,LOCALTIME,HOBBSTIME,EXPLODIM,EXPLOUSE,CRATRDIM,CRATRUSE,PUFFSTOT,PUFFSVIS,TRISVIS,QDEPTH,VINDKIAS,VINDKEAS,VTRUEKTAS,VTRUEKTGS,VINDMPH,VTRUEMPHAS,VTRUEMPHGS,MACHRATIO,VVIFPM,GLOADNORML,GLOADAXIAL,GLOADSIDE,SWEEP1DEG,SWEEP2DEG,SWEEPHDEG,VECTRATIO,SWEEPRATIO,INCIDRATIO,DIHEDRATIO,RETRARATIO,TRIMELEV,TRIMAILRN,TRIMRUDDR,FLAPHANDL,FLAPPOSTN,SLATRATIO,SBRAKHANDL,SBRAKPOSTN,QDS,PDS,RDS,PITCHDEG,ROLLDEG,HDINGTRUE,HDINGMAG,MAGCOMP,MAVARDEG,ALPHADEG,BETADEG,HPATHDEG,VPATHDEG,SLIPDEG,LATDEG,LONDEG,ALTFTMSL,ALTFTAGL,ALTIND,LATSOUTH,LONWEST,XM,YM,ZM,VXMS,VYMS,VZMS,DISTFT,DISTNM,LAT1DEG,LAT2DEG,LAT3DEG,LAT4DEG,LAT5DEG,LAT6DEG,LAT7DEG,LAT8DEG,LON1DEG,LON2DEG,LON3DEG,LON4DEG,LON5DEG,LON6DEG,LON7DEG,LON8DEG,ALT1FTMSL,ALT2FTMSL,ALT3FTMSL,ALT4FTMSL,ALT5FTMSL,ALT6FTMSL,ALT7FTMSL,ALT8FTMSL,THRST1LB,EMPTYLB,PAYLDLB,FUELTOTLB,JETTILB,CURNTLB,MAXIMLB,CGFTREF,LIFTLB,DRAGLB,SIDELB,NORMLLB,AXIALLB,SIDELB1,GEARLB,GEARLB1,GEARLB2,PITCHLB,ROLLLB,HDNGLB,LBRKLB,RBRKLB,VERT1TVECT,LATR1TVECT,WING1LIFT,WING1LIFT1,WING1DRAG,WING1DRAG1,HSTABLIFT,HSTABLIFT1,VSTB1LIFT,HSTABDRAG,HSTABDRAG1,VSTB1DRAG]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [FREQSEC,TIMERATIO,VISRATIO,GRNDRATIO,FLITRATIO,REALTIME,TOTLTIME,MISSNTIME,TIMERTIME,ZULUTIME,LOCALTIME,HOBBSTIME,EXPLODIM,EXPLOUSE,CRATRDIM,CRATRUSE,PUFFSTOT,PUFFSVIS,TRISVIS,QDEPTH,VINDKIAS,VINDKEAS,VTRUEKTAS,VTRUEKTGS,VINDMPH,VTRUEMPHAS,VTRUEMPHGS,MACHRATIO,VVIFPM,GLOADNORML,GLOADAXIAL,GLOADSIDE,SWEEP1DEG,SWEEP2DEG,SWEEPHDEG,VECTRATIO,SWEEPRATIO,INCIDRATIO,DIHEDRATIO,RETRARATIO,TRIMELEV,TRIMAILRN,TRIMRUDDR,FLAPHANDL,FLAPPOSTN,SLATRATIO,SBRAKHANDL,SBRAKPOSTN,QDS,PDS,RDS,PITCHDEG,ROLLDEG,HDINGTRUE,HDINGMAG,MAGCOMP,MAVARDEG,ALPHADEG,BETADEG,HPATHDEG,VPATHDEG,SLIPDEG,LATDEG,LONDEG,ALTFTMSL,ALTFTAGL,ALTIND,LATSOUTH,LONWEST,XM,YM,ZM,VXMS,VYMS,VZMS,DISTFT,DISTNM,LAT1DEG,LAT2DEG,LAT3DEG,LAT4DEG,LAT5DEG,LAT6DEG,LAT7DEG,LAT8DEG,LON1DEG,LON2DEG,LON3DEG,LON4DEG,LON5DEG,LON6DEG,LON7DEG,LON8DEG,ALT1FTMSL,ALT2FTMSL,ALT3FTMSL,ALT4FTMSL,ALT5FTMSL,ALT6FTMSL,ALT7FTMSL,ALT8FTMSL,THRST1LB,EMPTYLB,PAYLDLB,FUELTOTLB,JETTILB,CURNTLB,MAXIMLB,CGFTREF,LIFTLB,DRAGLB,SIDELB,NORMLLB,AXIALLB,SIDELB1,GEARLB,GEARLB1,GEARLB2,PITCHLB,ROLLLB,HDNGLB,LBRKLB,RBRKLB,VERT1TVECT,LATR1TVECT,WING1LIFT,WING1LIFT1,WING1DRAG,WING1DRAG1,HSTABLIFT,HSTABLIFT1,VSTB1LIFT,HSTABDRAG,HSTABDRAG1,VSTB1DRAG]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [freqsec,timeratio,visratio,grndratio,flitratio,realtime,totltime,missntime,timertime,zulutime,localtime,hobbstime,exploDIM,exploUSE,cratrDIM,cratrUSE,puffsTOT,puffsVIS,trisvis,qdepth,Vindkias,Vindkeas,Vtruektas,Vtruektgs,Vindmph,Vtruemphas,Vtruemphgs,Machratio,VVIfpm,Gloadnorml,Gloadaxial,Gloadside,sweep1deg,sweep2deg,sweephdeg,vectratio,sweepratio,incidratio,dihedratio,retraratio,trimelev,trimailrn,trimruddr,flaphandl,flappostn,slatratio,sbrakhandl,sbrakpostn,Qds,Pds,Rds,pitchdeg,rolldeg,hdingtrue,hdingmag,magcomp,mavardeg,alphadeg,betadeg,hpathdeg,vpathdeg,slipdeg,latdeg,londeg,altftmsl,altftagl,altind,latsouth,lonwest,Xm,Ym,Zm,vXms,vYms,vZms,distft,distnm,lat1deg,lat2deg,lat3deg,lat4deg,lat5deg,lat6deg,lat7deg,lat8deg,lon1deg,lon2deg,lon3deg,lon4deg,lon5deg,lon6deg,lon7deg,lon8deg,alt1ftmsl,alt2ftmsl,alt3ftmsl,alt4ftmsl,alt5ftmsl,alt6ftmsl,alt7ftmsl,alt8ftmsl,thrst1lb,emptylb,payldlb,fueltotlb,jettilb,curntlb,maximlb,cgftref,liftlb,draglb,sidelb,normllb,axiallb,sidelb1,gearlb,gearlb1,gearlb2,pitchlb,rolllb,hdnglb,lbrklb,rbrklb,vert1tvect,latr1tvect,wing1lift,wing1lift1,wing1drag,wing1drag1,hstablift,hstablift1,vstb1lift,hstabdrag,hstabdrag1,vstb1drag]
%   = importfile('Data 3-5-2013.txt',2, 656);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2013/03/05 12:03:53

%% Initialize variables.
    endRow=perl('countlines.pl',filename);

delimiter = {' ','|'};
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
%   column101: text (%f)
%	column102: text (%f)
%   column103: text (%f)
%	column104: text (%f)
%   column105: text (%f)
%	column106: text (%f)
%   column107: text (%f)
%	column108: text (%f)
%   column109: text (%f)
%	column110: text (%f)
%   column111: text (%f)
%	column112: text (%f)
%   column113: text (%f)
%	column114: text (%f)
%   column115: text (%f)
%	column116: text (%f)
%   column117: text (%f)
%	column118: text (%f)
%   column119: text (%f)
%	column120: text (%f)
%   column121: text (%f)
%	column122: text (%f)
%   column123: text (%f)
%	column124: text (%f)
%   column125: text (%f)
%	column126: text (%f)
%   column127: text (%f)
%	column128: text (%f)
%   column129: text (%f)
%	column130: text (%f)
%   column131: text (%f)
%	column132: text (%f)
%   column133: text (%f)
%	column134: text (%f)
%   column135: text (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

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

%% Allocate imported array to column variable names
freqsec = dataArray{:, 1};
timeratio = dataArray{:, 2};
visratio = dataArray{:, 3};
grndratio = dataArray{:, 4};
flitratio = dataArray{:, 5};
realtime = dataArray{:, 6};
totltime = dataArray{:, 7};
missntime = dataArray{:, 8};
timertime = dataArray{:, 9};
zulutime = dataArray{:, 10};
localtime = dataArray{:, 11};
hobbstime = dataArray{:, 12};
exploDIM = dataArray{:, 13};
exploUSE = dataArray{:, 14};
cratrDIM = dataArray{:, 15};
cratrUSE = dataArray{:, 16};
puffsTOT = dataArray{:, 17};
puffsVIS = dataArray{:, 18};
trisvis = dataArray{:, 19};
qdepth = dataArray{:, 20};
Vindkias = dataArray{:, 21};
Vindkeas = dataArray{:, 22};
Vtruektas = dataArray{:, 23};
Vtruektgs = dataArray{:, 24};
Vindmph = dataArray{:, 25};
Vtruemphas = dataArray{:, 26};
Vtruemphgs = dataArray{:, 27};
Machratio = dataArray{:, 28};
VVIfpm = dataArray{:, 29};
Gloadnorml = dataArray{:, 30};
Gloadaxial = dataArray{:, 31};
Gloadside = dataArray{:, 32};
sweep1deg = dataArray{:, 33};
sweep2deg = dataArray{:, 34};
sweephdeg = dataArray{:, 35};
vectratio = dataArray{:, 36};
sweepratio = dataArray{:, 37};
incidratio = dataArray{:, 38};
dihedratio = dataArray{:, 39};
retraratio = dataArray{:, 40};
trimelev = dataArray{:, 41};
trimailrn = dataArray{:, 42};
trimruddr = dataArray{:, 43};
flaphandl = dataArray{:, 44};
flappostn = dataArray{:, 45};
slatratio = dataArray{:, 46};
sbrakhandl = dataArray{:, 47};
sbrakpostn = dataArray{:, 48};
Qds = dataArray{:, 49};
Pds = dataArray{:, 50};
Rds = dataArray{:, 51};
pitchdeg = dataArray{:, 52};
rolldeg = dataArray{:, 53};
hdingtrue = dataArray{:, 54};
hdingmag = dataArray{:, 55};
magcomp = dataArray{:, 56};
mavardeg = dataArray{:, 57};
alphadeg = dataArray{:, 58};
betadeg = dataArray{:, 59};
hpathdeg = dataArray{:, 60};
vpathdeg = dataArray{:, 61};
slipdeg = dataArray{:, 62};
latdeg = dataArray{:, 63};
londeg = dataArray{:, 64};
altftmsl = dataArray{:, 65};
altftagl = dataArray{:, 66};
altind = dataArray{:, 67};
latsouth = dataArray{:, 68};
lonwest = dataArray{:, 69};
Xm = dataArray{:, 70};
Ym = dataArray{:, 71};
Zm = dataArray{:, 72};
vXms = dataArray{:, 73};
vYms = dataArray{:, 74};
vZms = dataArray{:, 75};
distft = dataArray{:, 76};
distnm = dataArray{:, 77};
lat1deg = dataArray{:, 78};
lat2deg = dataArray{:, 79};
lat3deg = dataArray{:, 80};
lat4deg = dataArray{:, 81};
lat5deg = dataArray{:, 82};
lat6deg = dataArray{:, 83};
lat7deg = dataArray{:, 84};
lat8deg = dataArray{:, 85};
lon1deg = dataArray{:, 86};
lon2deg = dataArray{:, 87};
lon3deg = dataArray{:, 88};
lon4deg = dataArray{:, 89};
lon5deg = dataArray{:, 90};
lon6deg = dataArray{:, 91};
lon7deg = dataArray{:, 92};
lon8deg = dataArray{:, 93};
alt1ftmsl = dataArray{:, 94};
alt2ftmsl = dataArray{:, 95};
alt3ftmsl = dataArray{:, 96};
alt4ftmsl = dataArray{:, 97};
alt5ftmsl = dataArray{:, 98};
alt6ftmsl = dataArray{:, 99};
alt7ftmsl = dataArray{:, 100};
alt8ftmsl = dataArray{:, 101};
thrst1lb = dataArray{:, 102};
emptylb = dataArray{:, 103};
payldlb = dataArray{:, 104};
fueltotlb = dataArray{:, 105};
jettilb = dataArray{:, 106};
curntlb = dataArray{:, 107};
maximlb = dataArray{:, 108};
cgftref = dataArray{:, 109};
liftlb = dataArray{:, 110};
draglb = dataArray{:, 111};
sidelb = dataArray{:, 112};
normllb = dataArray{:, 113};
axiallb = dataArray{:, 114};
sidelb1 = dataArray{:, 115};
gearlb = dataArray{:, 116};
gearlb1 = dataArray{:, 117};
gearlb2 = dataArray{:, 118};
pitchlb = dataArray{:, 119};
rolllb = dataArray{:, 120};
hdnglb = dataArray{:, 121};
lbrklb = dataArray{:, 122};
rbrklb = dataArray{:, 123};
vert1tvect = dataArray{:, 124};
latr1tvect = dataArray{:, 125};
wing1lift = dataArray{:, 126};
wing1lift1 = dataArray{:, 127};
wing1drag = dataArray{:, 128};
wing1drag1 = dataArray{:, 129};
hstablift = dataArray{:, 130};
hstablift1 = dataArray{:, 131};
vstb1lift = dataArray{:, 132};
hstabdrag = dataArray{:, 133};
hstabdrag1 = dataArray{:, 134};
vstb1drag = dataArray{:, 135};

