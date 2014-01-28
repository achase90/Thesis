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

% Last Modified by GUIDE v2.5 22-Jan-2014 20:55:47

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

%todo:update the regression when a new variable is selected
addpath('plantFuns');
addpath('guiSupportFiles');
handles.output = hObject;

% Update handles structure
handles.xAxisDefined = false;
handles.yAxisDefined = false;
handles.fileName = 0;
handles.filePath = 0;

% figure('CloseRequestFcn',@closeGui)

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
    [handles] = plotInGui(hObject,eventdata,handles);
end
guidata(hObject, handles);


% --- Executes on button press in loadData.
function loadData_Callback(hObject, eventdata, handles)
% hObject    handle to loadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.fileName,handles.filePath] = uigetfile({'*.bin;*.fdr','All Data Files (*.bin,*.fdr)';'*.fdr','ASCII Data Files';'*.bin','Binary Data Files'},'Select data file to load.');
if ischar(handles.fileName) && ischar(handles.filePath)

    % read in file
    [handles] = readInFile(handles);
    
    %convert raw data to data with units
    [handles.data.Units,handles.adsR] = convertUnits(handles.data.Raw);
    
    rpmThreshold = 4000;
%     handles.hasThrust = handles.data.Units.press3.data > mean(handles.data.Units.press3.data(1:100))-.5; %remove data that is
%     on the ground
    handles.hasThrust = handles.data.Units.pwm7.data < rpmThreshold | handles.data.Units.press3.data > mean(handles.data.Units.press3.data(1:100))-.5;
    % units to state
    [handles.data.State] = unitsToState(handles.data.Units,handles.adsR);
    
    %filter data
%     [handles.data.Filtered] = filterData(handles.data.State);
       
    % set the data type options box to whatever we just called those
    % structures
    set(handles.plotDataType,'String',fieldnames(handles.data));

    % set the data type options box to the first option
    set(handles.plotDataType,'Value',1);
    
    % set the plot options box to contain the field names of that data type
handles = updateAxesOptions(handles);
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
    [handles] = plotInGui(hObject,eventdata,handles);
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
    handles = plotInGui(hObject,eventdata,handles);
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

% pass to plant function
[type] = getDataType(handles);

%todo: instead of outputting the coefficients, output a copy of the input
%struct so it's available to plot
if ~isfield(handles,'SRef')
    set(handles.outputText,'String','Please define SRef before calculating forces.');
elseif ~isfield(handles,'weight')
    set(handles.outputText,'String','Please define Weight before calculating forces.');
else
    handles.plane.W.data = handles.weight;
    handles.plane.W.noise = .001;
    handles.plane.SRef = handles.SRef;
%     plane.adsR = handles.adsR;
%     plane.RAdsAccelP = handles.RAdsAccelP;
    
    if strcmpi(type,'filtered')
        [handles.data.Filtered]=plant(handles.data.Filtered,handles.plane); % only pass state data into the plant
    set(handles.outputText,'String','Forces calculated. To plot, use drop-down menus.');

handles = updateAxesOptions(handles);
    elseif strcmpi(type,'state')
        [handles.data.State]=plant(handles.data.State,handles.plane); % only pass filtered data into the plant
    set(handles.outputText,'String','Forces calculated. To plot, use drop-down menus.');
handles = updateAxesOptions(handles);
    else
%todo: the data axes don't seem to be updating when you press this.
        set(handles.outputText,'String','Setting "Data Type" to state and passing data to plant.');
        set(handles.plotDataType,'Value',3); %todo: when this is up and working,figure out how to query which one is "Filtered" and pass that instead of "4"
        [handles.data.State]=plant(handles.data.State,handles.plane); % only pass state data into the plant
handles = updateAxesOptions(handles);
        set(handles.outputText,'String','Setting "Data Type" to state and passing data to plant. Forces calculated. To plot, use drop-down menus.');

    end
%     handles.hasThrust = handles.hasThrust | handles.data.State.CL.data<-2 | handles.data.State.CL.data>2;
end
% update handles
guidata(hObject,handles);

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
handles.SRef = sscanf(get(hObject,'string'),'%f');
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
    set(handles.outputText,'String','Starting Google Earth...');
    % handles    structure with handles and user data (see GUIDATA)
    [kmlSaveName,kmlPathName] = uiputfile('.kml');
    if ischar(kmlSaveName) && ischar(kmlPathName) %check if the path actually got defined
        handles.kmlSavePath = [kmlPathName kmlSaveName];
        kmlwrite(handles.kmlSavePath, handles.data.Units.gpsLat.data, handles.data.Units.gpsLong.data);
        try
            pathToGE = winqueryreg('HKEY_CURRENT_USER', 'SOFTWARE\Google\Google Earth Plus\', 'InstallLocation');
            status = system(['"' pathToGE 'client\googleearth.exe" "' handles.kmlSavePath '"']);
            set(handles.outputText,'String','Google Earth launched.');
        catch
            set(handles.outputText,'String','Error finding Google Earth, not able to display GPS data.');
        end
    end
else
    set(handles.outputText,'String','Google Earth not supported for *nix file systems, not able to display GPS data.');
end


% --- Executes on selection change in plotDataType.
function plotDataType_Callback(hObject, eventdata, handles)
% hObject    handle to plotDataType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plotDataType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotDataType

%todo: make hitting this button update plot axes options, plots
%themselves, and regressions
handles = updateAxesOptions(handles);
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function plotDataType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotDataType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in errorBarButton.
function errorBarButton_Callback(hObject, eventdata, handles)
% hObject    handle to errorBarButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of errorBarButton
if (get(hObject,'Value'))
if ~(handles.xAxisDefined)
set(handles.outputText,'String','Please set X variable to CL first.');
elseif ~(handles.yAxisDefined)
    set(handles.outputText,'String','Please set Y variable to CD first.');
else
    [xVarName,yVarName] = getAxisNames(handles);
    if ~strcmpi(xVarName,'CL')
        set(handles.outputText,'String','Please set X variable to CL first.');
    elseif ~strcmpi(yVarName,'CD')
            set(handles.outputText,'String','Please set Y variable to CD first.');
    else
        set(handles.outputText,'String','Calculating error bars...');
        guidata(hObject, handles);
        %         plotErrorBars(handles)
        errorBnd = errorProp(handles);
        [hHoriz,hVert] = errorbar2(handles,errorBnd,hObject,eventdata);
        % hold off
        handles.errorBnd = errorBnd;
        set(handles.outputText,'String','Error bars calculated and plotted.');
        % set(handles.outputText,'String','Currently not working.');
    end
end
else
    plotInGui(hObject,eventdata,handles);
end
guidata(hObject, handles);

% --- Executes when user attempts to close mainGuiWindow.
function mainGuiWindow_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to mainGuiWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
assignin('base','handles',handles);
delete(hObject);
