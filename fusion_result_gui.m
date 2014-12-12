function varargout = fusion_result_gui(varargin)
% FUSION_RESULT_GUI M-file for fusion_result_gui.fig
%      FUSION_RESULT_GUI, by itself, creates a new FUSION_RESULT_GUI or raises the existing
%      singleton*.
%
%      H = FUSION_RESULT_GUI returns the handle to a new FUSION_RESULT_GUI or the handle to
%      the existing singleton*.
%
%      FUSION_RESULT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FUSION_RESULT_GUI.M with the given input arguments.
%
%      FUSION_RESULT_GUI('Property','Value',...) creates a new FUSION_RESULT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fusion_result_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fusion_result_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fusion_result_gui

% Last Modified by GUIDE v2.5 19-Nov-2014 19:29:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fusion_result_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @fusion_result_gui_OutputFcn, ...
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


% --- Executes just before fusion_result_gui is made visible.
function fusion_result_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fusion_result_gui (see VARARGIN)

% Choose default command line output for FusedGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

mainFigureHandle  = Fusion_Gui; %stores the figure handle of Daniel's GUI here
 
% Access main figure's data
mainData = guidata(mainFigureHandle); 
 
% get ms,pan and fused image
handles.F = mainData.F;
% handles.Fnormed = mainData.Fnormed;
handles.M= mainData.M;

handles.P=mainData.P;

%plot ms, pan and fused images
axes(handles.ms_axis);
handles.M=uint8(handles.M);
imagesc(handles.M);

axes(handles.pan_axis);
handles.P=uint8(handles.P);
imagesc(handles.P);

axes(handles.fused_axis);
imagesc(handles.F);
axis off;

% UIWAIT makes fusion_result_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fusion_result_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in view_ms.
function view_ms_Callback(hObject, eventdata, handles)
% hObject    handle to view_ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in view_pan.
function view_pan_Callback(hObject, eventdata, handles)
% hObject    handle to view_pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in view_fused.
function view_fused_Callback(hObject, eventdata, handles)
% hObject    handle to view_fused (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
