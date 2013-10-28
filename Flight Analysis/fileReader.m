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

% Last Modified by GUIDE v2.5 28-Oct-2013 12:43:00

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

% set(get(handles.dataAxis,'children'),'Xdata',[]);
% set(get(handles.dataAxis,'children'),'ydata',[]);
addpath('plantFuns');
addpath('guiSupportFiles');
handles.output = hObject;

% Update handles structure
handles.xAxisDefined = false;
handles.yAxisDefined = false;
handles.fileName = 0;
handles.filePath = 0;

guidata(hObject, handles);
clc
% UIWAIT makes fileReader wait for user response (see UIRESUME)
% uiwait(handles.mainGuiWindow);

% --- Outputs from this function are returned to the command line.
function varargout = fileReader_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in fileSave.
function fileSave_Callback(hObject, eventdata, handles)
% hObject    handle to fileSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% guidata(hObject, handles);

% --- Executes on button press in stripChartPlotSave.
function stripChartPlotSave_Callback(hObject, eventdata, handles)
% hObject    handle to stripChartPlotSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ischar(handles.fileName) && ischar(handles.filePath)
    handles.stripSaveDir = uigetdir('C:\Users\mufasa\Documents\Thesis\LaTex\figures\sampleOutput');
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


% --- Executes on button press in loadData.
function loadData_Callback(hObject, eventdata, handles)
% hObject    handle to loadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.fileName,handles.filePath] = uigetfile({'*.bin;*.fdr','All Data Files (*.bin,*.fdr)';'*.fdr','ASCII Data Files';'*.bin','Binary Data Files'},'Select data file to load.');
if ischar(handles.fileName) && ischar(handles.filePath)
    
    handles.fullFilePath = [handles.filePath handles.fileName];
    
    binaryFile = isFileBinary(handles.fullFilePath);
    if binaryFile
        input = parseBinary(handles.fullFilePath);
        [handles.data] = fileToStruct(input);
        answer = questdlg('Save ASCII data file?');
        if strcmpi(answer,'yes');
            fileSaveFun(handles);
        end
    else
        input = dlmread(filename, delimiter);
        [handles.data] = fileToStruct(input);
        answer = questdlg('Save ASCII data file?');
        if strcmpi(answer,'yes');
            fileSaveFun(handles);
        end
    end
    [handles] = convertUnits(handles);
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

% --- Executes on button press in ignoreThrust.
function ignoreThrust_Callback(hObject, eventdata, handles)
% hObject    handle to ignoreThrust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ignoreThrust
%redraw plot
if handles.yAxisDefined && handles.xAxisDefined
    plotInGui(hObject,eventdata,handles)
end
%recalc reg
% set(handles.quadFit,'Value',get(handles.quadFit
if get(handles.quadFit,'Value')
    handles = quadraticFitFun(handles);
end
guidata(hObject, handles);

% --- Executes on button press in calcForces.
function calcForces_Callback(hObject, eventdata, handles)
% hObject    handle to calcForces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Noise settings
noise.eulerAngles = .5; %deg
noise.eulerRates = .0875; %deg/s
noise.windAngles = .5; %deg
noise.accel = .0483; %ft/s/s
noise.qbar = .008; %psf
noise.gravity = .01; %ft/s/s
noise.W = 0.001;
% % kalman filter euler angles
% state = eulerKalman(state,noise);
% % kalman filter wind angles
% state = windKalman(state,noise);
%
% [cAero,fAero,cAeroBody]=plant(state,plane);
%
% CD = -cAero(:,1);
% CY = -cAero(:,2);
% CL = -cAero(:,3);
% drag = -fAero(:,1);
% side = -fAero(:,2);
% lift = -fAero(:,3);
handles.data.CD.data = zeros(size(handles.data.time.data));
handles.data.CD.units = '-';
handles.data.CL.data = zeros(size(handles.data.time.data));
handles.data.CL.units = '-';
handles.data.CY.data = zeros(size(handles.data.time.data));
handles.data.CY.units = '-';

% --- Executes on button press in quadFit.
function quadFit_Callback(hObject, eventdata, handles)
% hObject    handle to quadFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of quadFit
if get(hObject,'Value') %when you press ignoreThrust, it updates this, and it doeesn't seem to correctly check if it's been pressed or not todo:
    handles = quadraticFitFun(handles);
else
    if isfield(handles,'regPlot')
        if ishandle(handles.regPlot)
            delete(handles.regPlot);
        end
        normBC = get(gcf,'Color');
        set(handles.quadFormula,'foregroundcolor',normBC)
        %         set(handles.quadFormula,'visible','off');
    end
end
guidata(hObject, handles);


function SRefBox_Callback(hObject, eventdata, handles)
% hObject    handle to SRefBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRefBox as text
%        str2double(get(hObject,'String')) returns contsents of SRefBox as a double
handles.sRef = sscanf(get(hObject,'string'),'%f');
guidata(hObject, handles);


function weightBox_Callback(hObject, eventdata, handles)
% hObject    handle to weightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of weightBox as text
%        str2double(get(hObject,'String')) returns contents of weightBox as a double

handles.weight = sscanf(get(hObject,'string'),'%f');
guidata(hObject, handles);

% --- Executes on button press in plotGE.
function plotGE_Callback(hObject, eventdata, handles)
% hObject    handle to plotGE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ispc
    % handles    structure with handles and user data (see GUIDATA)
    [kmlSaveName,kmlPathName] = uiputfile('.kml');
    if ischar(kmlSaveName) && ischar(kmlPathName) %check if the path actually got defined
        handles.kmlSavePath = [kmlPathName kmlSaveName];
        kmlwrite(handles.kmlSavePath, handles.data.gpsLat.data, handles.data.gpsLong.data);
        try
            pathToGE = winqueryreg('HKEY_CURRENT_USER', 'SOFTWARE\Google\Google Earth Plus\', 'InstallLocation');
            status = system(['"' pathToGE 'client\googleearth.exe" "' handles.kmlSavePath '"']);
        catch
            set(handles.outputText,'String','Error finding Google Earth, not able to display GPS data.');
        end
    end
else
    set(handles.outputText,'String','Google Earth not supported for *nix file systems, not able to display GPS data.');
end


% --- Executes on button press in plantDataOnly.
function plantDataOnly_Callback(hObject, eventdata, handles)
% hObject    handle to plantDataOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plantDataOnly
