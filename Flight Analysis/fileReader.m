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

% Last Modified by GUIDE v2.5 25-Oct-2013 16:38:00

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
guidata(hObject, handles);

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



function filePath_Callback(hObject, eventdata, handles)
% hObject    handle to filePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filePath as text
%        str2double(get(hObject,'String')) returns contents of filePath as a double

filePath = get(hObject,'String');

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
