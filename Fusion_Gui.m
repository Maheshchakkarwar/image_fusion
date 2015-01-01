function varargout = Fusion_Gui(varargin)
% FUSION_GUI M-file for Fusion_Gui.fig
%      FUSION_GUI, by itself, creates a new FUSION_GUI or raises the existing
%      singleton*.
%
%      H = FUSION_GUI returns the handle to a new FUSION_GUI or the handle to
%      the existing singleton*.
%
%      FUSION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FUSION_GUI.M with the given input arguments.
%
%      FUSION_GUI('Property','Value',...) creates a new FUSION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fusion_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fusion_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fusion_Gui

% Last Modified by GUIDE v2.5 11-Dec-2014 09:59:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fusion_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Fusion_Gui_OutputFcn, ...
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


% --- Executes just before Fusion_Gui is made visible.
function Fusion_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fusion_Gui (see VARARGIN)

% Choose default command line output for Fusion_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fusion_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fusion_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in view_ms_but.
function view_ms_but_Callback(hObject, eventdata, handles)
% hObject    handle to view_ms_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure,
axis on;
plot_ms_image(handles);
% imshow(handles.M);

% --- Executes on button press in view_pan_img.
function view_pan_img_Callback(hObject, eventdata, handles)
% hObject    handle to view_pan_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure,
axis on;
plot_pan_image(handles);
% imshow(handles.P);


% --- Executes on selection change in select_img_popdown.
function select_img_popdown_Callback(hObject, eventdata, handles)
% hObject    handle to select_img_popdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns select_img_popdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_img_popdown
% contents = get(hObject,'String');
selected_item=get(handles.select_img_popdown,'Value');
disp(selected_item);
% print('selected item'+selected_item);
% --- Executes during object creation, after setting all properties.
function select_img_popdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_img_popdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_img_but.
function load_img_but_Callback(hObject, eventdata, handles)
% hObject    handle to load_img_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set images
selected_item=get(handles.select_img_popdown,'Value');
% print('selected item'+selected_item);
if selected_item == 0
    selected_item=1;
end 
cd('Examples');
switch selected_item
    case 1
        filenameM=get(handles.ms_text,'string');
        filenameP=get(handles.pan_text,'string');
        load filenameM
        MS=A;
        load filenameP
        PAN=B;
    case 2
         load M1.mat;
         MS=A;
         load P1.mat;
         PAN=B;
    case 3
         load SATM2.mat;
         MS=A;
         load SATP2.mat;
         PAN=B;
       
    case 4
         load M3.mat;
         MS=A;
         load P3.mat;
         PAN=B;
       
    case 5
         load M8.mat;
         MS=A;
         load P8.mat;
         PAN=B;
    case 6
         load MS2.mat;
         MS=A;
         load PAN2.mat;
         PAN=B;
    
    
end
cd('..');
handles.M=MS;
% handles.M=double(handles.M);
handles.P=PAN;

% handles.P=double(handles.P);
guidata(hObject,handles);

%start displaying MS image to Axis
axes(handles.ms_img_axes);
plot_ms_image(handles);

%Start displaying PAN image to Axis
axes(handles.pan_img_axes);
plot_pan_image(handles);

%set sliders to its initial position
 set(handles. brightning_slider,'Value',0);
 set(handles.darkening_slider,'Value',0);
 
 
function plot_ms_image(handles)
handles.Mnormed=double(handles.M);
[n1,n2,n3]=size(handles.M);
for i=1:n3
    handles.Mnormed(:,:,i)=handles.Mnormed(:,:,i)/max(max(handles.Mnormed(:,:,i)));
end
imagesc(handles.Mnormed(:,:,1:3));
axis off;

function plot_pan_image(handles)
%start displaying PAN image to Axis

handles.Pnormed=handles.P;
% [n1,n2,n3]=size(handles.P);
% for i=1:n3
%     handles.Pnormed(:,:,i)=handles.P(:,:,i)/max(max(handles.P(:,:,i)));
% end
colormap(gray);
imagesc(handles.Pnormed(:,:,1));
axis off;


% --- Executes on slider movement.
function brightning_slider_Callback(hObject, eventdata, handles)
% hObject    handle to brightning_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject,'Value');
set(handles.brightness_slider_value,'String',num2str(val));

% axes(handles.ms_img_axes);
% 
% imagesc(handles.Mnormed(:,:,1:3));
disp(val);
handles.P=rgb2gray(brightning_pan(handles.M,val));
axes(handles.pan_img_axes);
plot_pan_image(handles);
axis off;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function brightning_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightning_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function darkening_slider_Callback(hObject, eventdata, handles)
% hObject    handle to darkening_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject,'Value');
set(handles.darkness_slider_value,'String',num2str(val));
% axes(handles.ms_img_axes);
% 
% imagesc(handles.Mnormed(:,:,1:3));
disp(val);
handles.M=darkening_ms(handles.M,val);
axes(handles.ms_img_axes);
plot_ms_image(handles);
axis off;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.

function darkening_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to darkening_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function ms_text_Callback(hObject, eventdata, handles)
% hObject    handle to ms_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ms_text as text
%        str2double(get(hObject,'String')) returns contents of ms_text as a double


% --- Executes during object creation, after setting all properties.
function ms_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ms_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pan_text_Callback(hObject, eventdata, handles)
% hObject    handle to pan_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pan_text as text
%        str2double(get(hObject,'String')) returns contents of pan_text as a double


% --- Executes during object creation, after setting all properties.
function pan_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pan_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in select_fusion_method.
function select_fusion_method_Callback(hObject, eventdata, handles)
% hObject    handle to select_fusion_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns select_fusion_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_fusion_method
method_index=get(hObject,'Value');
handles.fusion_method=method_index;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function select_fusion_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_fusion_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fuse_images_but.
function fuse_images_but_Callback(hObject, eventdata, handles)
% hObject    handle to fuse_images_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.M=double(handle.M);

% imagesc(handles.Mnormed(:,:,1:3));
% % handles.M=uint8(handles.M);

% C=Improved_Img_Fuse_8_09_14(handles.M(:,:,1:3),handles.P);
% % axes(handles.pan_img_axes);
% handles.F=C;
% guidata(hObject,handles);

disp(handles.fusion_transformation);
disp(handles.fusion_method);
% handles.F=handles.M;
switch handles.fusion_transformation
   
    case 2
             switch handles.fusion_method
                    case 2
                    disp('Intensity Substitution(IHS Transformation)');
                    cd('IHS');
                    C=fusion_intensity_substitution(handles.M,handles.P);
                    handles.F=C;
        %             figure(3),imshow(C);
                    cd ..;
                    case 3
                    disp('Wavelet Substitution(IHS Transformation)');
                    cd('IHS');
                    C=fusion_ihs_wavelet_substitution(handles.M,handles.P);
                    handles.F=C;
        %             figure(3),imshow(C);
                    cd ..;
                    case 4
                    disp('Wavelet Substitution(IHS Transformation)');
                    cd('IHS');
                    C=fusion_ihs_wavelet_additive(handles.M,handles.P);
                    handles.F=C;
        %             figure(3),imshow(C);
                    cd ..;
             end 
    case 3    
         switch handles.fusion_method
                    case 2
                    disp('Intensity Substitution(iNIHS transformation)');
                    cd('iNIHS');
                    C=fusion_intensity_substitution(handles.M,handles.P);
                    handles.F=C;
        %             figure(3),imshow(C);
                    cd ..;
                    case 3
                    disp('Wavelet Substitution (iNIHS transformation)');
                    cd('IHS');
                    C=fusion_ihs_wavelet_substitution(handles.M,handles.P);
                    handles.F=C;
        %             figure(3),imshow(C);
                    cd ..;
                    case 4
                    disp('Wavelet Addition (iNIHS transformation)');
                    cd('IHS');
                    C=fusion_ihs_wavelet_additive(handles.M,handles.P);
                    handles.F=C;
        %             figure(3),imshow(C);
                    cd ..;
        end 
end
 
guidata(hObject,handles);

% imagesc(handles.F);
% handles.F=double(C);
% handles.Fnormed=handles.F;
% [n1,n2,n3]=size(handles.F);
% for i=1:n3
%     handles.Fnormed(:,:,i)=handles.F(:,:,i)/max(max(handles.F(:,:,i)));
% end
% imagesc(handles.Fnormed(:,:,1:3));
% axis off;
fusion_result_gui;


% --- Executes on selection change in select_transformation.
function select_transformation_Callback(hObject, eventdata, handles)
% hObject    handle to select_transformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns select_transformation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_transformation
contents=get(hObject,'Value');
handles.fusion_transformation=contents;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function select_transformation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_transformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
