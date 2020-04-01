// This GUI file is generated by guibuilder version 4.2.1
//////////

//Figures
menuFigure = figure('figure_position',[500,163],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Intescio - Home','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
hideFigure = figure('figure_position',[500,163],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Intescio - Hide','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
findFigure = figure('figure_position',[500,163],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Intescio - Find','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
mainFigure = menuFigure;
mainFigure.visible = 'on';
//////////

//////////
// menuFigure == Home #################################################
//////////

handles.title=uicontrol(menuFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[50],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.2083333,0.6669231,0.5909615,0.300905],'Relief','default','SliderStep',[0.01,0.1],'String','Intescio','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','title','Callback','');
handles.goToHideImage=uicontrol(menuFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[20],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.3026922,0.3959276,0.4022436,0.2058824],'Relief','default','SliderStep',[0.01,0.1],'String','Hide Image','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','goToHideImage','Callback','goToHideImage_callback(handles)');
handles.goToFindImage=uicontrol(menuFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[20],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.3026922,0.0949321,0.4022436,0.2058824],'Relief','default','SliderStep',[0.01,0.1],'String','Find Image','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','goToFindImage','Callback','goToFindImage_callback(handles)');

//////////
// hideFigure ###############################################
//////////

//Images
handles.image1= newaxes(hideFigure);handles.image1.margins = [ 0 0 0 0];handles.image1.axes_bounds = [0.0195473,0.0218978,0.4526749,0.4361314];handles.image1.auto_clear = 'on';
handles.image2= newaxes(hideFigure);handles.image2.margins = [ 0 0 0 0];handles.image2.axes_bounds = [0.5295473,0.020073,0.4526749,0.4361314];handles.image2.auto_clear = 'on';
handles.resultImage= newaxes(hideFigure);handles.resultImage.margins = [ 0 0 0 0];handles.resultImage.axes_bounds = [0.2785185,0.530073,0.4526749,0.4361314];handles.resultImage.auto_clear = 'on';
handles.hasImage1 = %F;
handles.hasImage2 = %F;

// Load Image Buttons
handles.loadImage1Button=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.022982,0.4623144,0.1760925,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image ','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','loadImage1Button','Callback','loadImage1Button_callback(handles)');
handles.loadImage2Button=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.8012082,0.4623144,0.1760925,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image to Hide','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','loadImage2Button','Callback','loadImage2Button_callback(handles)');

// Spins & Text
handles.h_imageRedundancyText=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0359897,0.3349782,0.1456555,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','Image Redundancy','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','imageRedundancyText','Callback','');
handles.h_imageRedundancySpin=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[100],'Min',[1],'Position',[0.1983805,0.3169432,0.0385604,0.0873362],'Relief','default','SliderStep',[1,1],'String','imageRedundancySpin','Style','spinner','Value',[1],'VerticalAlignment','middle','Visible','on','Tag','imageRedundancySpin','Callback','imageRedundancySpin_callback(handles)');
handles.h_leastSignificantBitsText=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0367095,0.1979913,0.1456555,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','LSB Used','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','leastSignificantBitsText','Callback','');
handles.h_LSBUsedSpin=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[8],'Min',[0],'Position',[0.1958098,0.179607,0.0347044,0.0764192],'Relief','default','SliderStep',[1,1],'String','LSBUsedSpin','Style','spinner','Value',[4],'VerticalAlignment','middle','Visible','on','Tag','LSBUsedSpin','Callback','LSBUsedSpin_callback(handles)');

// Action Buttons
handles.hideDataButton=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0444216,0.0511354,0.1863753,0.069869],'Relief','default','SliderStep',[0.01,0.1],'String','Hide It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','hideDataButton','Callback','hideDataButton_callback(handles)');
handles.saveResultButton=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7860668,0.209607,0.1773779,0.0742358],'Relief','default','SliderStep',[0.01,0.1],'String','Save It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','saveResultButton','Callback','saveResultButton_callback(handles)');
handles.h_goHome=uicontrol(hideFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7821811,0.0182482,0.186214,0.1423358],'Relief','default','SliderStep',[0.01,0.1],'String','*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','goHome','Callback','goHome_callback(handles)');


//////////
// findFigure ###############################################
//////////

//Images
handles.prevHostImage= newaxes(findFigure);handles.prevHostImage.margins = [ 0 0 0 0];handles.prevHostImage.axes_bounds = [0.2785185,0.020073,0.4526749,0.4361314];handles.prevHostImage.auto_clear = 'on';handles.prevHostImage.auto_scale = 'on';
handles.prevHideImage= newaxes(findFigure);handles.prevHideImage.margins = [ 0 0 0 0];handles.prevHideImage.axes_bounds = [0.2795473,0.5118978,0.4526749,0.4361314];handles.prevHideImage.auto_clear = 'on';

//Buttons
handles.loadHostImageButton=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.9123144,0.1863753,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image ','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','loadImageButton','Callback','loadHostImageButton_callback(handles)');
handles.saveHideImageButton=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7860668,0.209607,0.1773779,0.0742358],'Relief','default','SliderStep',[0.01,0.1],'String','Save It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','saveResultButton','Callback','saveHideImageButton_callback(handles)');
handles.findDataButton=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.5411354,0.1863753,0.069869],'Relief','default','SliderStep',[0.01,0.1],'String','Find It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','findDataButton','Callback','findDataButton_callback(handles)');
handles.f_goHome=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7821811,0.8382482,0.186214,0.1423358],'Relief','default','SliderStep',[0.01,0.1],'String','*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','goHome','Callback','goHome_callback(handles)');


// Texts & Spinners
handles.f_imageRedundancyText=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.7965939,0.1363753,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','Image Redundancy','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','imageRedundancyText','Callback','');
handles.f_imageRedundancySpin=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[100],'Min',[1],'Position',[0.1983805,0.7769432,0.0385604,0.0873362],'Relief','default','SliderStep',[1,1],'String','imageRedundancySpin','Style','spinner','Value',[1],'VerticalAlignment','middle','Visible','on','Tag','imageRedundancySpin','Callback','imageRedundancySpin_callback(handles)');
handles.f_leastSignificantBitsText=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.6808734,0.1363753,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','LSB Used','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','leastSignificantBitsText','Callback','');
handles.f_LSBUsedSpin=uicontrol(findFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[8],'Min',[0],'Position',[0.1958098,0.669607,0.0347044,0.0764192],'Relief','default','SliderStep',[1,1],'String','LSBUsedSpin','Style','spinner','Value',[4],'VerticalAlignment','middle','Visible','on','Tag','LSBUsedSpin','Callback','LSBUsedSpin_callback(handles)');



//////////
// Callbacks are defined as below. Please do not delete the comments as it will be used in coming version
//////////

//////////
// menuFigure == Home ###############################################
//////////

function goToHideImage_callback(handles)
//Write your callback for  goToHideImage  here
mainFigure.visible = 'off';
mainFigure = hideFigure;
mainFigure.visible = 'on';
endfunction


function goToFindImage_callback(handles)
//Write your callback for  goToFindImage  here
mainFigure = findFigure;
mainFigure.visible = 'on';
endfunction


//////////
// hideFigure ###############################################
//////////

function loadImage1Button_callback(handles)
//Write your callback for  loadImage1Button  here
fn = uigetfile('*');
hostImage = imread(fn);
sca(handles.image1);
imshow(hostImage);

handles.hostImage = hostImage;

handles.hasImage1 = %T;
if handles.hasImage2 then
    handles.hideDataButton.Enable = 'on';
    handles.h_imageRedundancySpin.Enable = 'on';
    handles.h_LSBUsedSpin.Enable = 'on';
end

handles = resume(handles);
endfunction


function loadImage2Button_callback(handles)
//Write your callback for  loadImage2Button  here
fn = uigetfile('*');
hideImage = imread(fn);
sca(handles.image2);
imshow(hideImage);

handles.hostImage = hideImage;

handles.hasImage2 = %T;
if handles.hasImage1 then
    handles.hideDataButton.Enable = 'on';
    handles.h_imageRedundancySpin.Enable = 'on';
    handles.h_LSBUsedSpin.Enable = 'on';
end

handles = resume(handles);
endfunction

function hideDataButton_callback(handles)
//Write your callback for  hideDataButton  here

endfunction


function saveResultButton_callback(handles)
//Write your callback for  saveResultButton  here

endfunction


function goHome_callback(handles)
//Write your callback for  goHome  here

//Reset Variables
handles.hasImage1 = %F;
handles.hasImage2 = %F;
handles.hideDataButton.Enable = 'off';
handles.h_imageRedundancySpin.Enable = 'off';
handles.h_imageRedundancySpin.Value = [1];
handles.h_LSBUsedSpin.Enable = 'off';
handles.h_LSBUsedSpin.Value = [4];

//changing to home GUI
mainFigure = menuFigure;
mainFigure.visible = 'on';
endfunction

//////////
// findFigure ###############################################
//////////

function loadHostImageButton_callback(handles)
//Write your callback for  loadImageButton  here

fn = uigetfile('*');
hostImage = imread(fn);
sca(handles.prevHostImage);
imshow(hostImage);

handles.hostImage = hostImage;

handles.findDataButton.Enable = 'on';
handles.f_imageRedundancySpin.Enable = 'on';
handles.f_LSBUsedSpin.Enable = 'on';

handles = resume(handles);
endfunction

function findDataButton_callback(handles)
//Write your callback for  findDataButton  here

endfunction

function saveHideImageButton_callback(handles)
//Write your callback for  saveResultButton  here

endfunction

function goHome_callback(handles)
//Write your callback for  goHome  here

//Reset Variables
handles.findDataButton.Enable = 'off';
handles.f_imageRedundancySpin.Enable = 'off';
handles.f_imageRedundancySpin.Value = [1];
handles.f_LSBUsedSpin.Enable = 'off';
handles.f_LSBUsedSpin.Value = [4];

//changing to home GUI
mainFigure = menuFigure;
mainFigure.visible = 'on';
endfunction




