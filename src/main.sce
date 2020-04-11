// This GUI file is generated by guibuilder version 4.2.1
//////////

//Figures
/*
menuFigure = figure('figure_position',[500,163],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Intescio - Home','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
hideFigure = figure('figure_position',[500,163],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Intescio - Hide','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
findFigure = figure('figure_position',[500,163],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Intescio - Find','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
*/
mainFigure = figure('figure_position',[500,163],'figure_size',[988,649],'auto_resize','on','background',[33],'figure_name','Intescio','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');

//////////

////////// handles.title handles.goToHideImage handles.goToFindImage
// menuFigure == Home #################################################
//////////

handles.title=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[50],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.2083333,0.6669231,0.5909615,0.300905],'Relief','default','SliderStep',[0.01,0.1],'String','Intescio','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','title','Callback','');
handles.goToHideImage=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[20],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.3026922,0.3959276,0.4022436,0.2058824],'Relief','default','SliderStep',[0.01,0.1],'String','Hide Image','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','goToHideImage','Callback','goToHideImage_callback(handles)');
handles.goToFindImage=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[20],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.3026922,0.0949321,0.4022436,0.2058824],'Relief','default','SliderStep',[0.01,0.1],'String','Find Image','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','goToFindImage','Callback','goToFindImage_callback(handles)');

////////// handles.image1 handles.image2 handles.resultImage handles.loadImage1Button handles.loadImage2Button handles.loadImage2Button handles.h_imageRedundancyText handles.h_imageRedundancySpin handles.h_leastSignificantBitsText handles.h_leastSignificantBitsText handles.h_LSBUsedSpin handles.hideDataButton handles.saveResultButton handles.h_goHome
// hideFigure ###############################################
//////////

//Images
handles.image1= newaxes(mainFigure);handles.image1.margins = [ 0 0 0 0];handles.image1.axes_bounds = [0.0195473,0.0218978,0.4526749,0.4361314];handles.image1.auto_clear = 'on';handles.image1.visible = 'off';
handles.image2= newaxes(mainFigure);handles.image2.margins = [ 0 0 0 0];handles.image2.axes_bounds = [0.5295473,0.020073,0.4526749,0.4361314];handles.image2.auto_clear = 'on';handles.image2.visible = 'off';
handles.resultImage= newaxes(mainFigure);handles.resultImage.margins = [ 0 0 0 0];handles.resultImage.axes_bounds = [0.2785185,0.530073,0.4526749,0.4361314];handles.resultImage.auto_clear = 'on';handles.resultImage.visible = 'off';
handles.hasImage1 = %F;
handles.hasImage2 = %F;

// Load Image Buttons
handles.loadImage1Button=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.022982,0.4623144,0.1760925,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image ','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','loadImage1Button','Callback','loadImage1Button_callback(handles)');
handles.loadImage2Button=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.8012082,0.4623144,0.1760925,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image to Hide','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','loadImage2Button','Callback','loadImage2Button_callback(handles)');

// Spins & Text
handles.h_imageRedundancyText=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0359897,0.3549782,0.1456555,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','Image Redundancy','Style','text','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','imageRedundancyText','Callback','');
handles.h_imageRedundancyRecommendedText=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[10],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0359897,0.3000000,0.1456555,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'Style','text','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','imageRedundancyRecommendedText','Callback','');
handles.h_imageRedundancySpin=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1000000],'Min',[1],'Position',[0.1983805,0.3069432,0.0705604,0.0873362],'Relief','default','SliderStep',[1,1],'String','imageRedundancySpin','Style','spinner','Value',[1],'VerticalAlignment','middle','Visible','off','Tag','imageRedundancySpin','Callback','');
handles.h_leastSignificantBitsText=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0367095,0.1979913,0.1456555,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','LSB Used','Style','text','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','leastSignificantBitsText','Callback','');
handles.h_LSBUsedSpin=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[8],'Min',[2],'Position',[0.1958098,0.179607,0.0347044,0.0764192],'Relief','default','SliderStep',[1,1],'String','LSBUsedSpin','Style','spinner','Value',[4],'VerticalAlignment','middle','Visible','off','Tag','LSBUsedSpin','Callback','LSBUsedSpin_callback(handles)');

// Action Buttons
handles.hideDataButton=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0444216,0.0511354,0.1863753,0.069869],'Relief','default','SliderStep',[0.01,0.1],'String','Hide It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','hideDataButton','Callback','hideDataButton_callback(handles)');
handles.saveResultButton=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7860668,0.209607,0.1773779,0.0742358],'Relief','default','SliderStep',[0.01,0.1],'String','Save It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','saveResultButton','Callback','saveResultButton_callback(handles)');
handles.h_goHome=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7821811,0.0182482,0.186214,0.1423358],'Relief','default','SliderStep',[0.01,0.1],'String','*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','goHome','Callback','h_goHome_callback(handles)');


//////////handles.prevHostImagehandles.prevHideImagehandles.loadHostImageButtonhandles.saveHideImageButtonhandles.findDataButtonhandles.f_goHomehandles.f_imageRedundancyTexthandles.f_imageRedundancySpinhandles.f_leastSignificantBitsTexthandles.f_LSBUsedSpin
// findFigure ###############################################
//////////

//Images
handles.prevHostImage= newaxes(mainFigure);handles.prevHostImage.margins = [ 0 0 0 0];handles.prevHostImage.axes_bounds = [0.2785185,0.020073,0.4526749,0.4361314];handles.prevHostImage.auto_clear = 'on';handles.prevHostImage.auto_scale = 'on';handles.prevHostImage.visible = 'off';
handles.prevHideImage= newaxes(mainFigure);handles.prevHideImage.margins = [ 0 0 0 0];handles.prevHideImage.axes_bounds = [0.2795473,0.5118978,0.4526749,0.4361314];handles.prevHideImage.auto_clear = 'on';handles.prevHideImage.visible = 'off';

//Buttons
handles.loadHostImageButton=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.9123144,0.1863753,0.0676856],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image ','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','loadImageButton','Callback','loadHostImageButton_callback(handles)');
handles.saveHideImageButton=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7860668,0.209607,0.1773779,0.0742358],'Relief','default','SliderStep',[0.01,0.1],'String','Save It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','saveResultButton','Callback','saveHideImageButton_callback(handles)');
handles.findDataButton=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.5411354,0.1863753,0.069869],'Relief','default','SliderStep',[0.01,0.1],'String','Find It!','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','findDataButton','Callback','findDataButton_callback(handles)');
handles.f_goHome=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7821811,0.8382482,0.186214,0.1423358],'Relief','default','SliderStep',[0.01,0.1],'String','*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','goHome','Callback','f_goHome_callback(handles)');


// Texts & Spinners
handles.f_imageRedundancyText=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.7965939,0.1363753,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','Image Redundancy','Style','text','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','imageRedundancyText','Callback','');
handles.f_imageRedundancySpin=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1000000],'Min',[1],'Position',[0.1983805,0.7769432,0.0385604,0.0873362],'Relief','default','SliderStep',[1,1],'String','imageRedundancySpin','Style','spinner','Value',[1],'VerticalAlignment','middle','Visible','off','Tag','imageRedundancySpin','Callback','');
handles.f_leastSignificantBitsText=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0503856,0.6808734,0.1363753,0.0458515],'Relief','default','SliderStep',[0.01,0.1],'String','LSB Used','Style','text','Value',[0],'VerticalAlignment','middle','Visible','off','Tag','leastSignificantBitsText','Callback','');
handles.f_LSBUsedSpin=uicontrol(mainFigure,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','off','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[8],'Min',[2],'Position',[0.1958098,0.669607,0.0347044,0.0764192],'Relief','default','SliderStep',[1,1],'String','LSBUsedSpin','Style','spinner','Value',[4],'VerticalAlignment','middle','Visible','off','Tag','LSBUsedSpin','Callback','');

//////////
// MAIN ELEMENTS ###############################################
//////////
// Waitbar
//handles.waitbar = waitbar(0.5, "Waitbar Test");
// Activate Window
mainFigure.visible = 'on';

//////////
// Callbacks are defined as below. Please do not delete the comments as it will be used in coming version
//////////

//////////
// menuFigure == Home ###############################################
//////////

function goToHideImage_callback(handles)
//Write your callback for  goToHideImage  here
//mainFigure.visible = 'off';
//mainFigure = hideFigure;
handles.title.visible = 'off';
handles.goToHideImage.visible = 'off';
handles.goToFindImage.visible = 'off';
handles.image1.visible = 'on';
handles.image2.visible = 'on';
handles.resultImage.visible = 'on';
handles.loadImage1Button.visible = 'on';
handles.loadImage2Button.visible = 'on';
handles.loadImage2Button.visible = 'on';
handles.h_imageRedundancyText.visible = 'on';
handles.h_imageRedundancyRecommendedText.visible = 'on';
handles.h_imageRedundancySpin.visible = 'on';
handles.h_leastSignificantBitsText.visible = 'on';
handles.h_leastSignificantBitsText.visible = 'on';
handles.h_LSBUsedSpin.visible = 'on';
handles.hideDataButton.visible = 'on';
handles.saveResultButton.visible = 'on';
handles.h_goHome.visible = 'on';
endfunction


function goToFindImage_callback(handles)
//Write your callback for  goToFindImage  here
//mainFigure = findFigure;
handles.title.visible = 'off';
handles.goToHideImage.visible = 'off';
handles.goToFindImage.visible = 'off';
handles.prevHostImage.visible = 'on';
handles.prevHideImage.visible = 'on';
handles.loadHostImageButton.visible = 'on';
handles.saveHideImageButton.visible = 'on';
handles.findDataButton.visible = 'on';
handles.f_goHome.visible = 'on';
handles.f_imageRedundancyText.visible = 'on';
handles.f_imageRedundancySpin.visible = 'on';
handles.f_leastSignificantBitsText.visible = 'on';
handles.f_LSBUsedSpin.visible = 'on';
endfunction


//////////
// hideFigure ###############################################
//////////

function loadImage1Button_callback(handles)
//Write your callback for  loadImage1Button  here
//fn = uigetfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";], 'C:\Users\Thomas\Documents\Scilab\img', "Choose a file");
fn = uigetfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";], 'C:\Users\bobbywan\Images', "Choose a file");
hostImage = imread(fn);
sca(handles.image1);
imshow(hostImage);

handles.hostImage = hostImage;

handles.hasImage1 = %T;
if handles.hasImage2 then
    redun_opti = floor((size(handles.hostImage,1)*size(handles.hostImage,2))/(size(handles.hideImage,1)*size(handles.hideImage,2)+ceil(32/(handles.h_LSBUsedSpin.value-1))));
    if redun_opti == 0 then
        redun_opti = 1
    end
    handles.h_imageRedundancyRecommendedText.String = "Optitmum : " + string(redun_opti);
    handles.h_imageRedundancySpin.Value = [redun_opti];
    handles.hideDataButton.Enable = 'on';
    handles.h_imageRedundancySpin.Enable = 'on';
    handles.h_LSBUsedSpin.Enable = 'on';
end

handles = resume(handles);
endfunction


function loadImage2Button_callback(handles)
//Write your callback for  loadImage2Button  here
//fn = uigetfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";], 'C:\Users\Thomas\Documents\Scilab\img', "Choose a file");
fn = uigetfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";], 'C:\Users\bobbywan\Images', "Choose a file");
hideImage = imread(fn);
sca(handles.image2);
imshow(hideImage);

handles.hideImage = hideImage;

handles.hasImage2 = %T;
if handles.hasImage1 then
    redun_opti = floor((size(handles.hostImage,1)*size(handles.hostImage,2))/(size(handles.hideImage,1)*size(handles.hideImage,2)+ceil(32/(handles.h_LSBUsedSpin.value-1))));
    if redun_opti == 0 then
        redun_opti = 1
    end
    handles.h_imageRedundancyRecommendedText.String = "Optimum : " + string(redun_opti);
    handles.h_imageRedundancySpin.Value = [redun_opti];
    handles.hideDataButton.Enable = 'on';
    handles.h_imageRedundancySpin.Enable = 'on';
    handles.h_LSBUsedSpin.Enable = 'on';
end

handles = resume(handles);
endfunction

/*breakpoint*/
function LSBUsedSpin_callback(handles)
    heightHost = size(handles.hostImage,1);
    widthHost = size(handles.hostImage,2);

    heightHide = size(handles.hideImage,1);
    widthHide = size(handles.hideImage,2);

    nbLSB = handles.h_LSBUsedSpin.value;

    //handles.h_imageRedundancyRecommendedText.String = "Optitmum : ";

    opti = floor((size(handles.hostImage,1)*size(handles.hostImage,2))/(size(handles.hideImage,1)*size(handles.hideImage,2)+ceil(32/(handles.h_LSBUsedSpin.value-1))));
    if opti == 0 then
        opti = 1
    end

    handles.h_imageRedundancyRecommendedText.String = "Optimum : " + string(opti);

endfunction

function hideDataButton_callback(handles)
//Write your callback for  hideDataButton  here

//printf("host image = %d %d",size(handles.hostImage,1),size(handles.hostImage,2));

//exec('C:\Users\Thomas\Documents\Scilab\intescio\src\hide_v2.sci', -1)
exec('C:\Users\bobbywan\dev\scilab\intescio\src\hide_v2.sci', -1)
handles.resultHideImage = hideImage(handles.hostImage, handles.hideImage, handles.h_LSBUsedSpin.value, handles.h_imageRedundancySpin.value);
sca(handles.resultImage);

//printf("result image = %d %d",size(handles.resultImage,1),size(handles.resultImage,2));

imshow(handles.resultHideImage);
handles.saveResultButton.Enable = 'on';
handles = resume(handles);
endfunction


function saveResultButton_callback(handles)
//Write your callback for  saveResultButton  here
//fn = uiputfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";],'C:\Users\Thomas\Documents\Scilab\img\results', "Choose a file name");
fn = uiputfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";],'C:\Users\bobbywan\Images', "Choose a file name");
ext = list(".bmp", ".dib", ".jpeg", ".jpg", ".jpe", ".png", ".pbm", ".pgm", ".ppm", ".sr", ".ras", ".tiff", ".tif")
for x=1 : size(ext)
    if strstr(fn, ext(x)) == ext(x) then
        disp(fn)
        imwrite(handles.resultHideImage, fn);
        return;
    end
end

fn = fn + ".png";
disp(fn)
imwrite(handles.resultHideImage, fn);
endfunction


function h_goHome_callback(handles)
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
//mainFigure = menuFigure;
//mainFigure.visible = 'on';
handles.image1.visible = 'off';
handles.image2.visible = 'off';
handles.resultImage.visible = 'off';
handles.loadImage1Button.visible = 'off';
handles.loadImage2Button.visible = 'off';
handles.loadImage2Button.visible = 'off';
handles.h_imageRedundancyText.visible = 'off';
handles.h_imageRedundancyRecommendedText.visible = 'off';
handles.h_imageRedundancySpin.visible = 'off';
handles.h_leastSignificantBitsText.visible = 'off';
handles.h_leastSignificantBitsText.visible = 'off';
handles.h_LSBUsedSpin.visible = 'off';
handles.hideDataButton.visible = 'off';
handles.saveResultButton.visible = 'off';
handles.h_goHome.visible = 'off';
handles.title.visible = 'on';
handles.goToHideImage.visible = 'on';
handles.goToFindImage.visible = 'on';
endfunction


//////////
// findFigure ###############################################
//////////

function loadHostImageButton_callback(handles)
//Write your callback for  loadImageButton  here

//fn = uigetfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";], 'C:\Users\Thomas\Documents\Scilab\img\results', "Choose a file");
fn = uigetfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";], 'C:\Users\bobbywan\Images', "Choose a file");
hostImage2Find = imread(fn);
sca(handles.prevHostImage);
imshow(hostImage2Find);

handles.hostImage2Find = hostImage2Find;

handles.findDataButton.Enable = 'on';
handles.f_imageRedundancySpin.Enable = 'on';
handles.f_LSBUsedSpin.Enable = 'on';

handles = resume(handles);
endfunction

function findDataButton_callback(handles)
//Write your callback for  findDataButton  here
//exec('C:\Users\Thomas\Documents\Scilab\intescio\src\find_v2.sci', -1)
exec('C:\Users\bobbywan\dev\scilab\intescio\src\find_v2.sci', -1)
handles.resultFindImage = findImage(handles.hostImage2Find, handles.f_LSBUsedSpin.value, handles.f_imageRedundancySpin.value);
sca(handles.prevHideImage);
imshow(handles.resultFindImage);
handles.saveHideImageButton.Enable = 'on';
handles = resume(handles);
endfunction

function saveHideImageButton_callback(handles)
//Write your callback for  saveResultButton  here
//fn = uiputfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";],'C:\Users\Thomas\Documents\Scilab\img\results', "Choose a file name");
fn = uiputfile(["*.bmp|*.dib|*.jpeg|*.jpg|*.jpe|*.png|*.pbm|*.pgm|*.ppm|*.sr|*.ras|*.tiff|*.tif", "Image Files";],'C:\Users\bobbywan\Images', "Choose a file name");
ext = list(".bmp", ".dib", ".jpeg", ".jpg", ".jpe", ".png", ".pbm", ".pgm", ".ppm", ".sr", ".ras", ".tiff", ".tif")
for x=1 : size(ext)
    if strstr(fn, ext(x)) == ext(x) then
        disp(fn)
        imwrite(handles.resultFindImage, fn);
        return;
    end
end

fn = fn + ".png";
disp(fn)
imwrite(handles.resultFindImage, fn);
endfunction

function f_goHome_callback(handles)
//Write your callback for  goHome  here

//Reset Variables
handles.findDataButton.Enable = 'off';
handles.f_imageRedundancySpin.Enable = 'off';
handles.f_imageRedundancySpin.Value = [1];
handles.f_LSBUsedSpin.Enable = 'off';
handles.f_LSBUsedSpin.Value = [4];

//changing to home GUI
handles.prevHostImage.visible = 'off';
handles.prevHideImage.visible = 'off';
handles.loadHostImageButton.visible = 'off';
handles.saveHideImageButton.visible = 'off';
handles.findDataButton.visible = 'off';
handles.f_goHome.visible = 'off';
handles.f_imageRedundancyText.visible = 'off';
handles.f_imageRedundancySpin.visible = 'off';
handles.f_leastSignificantBitsText.visible = 'off';
handles.f_LSBUsedSpin.visible = 'off';
handles.title.visible = 'on';
handles.goToHideImage.visible = 'on';
handles.goToFindImage.visible = 'on';
endfunction
