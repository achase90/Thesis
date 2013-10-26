function varargout = fileReader(varargin)
% FILEREADER MATLAB code for fileReader.fig
%      FILEREADER, by itself, creates a new FILEREADER or raises the existing
%      singleton*.
%
%      H = FILEREADER returns the handle to a new FILEREADER or the handle to
%      the existing singleton*.
%
%      FILEREADER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILEREADER.M with the given input arguments.
%
%      FILEREADER('Property','Value',...) creates a new FILEREADER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fileReader_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fileReader_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fileReader

% Last Modified by GUIDE v2.5 25-Oct-2013 23:12:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fileReader_OpeningFcn, ...
                   'gui_OutputFcn',  @fileReader_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fileReader is made visible.
function fileReader_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fileReader (see VARARGIN)

% Choose default command line output for fileReader
handles.output = hObject;

% Update handles structure
handles.xAxisDefined = false;
handles.yAxisDefined = false;
handles.fileName = 0;
handles.filePath = 0;
guidata(hObject, handles);
clc
% UIWAIT makes fileReader wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fileReader_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function filePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fileSave.
function fileSave_Callback(hObject, eventdata, handles)
% hObject    handle to fileSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(class(handles.fileName),'char') && strcmp(class(handles.filePath),'char')
    [fileSaveName,filePathName] = uiputfile('.fdr');
    if strcmp(class(fileSaveName),'char') && strcmp(class(filePathName),'char')
        
        handles.fullFileSavePath = [filePathName fileSaveName];
        fileSaveFun(handles)
    end
else
    set(handles.outputText,'String','Please load data before saving data.');
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fileSaveType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileSaveType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stripChartPlotSave.
function stripChartPlotSave_Callback(hObject, eventdata, handles)
% hObject    handle to stripChartPlotSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(class(handles.fileName),'char') && strcmp(class(handles.filePath),'char')
stripChartCreator(hObject,eventdata,handles)
else
    set(handles.outputText,'String','Please load data before outputting strip charts.');
end

% --- Executes on selection change in xAxisVar.
function xAxisVar_Callback(hObject, eventdata, handles)
% hObject    handle to xAxisVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xAxisVar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xAxisVar

handles.xAxisDefined = true;
if (handles.yAxisDefined)
plotInGui(hObject,eventdata,handles);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xAxisVar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xAxisVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadData.
function loadData_Callback(hObject, eventdata, handles)
% hObject    handle to loadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.fileName,handles.filePath] = uigetfile({'*.binfdr;*.fdr','All Data Files (*.binfdr,*.fdr)';'*.fdr','ASCII Data Files';'*.binfdr','Binary Data Files'});
if strcmp(class(handles.fileName),'char') && strcmp(class(handles.filePath),'char')
    
handles.fullFilePath = [handles.filePath handles.fileName];

binaryFile = isFileBinary(handles.fullFilePath);
if binaryFile
input = parseData(handles.fullFilePath);
[handles.data,handles.units] = fileToStruct(input);
%todo:convert units here
else
input = dlmread(filename, delimiter);
[handles.data,handles.units] = fileToStruct(input);
end
set(handles.xAxisVar,'String',fieldnames(handles.data));
set(handles.yAxisVar,'String',fieldnames(handles.data));
end
guidata(hObject, handles);


% --- Executes on selection change in yAxisVar.
function yAxisVar_Callback(hObject, eventdata, handles)
% hObject    handle to yAxisVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns yAxisVar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from yAxisVar

handles.yAxisDefined = true;
if (handles.xAxisDefined)
plotInGui(hObject,eventdata,handles);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function yAxisVar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yAxisVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ignoreThrust.
function ignoreThrust_Callback(hObject, eventdata, handles)
% hObject    handle to ignoreThrust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ignoreThrust


function [xAxis,yAxis,xUnit,yUnit] = getAxisNames(handles)
    xAxisVarName = get(handles.xAxisVar,'String');
    xAxis = char(xAxisVarName(get(handles.xAxisVar,'Value')));
    xUnit = char(handles.units(get(handles.xAxisVar,'Value')));
    yAxisVarName = get(handles.yAxisVar,'String');
    yAxis = char(yAxisVarName(get(handles.yAxisVar,'Value')));
    yUnit = char(handles.units(get(handles.yAxisVar,'Value')));

function plotInGui(hObject,eventdata,handles)
[xAxis,yAxis,xUnit,yUnit] = getAxisNames(handles);
xIsNumeric = isnumeric(handles.data.(xAxis));
yIsNumeric = isnumeric(handles.data.(yAxis));
if xIsNumeric && yIsNumeric
    plot(handles.dataAxis,handles.data.(xAxis),handles.data.(yAxis))
                ylabel([yAxis ' [' yUnit ']']);
                            xlabel([xAxis ' [' xUnit ']']);
else
    if ~xIsNumeric
        set(handles.outputText,'String',['Variable ''' xAxis ''' is not numeric. Please choose a numeric variable to plot.']);
    end
    if ~yIsNumeric
        set(handles.outputText,'String',['Variable ''' yAxis ''' is not numeric. Please choose a numeric variable to plot.']);
    end
end
guidata(hObject, handles);

function TF = isFileBinary(filename)
fid = fopen(filename,'r');

x = fread(fid,200,'char');

 %check if there are characters between 32 and 127, since these are probably
 %going to be in an ASCII file. If there aren't, it's probably a binary
 %file. The exception is line endings, so check for ASCII 10 and 13.
probablyBinary = x<32 | x>127 | x~=10 | x~=13;

if logical(max(probablyBinary))
    TF = true;
end
fclose(fid);

function [data,units] = fileToStruct(input)
headers={'time' 'accelX' 'accelY' 'accelZ' 'gyroX' 'gyroY' 'gyroZ' 'magX' 'magY' 'magZ' ...
    'press0' 'press1' 'msgID1' 'msgID2' 'msgID3' 'msgID4' 'msgID5'...
    'utcTime' 'gpsStatus' 'gpsLat' 'nsInd' 'gpsLong' 'ewInd' 'gpsSpd' 'gpsCrs'...
    'date' 'mode' 'CS' 'temperature' 'deltaT'};

units={'time' 'accelX' 'accelY' 'accelZ' 'gyroX' 'gyroY' 'gyroZ' 'magX' 'magY' 'magZ' ...
    'press0' 'press1' 'msgID1' 'msgID2' 'msgID3' 'msgID4' 'msgID5'...
    'utcTime' 'gpsStatus' 'gpsLat' 'nsInd' 'gpsLong' 'ewInd' 'gpsSpd' 'gpsCrs'...
    'date' 'mode' 'CS' 'temperature' 'deltaT'};

for i=1:length(headers)
    data.(headers{i})=[];
end

if strcmp(class(input),'struct')
    for i=1:length(headers)
        data.(headers{i}) = input(:,i);
    end
elseif strcmp(class(input),'cell');
    for i=1:length(headers)
        data.(headers{i}) = cell2mat(input(:,i));
    end
end


% --- Executes on button press in calcForces.
function calcForces_Callback(hObject, eventdata, handles)
% hObject    handle to calcForces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
