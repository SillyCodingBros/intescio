// This GUI file is generated by guibuilder version 4.2.1
//////////
f=figure('figure_position',[616,56],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Figure n°%d','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
//////////
handles.dummy = 0;

//Images
handles.image1= newaxes();handles.image1.margins = [ 0 0 0 0];handles.image1.axes_bounds = [0.0195473,0.0218978,0.4526749,0.4361314];handles.image1.auto_clear = 'on';
handles.image2= newaxes();handles.image2.margins = [ 0 0 0 0];handles.image2.axes_bounds = [0.5295473,0.020073,0.4526749,0.4361314];handles.image2.auto_clear = 'on';
handles.resultImage= newaxes();handles.resultImage.margins = [ 0 0 0 0];handles.resultImage.axes_bounds = [0.2785185,0.530073,0.4526749,0.4361314];handles.resultImage.auto_clear = 'on';
handles.hasImage1 = %F;
handles.hasImage2 = %F;

// Load Image Buttons
handles.loadImage1Button=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.022982,0.4623144,0.1760925,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image ','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','loadImage1Button','Callback','loadImage1Button_callback(handles)')
handles.loadImage2Button=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.8012082,0.4623144,0.1760925,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image to Hide','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','loadImage2Button','Callback','loadImage2Button_callback(handles)')

// Spins & Text
handles.imageRedundancyText=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0359897,0.3349782,0.1456555,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','Image Redundancy','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','imageRedundancyText','Callback','')
handles.imageRedundancySpin=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[100],'Min',[1],'Position',[0.1983805,0.3169432,0.0385604,0.0873362],'Relief','default','SliderStep',[1,1],'String','imageRedundancySpin','Style','spinner','Value',[1],'VerticalAlignment','middle','Visible','on','Tag','imageRedundancySpin','Callback','imageRedundancySpin_callback(handles)')
handles.leastSignificantBitsText=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0367095,0.1979913,0.1456555,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','LSB Used','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','leastSignificantBitsText','Callback','')
handles.LSBUsedSpin=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[8],'Min',[0],'Position',[0.1958098,0.179607,0.0347044,0.0764192],'Relief','default','SliderStep',[1,1],'String','LSBUsedSpin','Style','spinner','Value',[4],'VerticalAlignment','middle','Visible','on','Tag','LSBUsedSpin','Callback','LSBUsedSpin_callback(handles)')

// Action Buttons
handles.hideDataButton=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0444216,0.0511354,0.1863753,0.069869],'Relief','default','SliderStep',[0.01,0.1],'String','Hide It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','hideDataButton','Callback','hideDataButton_callback(handles)')
handles.saveResultButton=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7860668,0.209607,0.1773779,0.0742358],'Relief','default','SliderStep',[0.01,0.1],'String','Save It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','saveResultButton','Callback','saveResultButton_callback(handles)')
handles.goHome=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7821811,0.0182482,0.186214,0.1423358],'Relief','default','SliderStep',[0.01,0.1],'String','*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','goHome','Callback','goHome_callback(handles)')


f.visible = "on";


//////////
// Callbacks are defined as below. Please do not delete the comments as it will be used in coming version
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
    handles.imageRedundancySpin.Enable = 'on';
    handles.LSBUsedSpin.Enable = 'on';
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
    handles.imageRedundancySpin.Enable = 'on';
    handles.LSBUsedSpin.Enable = 'on';
end

handles = resume(handles);
endfunction


function imageRedundancySpin_callback(handles)
//Write your callback for  imageRedundancySpin  here

endfunction


function LSBUsedSpin_callback(handles)
//Write your callback for  LSBUsedSpin  here

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
handles.imageRedundancySpin.Enable = 'off';
handles.imageRedundancySpin.Value = [1];
handles.LSBUsedSpin.Enable = 'off';
handles.LSBUsedSpin.Value = [4];

//changing to home GUI

endfunction




