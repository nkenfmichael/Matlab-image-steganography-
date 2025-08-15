function varargout = Select(varargin)
%==========================================================================
%           NECESSARY HELP OF THE STEGO SOFTWARE
%==========================================================================
%
% SELECT MATLAB code for Select.fig
%      SELECT, by itself, creates a new SELECT or raises the existing
%      singleton*.
%
%      H = SELECT returns the handle to a new SELECT or the handle to
%      the existing singleton*.
%
%      SELECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECT.M with the given input arguments.
%
%      SELECT('Property','Value',...) creates a new SELECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Select_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Select_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Edit the above text to modify the response to help Select
%
% Last Modified by GUIDE v2.5 21-Jul-2018 11:09:26

%==========================================================================
%           THIS IS THE INITIALISATION OF THE GUI
%==========================================================================
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Select_OpeningFcn, ...
                   'gui_OutputFcn',  @Select_OutputFcn, ...
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
%==========================================================================


% Executes just before Select is made visible.
function Select_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Select (see VARARGIN)

% Choose default command line output for Select
            handles.output = hObject;

% Update handles structure
            guidata(hObject, handles);

% UIWAIT makes Select wait for user response (see UIRESUME)
% uiwait(handles.figure1);



%==========================================================================
%                   DESIGN OF THE MAIN WINDOW
%==========================================================================

X = imread('Homescreen.png' , 'png' );
ax = axes('Units' , 'Normalized' , 'Position' , [0 0 1 1]);
imagesc(X, 'Parent' , ax)
uistack(ax, 'bottom');
set(ax, 'visible', 'off');
%==========================================================================


% Outputs from this function are returned to the command line.
function varargout = Select_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
            varargout{1} = handles.output;



% Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname]=uigetfile({'*.jpg';'*.png';'*.gif';'*.bmp';'*.tif'},'Cover Image Selector');
if isequal(filename,0)
    msgbox('You have canceled the selection of the cover image', 'Process canceled by user', 'error');
else
global cover;
cover =imread(strcat(pathname, filename));
axes(handles.axes1);
imshow(cover)
%set(handles.edit1,'string',filename);

end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text4 as text
%        str2double(get(hObject,'String')) returns contents of text4 as a double



% Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
coverTest = getimage(gca);
message=get(handles.edit1, 'string');

if isempty(coverTest)
    msgbox('No image selected, please select a cover image!','No image selected','error');

else



if isempty(message)
    msgbox('There is no message to hide, Please enter a valid message!','Error','error');
else


%==========================================================================
%                   THIS IS THE HIDING MODULE
%==========================================================================
global cover;


Hmessage=char(message);
bitToSet=1;
Hmessage=sprintf('%4.4d%s', length(Hmessage),Hmessage);

asciiValues=uint8(Hmessage);
stringLength=length(asciiValues);
bitsPerLetter=8;
%nPNFS = numPixelsNeededForString
nPNFS=stringLength*bitsPerLetter;
numPixelsInImage=numel(cover);


if (nPNFS>numPixelsInImage)
    warningMessage=sprintf('The selected image cannot contain your message, please select a bigger image.\n The image must have at least %d pixels to contain your message.',nPNFS);
    msgbox(warningMessage,'Error Message','error');
else

binaryAsciiString=dec2bin(asciiValues,8)'; %Not'
binaryAsciiString=binaryAsciiString(:)';

stegoImage=cover;

stegoImage(1:nPNFS)=bitset(stegoImage(1:nPNFS),bitToSet,0);
oneIndexes=find(binaryAsciiString == '1');
stegoImage(oneIndexes) = bitset(stegoImage(oneIndexes), bitToSet, 1);
axes(handles.axes2);
imshow(stegoImage)
cla(handles.axes1);
axes(handles.axes1);
axis on
set(handles.edit1,'string','');
end
end
end
%==========================================================================
%==========================================================================


function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
stego1 = getimage(gca);


if isempty(stego1)
    msgbox('There is no stego-image to save!','No image to save','error');
else
imsave;
end


%[FileName, PathName]=uiputfile('*.bmp', 'Save As');
%Name=fullfile(PathName, FileName);
%imwrite(handles.axes2, Name, 'bmp');




% Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname]=uigetfile({'*.png';'*.tif';'*.gif';'*.ppm';'*.ras'},...
'Stego-Image Selector');
if isequal(filename,0)
    msgbox('You have canceled the selection of the stego-image',...
    'Process canceled by user', 'error');
else
global stego;
stego=imread(strcat(pathname, filename));
axes(handles.axes3);
imshow(stego)
end


% Executes on button press in pushbutton5.
function pushbutton5_Callback(~, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global stego;

%==========================================================================
%                   THIS IS THE UNHIDING MODULE
%==========================================================================

axes(handles.axes3);
stego2 = getimage(gca);

if isempty(stego2)

    msgbox('No image selected, please select a stego-image',...
    'No image selected', 'error');
        
else


global stego
stegoImage=stego;
bitsPerLetter=8;
bitToSet=1;
numPNFS=4*bitsPerLetter;

retrievedLength=bitget(stegoImage(1:numPNFS),bitToSet);
letterCount=1;

for k=1:bitsPerLetter:numPNFS
    thisString=retrievedLength(k:(k + bitsPerLetter - 1));
    thisChar=char(bin2dec(num2str(thisString)));
    recoveredLength(letterCount)=thisChar;
    letterCount=letterCount+1;
end
stringLength=str2double(recoveredLength)+4;
numPNFS=stringLength*bitsPerLetter; 

if isnan(stringLength)
    msgbox('No message detected in this stego-image!','Promt Message','error');
    set(handles.text3,'string','');
else
retrievedBits=bitget(stegoImage(1:numPNFS),bitToSet);
retrievedAscii=reshape(retrievedBits, [bitsPerLetter, numPNFS/bitsPerLetter]);

letterCount=1;
nextPixel=4*bitsPerLetter + 1;
for k = nextPixel:bitsPerLetter:numPNFS
    thisString=retrievedBits(k:(k+bitsPerLetter - 1));
    thisChar=char(bin2dec(num2str(thisString)));
    recoveredString(letterCount)=thisChar;
    letterCount=letterCount + 1;
end
set(handles.text3,'string',recoveredString);
end

        
end
%==========================================================================
%                          END
%==========================================================================




% --------------------------------------------------------------------
function Help_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function HowToUseThisApp_Callback(hObject, eventdata, handles)
% hObject    handle to HowToUseThisApp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=msgbox({
    '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';...
    '          PROVIDED HELP FOR NKENFACK STEGO-SOFTWARE:';...
    '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';...
    '';...
    'This app hides a given message inside a provided cover image.';...
    'The app can also be used to recover the message hidden by this app from its corresponding stego-image.';...
    'The cover image can be of any type.';...
    'The default message to be hidden is "Type message to hide here".';...
    'After you have repalced this default message with your message, and have selected a cover image, you can now clic on "Hide Text" to embed your message.';...
    'The "Save" button enables you to store the produced stego-image in a disired location.';...
    'When saving your stego image, make sure to use one of the following image types: ".png", ".tif", ".tiff", ".ras" or ".ppm".';...
    'To unhide a message from a given stego-image, you can use the Unhiding module:';...
    'When you select the stego-image, you just need to clic on "Recover Plaintext",';...
    'And your message will be displayed on the appropriate dispalying field.';...
    '';...
    '                                   ENJOY OUR APPLICATION';...
    '';...
    '';...
    '                          Contact of the author at: mikedika2013@gmail.com';...
    '';...
    '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';...    
    },'NKENFACK v18.7','help');


% --------------------------------------------------------------------
function Mike_Callback(hObject, eventdata, handles)
% hObject    handle to Mike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function chm_Callback(hObject, eventdata, handles)
% hObject    handle to chm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
cla(handles.axes1);
axes(handles.axes1);
axis on


% --------------------------------------------------------------------
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'string','');
set(handles.edit1,'string','');
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
axes(handles.axes1);
axis on
axes(handles.axes2);
axis on
axes(handles.axes3);
axis on


% --------------------------------------------------------------------
function csm_Callback(hObject, eventdata, handles)
% hObject    handle to csm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2);
axes(handles.axes2);
axis on

% --------------------------------------------------------------------
function cum_Callback(hObject, eventdata, handles)
% hObject    handle to cum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes3);
axes(handles.axes3);
axis on
set(handles.text3,'string','');



% --------------------------------------------------------------------
function version_Callback(hObject, eventdata, handles)
% hObject    handle to version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'NKENFACK"s STEGO SOFTWARE';...
    'Version v18.7';...
    'Released on July 2018';'';...
    '©Copyright by NKENFACK MICHAËL, 2018';...
    'All rigths reserved'},'About this software','help');

%==========================================================================
%                   END OF THE PROGRAM
%==========================================================================
