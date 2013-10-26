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

% Last Modified by GUIDE v2.5 26-Oct-2013 15:17:57

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

% % --- Read in beaver image
% beaverJpg = imread('beaver.jpg');
% % Put the image array into the pause button
% axes(handles.beaver); %focus on beaver axes
% imshow(beaverJpg); %display beaver image

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

[handles.fileName,handles.filePath] = uigetfile({'*.bin;*.fdr','All Data Files (*.bin,*.fdr)';'*.fdr','ASCII Data Files';'*.bin','Binary Data Files'});
if ischar(handles.fileName) && ischar(handles.filePath)
    
    handles.fullFilePath = [handles.filePath handles.fileName];
    
    binaryFile = isFileBinary(handles.fullFilePath);
    if binaryFile
        input = parseBinary(handles.fullFilePath);
        [handles.data,handles.units] = fileToStruct(input);
        [handles] = convertUnits(handles);
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
    xUnit = handles.data.(xAxis).units;
%     xUnit = char(handles.units(get(handles.xAxisVar,'Value')));
    yAxisVarName = get(handles.yAxisVar,'String');
    yAxis = char(yAxisVarName(get(handles.yAxisVar,'Value')));
%     yUnit = char(handles.units(get(handles.yAxisVar,'Value')));
        yUnit = handles.data.(yAxis).units;


function plotInGui(hObject,eventdata,handles)
[xAxis,yAxis,xUnit,yUnit] = getAxisNames(handles);
xIsNumeric = isnumeric(handles.data.(xAxis).data);
yIsNumeric = isnumeric(handles.data.(yAxis).data);
if xIsNumeric && yIsNumeric
    if length(handles.data.(xAxis).data) ~= length(handles.data.(yAxis).data)
        set(handles.outputText,'String',['Plot vectors must be the same length. HINT: GPS signals can only be plotted against other GPS signals.']);
    else
        %todo:switch to scatter
        plot(handles.dataAxis,handles.data.(xAxis).data,handles.data.(yAxis).data)
        ylabel(handles.dataAxis,[yAxis ' [' yUnit ']']);
        xlabel(handles.dataAxis,[xAxis ' [' xUnit ']']);
        set(handles.outputText,'String','');
        set(handles.dataAxis,'YColor',[1 1 1],'XColor',[1 1 1]);
    end
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
    'press0' 'press1' 'press2' 'press3' 'msgID1' 'msgID2' 'msgID3' 'msgID4' 'msgID5'...
    'utcTime' 'gpsStatus' 'gpsLat' 'nsInd' 'gpsLong' 'ewInd' 'gpsSpd' 'gpsCrs'...
    'date' 'mode' 'CS' 'temperature' 'deltaT'};

units={'sec' 'ft/s^2' 'ft/s^2' 'ft/s^2' 'deg/s' 'deg/s' 'deg/s' 'deg' 'deg' 'deg' ...
    'press0' 'press1' 'press2' 'press3' '-' '-' '-' '-' '-'...
    'utcTime' '-' 'deg' '-' 'deg' '-' 'ft/s' 'gpsCrs'...
    'date' '-' 'CS' 'temperature' 'sec'};

for i=1:length(headers)
    data.(headers{i})=[];
    data.(headers{i}).data=[];
    data.(headers{i}).units=[];
end

if isstruct(input)
    for i=1:length(headers)
        data.(headers{i}) = input(:,i);
                data.(headers{i}).units = units{i};
    end
elseif iscell(input);
    for i=1:length(headers)
%todo:modify data struct. for each field, should have data and units
        data.(headers{i}).data = cell2mat(input(:,i));
        data.(headers{i}).units = units{i};
    end
end


% --- Executes on button press in calcForces.
function calcForces_Callback(hObject, eventdata, handles)
% hObject    handle to calcForces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in quadFit.
function quadFit_Callback(hObject, eventdata, handles)
% hObject    handle to quadFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of quadFit
if get(hObject,'Value')
    [xAxis,yAxis] = getAxisNames(handles);
    xIsNumeric = isnumeric(handles.data.(xAxis).data);
    yIsNumeric = isnumeric(handles.data.(yAxis).data);
    if handles.xAxisDefined && handles.yAxisDefined
        if length(handles.data.(xAxis).data) ~= length(handles.data.(yAxis).data)
            set(handles.quadFormula,'String','Vectors must be the same length.','Foregroundcolor',[1 1 1]);
        elseif ~xIsNumeric
            set(handles.quadFormula,'String',['Variable ''' xAxis ''' is not numeric.'],'Foregroundcolor',[1 1 1]);
        elseif ~yIsNumeric
            set(handles.quadFormula,'String',['Variable ''' yAxis ''' is not numeric.'],'Foregroundcolor',[1 1 1]);
        else
            [xAxis,yAxis] = getAxisNames(handles);
            xData = double(handles.data.(xAxis).data);
            yData = double(handles.data.(yAxis).data);
            p1 = polyfit(xData,yData,2);
            xVec = linspace(min(xData),max(xData));
            yVec = polyval(p1,xVec);
            axes(handles.dataAxis);
            hold on
            handles.regPlot = plot(xVec,yVec,'--k');
            hold off
            regStr = sprintf('%5.3fX^2+%5.3fX+%5.3f',p1);
            %         xLimits = get(handles.dataAxis,'xlim');
            %         yLimits = get(handles.dataAxis,'ylim');
            set(handles.quadFormula,'String',regStr,'foregroundcolor',[1 1 1]);
        end
    end
else
    if isfield(handles,'regPlot')
        delete(handles.regPlot);
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
%        str2double(get(hObject,'String')) returns contents of SRefBox as a double


% --- Executes during object creation, after setting all properties.
function SRefBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRefBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function weightBox_Callback(hObject, eventdata, handles)
% hObject    handle to weightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of weightBox as text
%        str2double(get(hObject,'String')) returns contents of weightBox as a double


% --- Executes during object creation, after setting all properties.
function weightBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to weightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function quadFormula_CreateFcn(hObject, eventdata, handles)
% hObject    handle to quadFormula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotGE.
function plotGE_Callback(hObject, eventdata, handles)
% hObject    handle to plotGE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ispc
    % handles    structure with handles and user data (see GUIDATA)
        [kmlSaveName,kmlPathName] = uiputfile('.kml');
        if ischar(kmlSaveName) && ischar(kmlPathName)
            handles.kmlSavePath = [kmlPathName kmlSaveName];
        end       
    kmlwrite(handles.kmlSavePath, handles.data.gpsLat.data, handles.data.gpsLong.data);
    try
    pathToGE = winqueryreg('HKEY_CURRENT_USER', 'SOFTWARE\Google\Google Earth Plus\', 'InstallLocation');
    status = system(['"' pathToGE 'client\googleearth.exe" "' handles.kmlSavePath '"']);
    catch
        set(handles.outputText,'String','Error finding Google Earth, not able to display GPS data.');
    end
else
    !which googleearth
end