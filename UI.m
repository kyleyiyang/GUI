% This is the UI for Multi-mission EO Sensor project
function []=EO_sensor_UI_v8()
clc
clear
close all
warning('off', 'all');

screen_size=get(0,'Screensize');
w=screen_size(3);
h=screen_size(4);

display_w=700;
display_h=500;
start_x=(w-display_w)./2;
start_y=(h-display_h)./2;

csv_file_path=sprintf('C:\\Users\\Kent128\\Documents\\128FAT\\HS');
CSVNAME='OFX01096_spectrum_28Oct2019_hsSD1.csv';
%--------------------------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GUI Control Pannel %%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------%
f=figure('units','pixels',...
              'position',[start_x,start_y,display_w, display_h],...
              'resize','off',...
              'menubar','none',...
              'numbertitle','off',...
              'name',' Multi-Mission EO Sensor System');
mls=sprintf('KOI Sensor Control GUI');

bg=uibuttongroup(f,'units','pix',...
                     'fontsize',12,...
                     'fontweight','bold',...
                     'backgroundcolor','w',...
                     'position',[5 5 display_w-10 display_h-10]);

txm=uicontrol(f,'style','text',...
                 'units','pix',...
                 'position',[8 display_h-40 display_w-16 30],...
                 'fontweight','bold',...
                 'fontsize', 14,...
                 'string',mls);
[icon,~]=imread('icon.bmp');
I=imresize(icon,[30, 30]);
icon=uicontrol(f,'style','push',...
                  'position', [9 display_h-40 30 30],...
                  'cdata',I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Data Acquisition GUI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bg_DMD_Detector_control=uibuttongroup(f,'units','pix',...
                            'fontweight','bold',...
                            'fontsize', 12,...
                            'backgroundcolor','w',...
                            'title','Data Acquisition',...
                            'position', [8 display_h-125 display_w-16 90]);
    DMD_Frequency_txt=uicontrol(f,'style','text',...
                      'unit','pix',...
                      'position', [ display_w*0.3/10 display_h-85 display_w-625, 20],...
                      'fontsize', 12,...
                      'backgroundcolor','w',...
                      'horizontalalignment','left',...
                      'string','DMD (Hz)');
    
    DMD_Frequency_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[display_w*1.5/10 display_h-85 100 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',{'500','1000','1500','2000', '3000','5000', '7000'}); 
    Spacial_Resolution_txt=uicontrol(f,'style','text',...
                      'unit','pix',...
                      'position', [ display_w*4/10 display_h-85 display_w-565, 20],...
                      'fontsize', 12,...
                      'backgroundcolor','w',...
                      'horizontalalignment','left',...
                      'string','Spacial Resolution');
    Spacial_Resolution_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[display_w*6/10 display_h-85 100 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',{'1024x1024','512x512','256x256','128x128', '64x64','32x32'});
                       
    DMDPatternLoadingButton=uicontrol(f,'Style','pushbutton',...
                            'Position',[display_w*0.3/10 display_h-115 140 25],...
                            'fontsize', 10,...
                            'String', 'DMD Pattern Loading',...
                            'Callback',@DMD_Pattern_Loading);
    FXSpectrometerButton=uicontrol(f,'Style','pushbutton',...
                            'Position',[display_w*2.5/10 display_h-115 160 25],...
                            'fontsize', 10,...
                            'String', 'FX Spectrometer Setting',...
                            'Callback',@FX_Spectrometer_Setting);
    SinglePixelDetectorButton=uicontrol(f,'Style','pushbutton',...
                            'Position',[display_w*4.95/10 display_h-115 190 25],...
                            'fontsize', 10,...
                            'String', 'Single Pixel Detector Setting',...
                            'Callback',@Single_Pixel_Detector_Setting);
    TwoDCameraButton=uicontrol(f,'Style','pushbutton',...
                            'Position',[display_w*7.8/10 display_h-115 130 25],...
                            'fontsize', 10,...
                            'String', '2D Camera Setting',...
                            'Callback',@Two_D_Camera_Setting);
    align([DMDPatternLoadingButton FXSpectrometerButton SinglePixelDetectorButton TwoDCameraButton],'distribute','bottom');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Data Reconstruction GUI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    bg_ImageVideoReconstructon=uibuttongroup(f,'units','pix',...
                            'fontweight','bold',...
                            'fontsize',12,...
                            'backgroundcolor','w',...
                            'title','Image/Video Reconstruction',...
                            'position',[8 8 display_w-16 display_h-138]);
    CSV_File_Select=uicontrol(f,'style','text',...
                      'unit','pix',...
                      'position', [ 15 display_h-170 display_w-530, 20],...
                      'fontsize', 12,...
                      'backgroundcolor','w',...
                      'horizontalalignment','left',...
                      'string','CSV/Excel File Select:');
    CSVFileOpenButton = uicontrol(f,'Style','pushbutton',...
                            'Position',[200 display_h-170 60 20],...
                            'fontsize', 10,...
                            'String', 'Open',...
                            'Callback',@Data_File_Select);
    CSV_File_List=uicontrol(f,'style','list',...
                         'unit','pix',...
                         'position',[15 display_h-205 display_w-30 28 ],...
                         'backgroundcolor','w',...
                         'HorizontalAlignment','left',...
                         'fontsize',10,...
                         'string', CSVNAME);
    BrowserButton = uicontrol(f,'Style','pushbutton',...
                            'Position',[550 display_h-170 120 25],...
                            'fontsize', 10,...
                            'String', 'Browse Results',...
                            'Callback',@Browser_Buttoon_Callback);
     %%%%%%%%%%%%%%%%%%%%%%%%%% Hyperspec GUI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                
     bg_Multi_Hyperspectral=uibuttongroup(f,'units','pix',...
                                    'fontweight','bold',...
                                    'fontsize',12,...
                                    'backgroundcolor','w',...
                                    'title','Multi/Hyper-Spectral',...
                                    'position',[15 15 display_w-370 display_h-220]);
         Spectral_Bands=uicontrol(f,'style','text',...
                          'unit','pix',...
                          'position', [ 20 25 display_w-500, 230],...
                          'fontsize', 12,...
                          'horizontalalignment','left',...
                          'backgroundcolor','w',...
                          'string','Spectral Bands/Resolution');
          Spectral_Bands_Popup_Selects =  {'1 nm','10 nm','20 nm','50 nm', 'RGB','Gray','Enter a number'};
          Spectral_Bands_Popup=uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[220 25 display_w-590, 230],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',Spectral_Bands_Popup_Selects,...
                            'Callback',@Spectral_Bands_Select);
                        
          STOne_Reconstruction=uicontrol(f,'style','text',...
                          'unit','pix',...
                          'position', [ 20 25 display_w-500, 190],...
                          'fontsize', 12,...
                          'horizontalalignment','left',...
                          'backgroundcolor','w',...
                          'string','STOne Reconstruction');
          STOne_Reconstruction_Popup=uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[220 25 display_w-590, 190],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',{'Image', 'Video'},...
                            'Callback',@STOne_Reconstruction_Callback);
          Rotate_Angle=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 20 152 display_w-605, 25],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Rotate Angle');
          Rotate_Angle_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[120 152 70 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'Enable', 'on',...
                            'string',{'0','90','180','270'});
          Mu_TXT=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 210 152 25, 25],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Mu');
          Mu_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[240 152 90 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'Enable', 'on',...
                            'string',{'1','2','3','4','5','6','7','8','9'});
          Fovea_Recontruction=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 20 25 display_w-500, 110],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Fovea Reconstruction');
          Fovea_Recontruction_Checkbox=uicontrol(f,'style','checkbox',...
                            'unit','pix',...
                            'position',[220 115 display_w-682, 17],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'Callback',@Fovea_Recontruction_Check);
          Fovea_Recontruction_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[240 110 90 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'Enable', 'off',...
                            'string',{'1024x1024','512x512','256x256','128x128', '64x64','32x32'},...
                            'Callback',@Resolution_Callback);
          Compressive_Recontruction_Ratio=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 20 75 display_w-490, 20],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Compress. Recons. Ratio (%)');
          Compressive_Recontruction_Ratio_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[240 95 90 0],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',{'100','90','80','70', '60','50','40','30','20','10'});
                        
          HyperspecReconstructionButton=uicontrol(f,'Style','pushbutton',...
                            'Position',[70 30 200 25],...
                            'fontsize', 10,...
                            'String', 'Start Hyperspec Reconstruction',...
                            'Callback',@Hyperspec_Reconstruction);
      %%%%%%%%%%%%%%%%%%%%%%%%%% Gray Scale GUI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                
      bg_Greyscale=uibuttongroup(f,'units','pix',...
                                    'fontweight','bold',...
                                    'fontsize',12,...
                                    'backgroundcolor','w',...
                                    'title','Gray Scale',...
                                    'position',[355 15 display_w-370 display_h-220]);
         Image_Resolution=uicontrol(f,'style','text',...
                          'unit','pix',...
                          'position', [ 360 25 display_w-500, 230],...
                          'fontsize', 12,...
                          'horizontalalignment','left',...
                          'backgroundcolor','w',...
                          'string','Image Resolution');
          Image_Resolution_Popup=uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[560 25 display_w-590, 230],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',{'1024x1024','512x512','256x256','128x128', '64x64','32x32'},...
                            'Callback',@Resolution_Callback);
          Gray_Scale_STOne_Reconstruction=uicontrol(f,'style','text',...
                          'unit','pix',...
                          'position', [ 360 25 display_w-500, 190],...
                          'fontsize', 12,...
                          'horizontalalignment','left',...
                          'backgroundcolor','w',...
                          'string','STOne Reconstruction');
          Gray_Scale_STOne_Reconstruction_Popup=uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[560 25 display_w-590, 190],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',{'Image', 'Video'},...
                            'Callback',@Gray_Scale_STOne_Reconstruction_Callback);
          Gray_Scale_Rotate_Angle=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 360 152 display_w-605, 25],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Rotate Angle');
          Gray_Scale_Rotate_Angle_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[460 152 70 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'Enable', 'on',...
                            'string',{'0','90','180','270'});
          Gray_Scale_Mu_TXT=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 550 152 25, 25],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Mu');
          Gray_Scale_Mu_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[580 152 90 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'Enable', 'on',...
                            'string',{'1','2','3','4','5','6','7','8','9'});
          Gray_Scale_Fovea_Recontruction=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 360 25 display_w-500, 110],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Fovea Reconstruction');
          Gray_Scale_Fovea_Recontruction_Checkbox=uicontrol(f,'style','checkbox',...
                            'unit','pix',...
                            'position',[560 115 display_w-682, 17],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'Callback',@Gray_Scale_Fovea_Recontruction_Check);
          Gray_Scale_Fovea_Recontruction_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[580 110 90 25],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'Enable', 'off',...
                            'string',{'1024x1024','512x512','256x256','128x128', '64x64','32x32'},...
                            'Callback',@Resolution_Callback);
          Gray_Scale_Compressive_Recontruction_Ratio=uicontrol(f,'style','text',...
                              'unit','pix',...
                              'position', [ 360 75 display_w-490, 20],...
                              'fontsize', 12,...
                              'horizontalalignment','left',...
                              'backgroundcolor','w',...
                              'string','Compress. Recons. Ratio (%)');
          Gray_Scale_Compressive_Recontruction_Ratio_Popup = uicontrol(f,'style','popup',...
                            'unit','pix',...
                            'position',[580 95 90 0],...
                            'fontsize', 10,...
                            'backgroundcolor','w',...
                            'horizontalalignment','left',...
                            'string',{'100','90','80','70', '60','50','40','30','20','10'});
          GrayScaleReconstructionButton=uicontrol(f,'Style','pushbutton',...
                            'Position',[410 30 200 25],...
                            'fontsize', 10,...
                            'String', 'Start Gray Scale Reconstruction',...
                            'Callback',@Gray_Scale_Reconstruction);
%     default values
        set(Spacial_Resolution_Popup, 'value', 4);
        set(Mu_Popup, 'value',3);
        set(Spectral_Bands_Popup, 'value', 2);
        set(Rotate_Angle_Popup, 'value',2);
        set(Fovea_Recontruction_Popup, 'value', 5);
        set(Compressive_Recontruction_Ratio_Popup, 'value',10);
        
        set(Image_Resolution_Popup, 'value', 4);
        set(Gray_Scale_Rotate_Angle_Popup, 'value',2);
        set(Gray_Scale_Fovea_Recontruction_Popup, 'value', 5);
        set(Gray_Scale_Mu_Popup, 'value',3);
        
        Browser_folder = csv_file_path;
        topLeftCorner = [41,37];
        botRightCorner = [88,80];
        user_input_video_type = 'l2';
%-------------------------------------------------------%      
%%%%%%%%%%%%%%%%%% Data Acquisition %%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------%
    function DMD_Pattern_Loading(~,~)
        DMD_freq = DMD_Frequency_Popup.String{DMD_Frequency_Popup.Value};
        spacialResolution = Spacial_Resolution_Popup.String{Spacial_Resolution_Popup.Value};
        [n]=Spatial_resolution(spacialResolution);   
        if n>=128
            numberPatterns = '16384';
        else
            numberPatterns = num2str(n^2);
        end
        dmd_pattern_loading_exe = 'C:\Users\Kent128\Documents\Debug\Sample_GUI_test.exe';
        system(['start ' dmd_pattern_loading_exe ' ' DMD_freq ' ' numberPatterns]);
    end
    function Single_Pixel_Detector_Setting(~,~)
        single_pixel_detector_exe = "C:\Program Files (x86)\DATAQ Instruments\common\WinDaq Dashboard.exe";
        system(single_pixel_detector_exe);
    end
    function Two_D_Camera_Setting(~,~)
        two_d_camera_exe = "C:\Program Files\Point Grey Research\FlyCapture2\bin64\Point Grey FlyCap2.exe";
        system(two_d_camera_exe);
    end
    function FX_Spectrometer_Setting(~,~)
        DMD_freq = DMD_Frequency_Popup.String{DMD_Frequency_Popup.Value};
        if (isequal(DMD_freq,'500'))
            integrationTime = '1300';
        elseif (isequal(DMD_freq,'1000'))
            integrationTime = '700';
        elseif (isequal(DMD_freq,'1500'))
            integrationTime = '400';
        else
            uiwait(msgbox('DMD Frequency > 1500 Hz. Use Single Pixel Detector Only!','Warning','custom',I));
            return
        end
        spacialResolution = Spacial_Resolution_Popup.String{Spacial_Resolution_Popup.Value};
        [n]=Spatial_resolution(spacialResolution);   
        if n>=128
            numberSpectra = '16385';
        else
            numberSpectra = num2str(n^2+1);
        end
        spectometer_exe = 'C:\Users\Kent128\software\FXStreamer\FXStreamer.exe';
        system([spectometer_exe ' ' integrationTime ' ' numberSpectra]);
        return
    end
%-------------------------------------------------------%    
%%%%%%%%%%%%%%%%% Data Reconstruction %%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------%
    function Browser_Buttoon_Callback(~,~)
        winopen(Browser_folder);
    end
    function Spectral_Bands_Select(~,~)
        set(Spectral_Bands_Popup,'backgroundcolor','w');
        if (isequal(Spectral_Bands_Popup.Value,5))
            set(Compressive_Recontruction_Ratio_Popup, 'value', 1, 'Enable','off');
        else
            set(Compressive_Recontruction_Ratio_Popup, 'value', 10, 'Enable','on');
        end
        if (isequal(Spectral_Bands_Popup.Value,7))
            prompt = {'Please Enter Spectral Resolution (nm)'};
            dlgtitle = 'Spectral Resolution';
            dims = [1 40];
            definput = {'5'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            [~,start_wavelength,end_wavelength]=get_wavelength_range();
            if (isempty(answer))
                return
            elseif (isnan(str2double(answer{1,1})))
                msg = ['Your Input ',answer{1,1}, ' Is Not Good! Please Enter Again!'];
                uiwait(msgbox(msg,'Warning','custom',I));
                Spectral_Bands_Select();
            elseif (str2double(answer{1,1}) > end_wavelength-start_wavelength)
                msg = ['Your Input ',answer{1,1},' nm', ' > ', 'Spectral Range (', num2str(end_wavelength),' - ', num2str(start_wavelength), ' = ', num2str(end_wavelength-start_wavelength), ' nm)! Please Enter Again!'];
                uiwait(msgbox(msg,'Warning','custom',I));
                Spectral_Bands_Select();
            else
                user_imput_band_res = strcat(convertCharsToStrings(answer{1,1}), ' nm');
                Spectral_Bands_Popup_Selects = {"1 nm","10 nm","20 nm","50 nm", "RGB","Gray","Enter a number", user_imput_band_res};
                set(Spectral_Bands_Popup, 'String',Spectral_Bands_Popup_Selects,'value', 8);
            end
            
        end
    end
    function Fovea_Recontruction_Check(~,~)
        if (isequal(Fovea_Recontruction_Checkbox.Value,1))
            set(Fovea_Recontruction_Popup,'Enable','on');
            set(Spectral_Bands_Popup, 'value', 6, 'Enable','off');
            set(Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','off');
            set(STOne_Reconstruction_Popup, 'value',1,'Enable','off');
            ROI_coordinates_input();
        else
            set(Fovea_Recontruction_Popup,'Enable','off');
            set(Spectral_Bands_Popup, 'value', 6, 'Enable','on');
            set(Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','on');
            set(STOne_Reconstruction_Popup, 'value',1,'Enable','on');
        end
    end
    function Gray_Scale_Fovea_Recontruction_Check(~,~)
        if (isequal(Gray_Scale_Fovea_Recontruction_Checkbox.Value,1))
            set(Gray_Scale_Fovea_Recontruction_Popup,'Enable','on');
            set(Gray_Scale_Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','off');
            set(Gray_Scale_STOne_Reconstruction_Popup, 'value',1,'Enable','off');
            set(Image_Resolution_Popup,'Enable','off','value',Spacial_Resolution_Popup.Value);
            ROI_coordinates_input();
        else
            set(Gray_Scale_Fovea_Recontruction_Popup,'Enable','off');
            set(Gray_Scale_Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','on');
            set(Gray_Scale_STOne_Reconstruction_Popup, 'value',1,'Enable','on');
            set(Image_Resolution_Popup,'Enable','on');
        end
    end
    function Resolution_Callback(~,~)
        if (isequal(Fovea_Recontruction_Popup.Enable,'on'))
            msg1 = 'Fovea Resolution > Spatial Resolution! Please select again.';
            foveaResolution = Fovea_Recontruction_Popup.String{Fovea_Recontruction_Popup.Value};
            [n1]=Spatial_resolution(foveaResolution);
            stat = compare_resolution(n1,msg1);
            if(~stat)
                set(Fovea_Recontruction_Popup,'backgroundcolor','red');
            else
                set(Fovea_Recontruction_Popup,'backgroundcolor','w');
            end
        end
        if (isequal(Gray_Scale_Fovea_Recontruction_Popup.Enable,'on'))
            msg2 = 'Gray Scale Fovea Resolution > Spatial Resolution! Please select again.';
            Gray_Scale_foveaResolution = Gray_Scale_Fovea_Recontruction_Popup.String{Gray_Scale_Fovea_Recontruction_Popup.Value};
            [n2]=Spatial_resolution(Gray_Scale_foveaResolution);
            stat = compare_resolution(n2,msg2);
            if(~stat)
                set(Gray_Scale_Fovea_Recontruction_Popup,'backgroundcolor','red');
            else
                set(Gray_Scale_Fovea_Recontruction_Popup,'backgroundcolor','w');
            end
        end
        if (isequal(Image_Resolution_Popup.Enable,'on'))
            msg3 = 'Image Resolution > Spatial Resolution! Please select again.';
            imageResolution = Image_Resolution_Popup.String{Image_Resolution_Popup.Value};
            [n3]=Spatial_resolution(imageResolution);
            stat = compare_resolution(n3,msg3);
            if(~stat)
                set(Image_Resolution_Popup,'backgroundcolor','red');
            else
                set(Image_Resolution_Popup,'backgroundcolor','w');
            end
        end
    end
    function Data_File_Select(~,~)
        [CSV_file,CSV_path] = uigetfile({'*.csv';'*.xlsx'},'Select a File to Open',csv_file_path);
        if (~isequal(CSV_path, 0) && ~isequal(CSV_file, 0))
            csv_file_path=CSV_path;
            CSVNAME=CSV_file;
            CSV_File_List.String = CSVNAME;
        end
    end
    function STOne_Reconstruction_Callback(~,~)
        if (isequal(STOne_Reconstruction_Popup.Value,2))
            set(Spectral_Bands_Popup, 'value', 6, 'Enable','off');
            set(Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','off');
            [v_type]=video_type();
            if (~v_type)
                STOne_Reconstruction_Callback();
            end
            STOne_Reconstruction_Popup_Selects = {'Image', ['Video (' user_input_video_type ')']};
            set(STOne_Reconstruction_Popup, 'string',STOne_Reconstruction_Popup_Selects);
        else
            set(Spectral_Bands_Popup, 'value', 6, 'Enable','on');
            set(Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','on');
        end
    end
    function Gray_Scale_STOne_Reconstruction_Callback(~,~)
        if (isequal(Gray_Scale_STOne_Reconstruction_Popup.Value,2))
            set(Image_Resolution_Popup,'Enable','off','value',Spacial_Resolution_Popup.Value);
            set(Gray_Scale_Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','off');
            [v_type]=video_type();
            if (~v_type)
                Gray_Scale_STOne_Reconstruction_Callback();
            end
            Gray_Scale_STOne_Reconstruction_Popup_Selects = {'Image', ['Video (' user_input_video_type ')']};
            set(Gray_Scale_STOne_Reconstruction_Popup, 'string',Gray_Scale_STOne_Reconstruction_Popup_Selects);
        else
            set(Image_Resolution_Popup,'Enable','on','value',Spacial_Resolution_Popup.Value);
            set(Gray_Scale_Compressive_Recontruction_Ratio_Popup, 'value',1,'Enable','on');
        end
    end
    %-----------------------------------------------%
    %%%%%%%%% Hyperspectral Reconstruction %%%%%%%%%%
    %-----------------------------------------------%
    function Hyperspec_Reconstruction(~,~)
        if (isequal(Spectral_Bands_Popup.Value,7))
            uiwait(msgbox('Please Select/Enter a Spec Resolution for Hyperspectral Reconstruction!','Warning','custom',I));
            set(Spectral_Bands_Popup,'backgroundcolor','red');
            return
        else
            set(Spectral_Bands_Popup,'backgroundcolor','w');
        end
        % parameters from UI
        spacialResolution = Spacial_Resolution_Popup.String{Spacial_Resolution_Popup.Value};
        current_band_res = string(Spectral_Bands_Popup.String{Spectral_Bands_Popup.Value});
        rot_angle = str2double(Rotate_Angle_Popup.String{Rotate_Angle_Popup.Value});
        Mu = Mu_Popup.String{Mu_Popup.Value};
        compratio=Compressive_Recontruction_Ratio_Popup.String{Compressive_Recontruction_Ratio_Popup.Value};
        [record_file,start_wavelength,end_wavelength]=get_wavelength_range();
        
        [~,file_name,fExt] = fileparts(record_file);
        if (lower(fExt) ~= ".csv")
            uiwait(msgbox('Please Select a CSV File (*.csv) for Hyperspectral Reconstruction!','Warning','custom',I));
            return
        end
        % progress bar
        f = waitbar(0,'Processing...','Name','Hyperspec Reconstruction',...
                    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
        setappdata(f,'canceling',0);
        
        [n]=Spatial_resolution(spacialResolution);
        bg_value = 4000;
        order = createOrderingData(n,'full');
            
        output = sprintf('%s_resolution_%dx%d',current_band_res,n,n);
        output_folder=fullfile(csv_file_path,[output,'_',file_name]);
        if(~ exist(output_folder,'dir'))
            mkdir(output_folder);
        end
        Browser_folder = output_folder;
        value_total(:,:)=csvread(record_file,2,4);
        [rows,columns]=size(value_total);
        switch current_band_res
            case '1 nm'
                compensate = 0; loop_end = end_wavelength-start_wavelength+1; % 400 - 850 nm
            case '10 nm'
                loop_end = (end_wavelength-start_wavelength)/10+1;
            case '20 nm'
                loop_end = ((end_wavelength-start_wavelength)/10+1)/2;
            case '50 nm'
                loop_end = (end_wavelength-start_wavelength)/50+1;
            case 'RGB'
                loop_end = (end_wavelength-start_wavelength)/10-1;
            case 'Gray'
                loop_end = 1;
            otherwise
                compensate = 0; loop_end = end_wavelength-start_wavelength+1;
        end
        if(isequal(STOne_Reconstruction_Popup.Value,2))
            start_pix=1;
            end_pix=columns;
            loop_end = 1;
            reflectances=zeros(n,n,loop_end);
        end
            for j=1:loop_end
                % Check for clicked Cancel button
                if getappdata(f,'canceling')
                    break
                end
                % Update waitbar and message
                waitbar(j/loop_end,f,'Processing...')
                if (current_band_res == "1 nm" || isequal(Spectral_Bands_Popup.Value,8))
                    start_pix=3*j-2-compensate;
                     if (mod(j,5) == 0)
                         end_pix=start_pix+1;
                         compensate=compensate+1;
                     else
                          end_pix=start_pix+2;
                     end
                     Lambda = 399+j;
                end
                if (current_band_res == "10 nm" || current_band_res == "RGB")
                     start_pix=28*j-27;
                     end_pix=28*j;
                     Lambda = 400+(j-1)*10;
                end
                if (current_band_res == "20 nm")
                     start_pix=56*j-55;
                     end_pix=56*j;
                     Lambda = 400+(j-1)*20;
                end
                if (current_band_res == "50 nm")
                     start_pix=128*j-127;
                     end_pix=128*j;
                     Lambda = 400+(j-1)*50;
                end
                if (current_band_res == "Gray")
                     start_pix=1;
                     end_pix=columns;
                     Lambda = 'Gray';
                end
                 if (isequal(STOne_Reconstruction_Popup.Value,1) && isequal(Fovea_Recontruction_Checkbox.Value,0) && ~isequal(current_band_res, "RGB") && ~isequal(Spectral_Bands_Popup.Value,8))
                     t = datetime('now','TimeZone','local','Format','dMMy_HHmmss');
                     file_save_final=sprintf('%s_nm_%d_%d_%d_%s.txt', num2str(Lambda),bg_value,start_pix,end_pix,t);

                     file_final=fullfile(output_folder, file_save_final);
                     fileID= fopen(file_final,'w');
                 end
                
                 for i=1: rows

                      value_2=value_total(i,(start_pix:end_pix));
                      mean_value2=mean(value_2);
                      mean_value_final(i)=mean_value2-bg_value;
                       if (isequal(STOne_Reconstruction_Popup.Value,1) && isequal(Fovea_Recontruction_Checkbox.Value,0) && ~isequal(current_band_res, "RGB") && ~isequal(Spectral_Bands_Popup.Value,8))
                            fprintf(fileID, '%.2f \r\n',mean_value_final(i));
                       end

                 end
                 
                 if(isequal(STOne_Reconstruction_Popup.Value,2))
                        reflectances(:,:,j)=reshape(mean_value_final, n,n);
                 end
                  if (isequal(Spectral_Bands_Popup.Value,8))
                      input_spec_res = strsplit(current_band_res);
                      input_spec_res = str2double(input_spec_res{1});
                      input_spec(:,j) = mean_value_final;
                      
                      if (j>=input_spec_res && mod(j,input_spec_res) == 0)
                          Lambda = 400+j-input_spec_res;
                          t = datetime('now','TimeZone','local','Format','dMMy_HHmmss');
                          file_save_final=sprintf('%s_nm_%d_%s.txt', num2str(Lambda),bg_value,t);

                          file_final=fullfile(output_folder, file_save_final);
                          fileID= fopen(file_final,'w');
                          for i=1:rows
                            input_spec_2(i) = mean(input_spec(i,(j+1-input_spec_res:j)));
                            fprintf(fileID, '%.2f \r\n',input_spec_2(i));
                          end
                          mean_value_final = input_spec_2;
                          
                      end
                  end

            %%%%%%%%%%%%%%%%%%%% image reconstruction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                     
                 if ((isequal(STOne_Reconstruction_Popup.Value,1) && isequal(Fovea_Recontruction_Checkbox.Value,0) && ~isequal(Spectral_Bands_Popup.Value,8)) || (isequal(Spectral_Bands_Popup.Value,8) && mod(j,input_spec_res) == 0) )
                     if (~isequal(current_band_res, "RGB"))
                        fclose(fileID);
                     end
                     [full_res_recon,~]=image_reconstruction(mean_value_final,order,n, output_folder, Lambda, current_band_res,compratio,rows, Mu, rot_angle);
                     final_recon(:,:,j)=full_res_recon;
                 end
            %%%%%%%%%%%%%%%%%%%% fovea reconstruction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                     
                if (isequal(STOne_Reconstruction_Popup.Value,1) && isequal(Fovea_Recontruction_Checkbox.Value,1))
%                     c_prev = 6; %  peripheral low_resolution 2^c_prev
                    foveaResolution = Fovea_Recontruction_Popup.String{Fovea_Recontruction_Popup.Value};
                    [n1]=Spatial_resolution(foveaResolution);
                    msg1 = 'Fovea Resolution > Spatial Resolution! Please select again.';
                    compare_resolution(n1,msg1);
                    c_prev = log2(n1);
                    fovea_reconstruction(mean_value_final,n,c_prev,order,output_folder,file_name,Mu, rot_angle);
                end
            end
            %%%%%%%%%%%%%%%%%%%% RGB reconstruction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if (current_band_res == "RGB")
                rgb_reconstruction(n,Lambda,final_recon,output_folder,file_name);
            end
            %%%%%%%%%%%%%%%%%%%% video reconstruction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if(isequal(STOne_Reconstruction_Popup.Value,2))
                dataPerFrame = 1024;  % 1024  How many samples to use in a frame - i.e. the width of the data window
                shiftPerFrame = 256;% 128/512 round(dataPerFrame/16); % /16for128 % How many samples does the data window shift between frames
%                 mu = 5; % 150,  The weight of the data term in the variational reconstruction
                mu = str2double(Mu);
                Nf = 1000;  %  MAXIMUM number of frames to do

                [output_folder]=video_reconstruction(n,csv_file_path,file_name,reflectances,dataPerFrame,shiftPerFrame,mu,Nf,order,rot_angle);

            end
        delete(f)
        if (j<loop_end)
            uiwait(msgbox('Reconstruction Failed!','Fail','custom',I));
            return
        else
            uiwait(msgbox('Reconstruction Finished!','Success','custom',I));
%             Spectral_Bands_Popup_Selects = {'1 nm','10 nm','20 nm','50 nm', 'RGB','Gray','Enter a number'};
%             set(Spectral_Bands_Popup, 'string',Spectral_Bands_Popup_Selects,'value', 2);
            if(isequal(STOne_Reconstruction_Popup.Value,2))
                winopen(output_folder)
            else
                open_img_folder(output_folder)
            end
        end
    end
    %-----------------------------------------------%
    %%%%%%%%%% Gray Scale Reconstruction %%%%%%%%%%%%
    %-----------------------------------------------%
    function Gray_Scale_Reconstruction(~,~)
        rot_angle = str2double(Gray_Scale_Rotate_Angle_Popup.String{Gray_Scale_Rotate_Angle_Popup.Value});
        spacialResolution = Spacial_Resolution_Popup.String{Spacial_Resolution_Popup.Value};
        [n1]=Spatial_resolution(spacialResolution);
        imageResolution = Image_Resolution_Popup.String{Image_Resolution_Popup.Value};
        [n2]=Spatial_resolution(imageResolution);
        if (isequal(Image_Resolution_Popup.Enable,'on'))
            msg3 = 'Image Resolution > Spatial Resolution! Please select again.';
            compare_resolution(n2,msg3);
        end
        if (n1>n2)
            n=n1;
        else
            n=n2;
        end
        current_csv_file = CSV_File_List.String;
        record_file=fullfile(csv_file_path, current_csv_file);
        [~,file_name,fExt] = fileparts(record_file);
        if (lower(fExt) ~= ".xlsx")
            uiwait(msgbox('Please Select an EXCEL File (*.xlsx) for Gray Scale Reconstruction!','Warning','custom',I));
            return
        end
        
        f = waitbar(0,'Processing...','Name','Gray Scale Reconstruction',...
                    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
        setappdata(f,'canceling',0);
        
        output = sprintf('%s_resolution_%dx%d',imageResolution,n,n);
        output_folder=fullfile(csv_file_path,[output,'_',file_name]);
        if(~ exist(output_folder,'dir'))
            mkdir(output_folder);
        end
        img_output_folder=fullfile(output_folder,'images');
        if(~ exist(img_output_folder,'dir'))
            mkdir(img_output_folder);
        end
        Browser_folder = output_folder;
        xx = xlsread(record_file,'D:D');
        
        %%%%%%%%%%%% Convert sampling data %%%%%%%%%%%%%%%%%%%%%%%% 
        nn=numel(xx);
        k=n^2;
        sampleratio=ceil(nn/k);
        separation=floor(nn/k);
        effData=floor(separation/2); %% effective data sample for averaging
        rampData=ceil((sampleratio-effData)/2);
        x=1:nn;
        TF=islocalmin(xx,'MinSeparation',separation);
        mx=x(TF);  %%minimum element position in raw data (usually 10x)

%         dat_x=1:k; %128x128

        %%%%%%% Use Average  ___BEGIN

        for i=2:(k-1)
            % Check for clicked Cancel button
            if getappdata(f,'canceling')
                break
            end
            % Update waitbar and message
            waitbar(i/(k-1),f,'Processing...')
            
            gray_data(i)=max(xx(mx(i-1)+rampData:mx(i)-rampData));
        end
        if (i<(k-1))
            delete(f)
            uiwait(msgbox('Reconstruction Failed!','Fail','custom',I));
            return
        end
        gray_data(1)=max(xx(1:mx(1)));
        gray_data(k)=max(xx(mx(numel(mx)):nn));
        gray_data = gray_data.';
        [rows,~]=size(gray_data);
        
        order = createOrderingData(n,'full');
        Lambda = 'Gray';
        current_band_res=imageResolution;
        compratio = Gray_Scale_Compressive_Recontruction_Ratio_Popup.String{Gray_Scale_Compressive_Recontruction_Ratio_Popup.Value};
        Mu = Gray_Scale_Mu_Popup.String{Gray_Scale_Mu_Popup.Value};
        
        %%%%%%%%%% Image Reconstruction %%%%%%%%%
        if (isequal(Gray_Scale_STOne_Reconstruction_Popup.Value,1) && isequal(Gray_Scale_Fovea_Recontruction_Checkbox.Value,0))
            [full_res_recon,rec]=image_reconstruction(gray_data,order,n, output_folder, Lambda, current_band_res, compratio, rows, Mu,rot_angle);
            final = imresize(full_res_recon,[n2,n2]);
            save([fullfile(output_folder,[num2str(n2), 'x', num2str(n2)]) '.txt'],'final','-ascii');
            imwrite(final,[fullfile(img_output_folder,[num2str(n2), 'x', num2str(n2)]) '.png']);

            final_1 = imresize(rec,[n2,n2]);
            save([fullfile(output_folder,[num2str(n2), 'x', num2str(n2), ' ', compratio, '% Reconstruction']) '.txt'],'final','-ascii');
            imwrite(final_1,[fullfile(img_output_folder,[num2str(n2), 'x', num2str(n2), ' ', compratio, '% Reconstruction']) '.png']);
            figure;
            subplot(1,2,1);
            imagesc(final); colormap gray; axis image;
            title([num2str(n2), 'x', num2str(n2), ' 100% Reconstruction']);
            subplot(1,2,2);
            imagesc(final_1); colormap gray; axis image;
            title([num2str(n2), 'x', num2str(n2), ' ', compratio, '% Reconstruction']);
        end
        
        %%%%%%%%%% Fovea Reconstruction %%%%%%%%%
        if (isequal(Gray_Scale_STOne_Reconstruction_Popup.Value,1) && isequal(Gray_Scale_Fovea_Recontruction_Checkbox.Value,1))
            foveaResolution = Gray_Scale_Fovea_Recontruction_Popup.String{Gray_Scale_Fovea_Recontruction_Popup.Value};
            [n3]=Spatial_resolution(foveaResolution);
            c_prev = log2(n3);
            fovea_reconstruction(gray_data,n,c_prev,order,output_folder,file_name,Mu,rot_angle);  
        end
        %%%%%%%%%% Video Reconstruction %%%%%%%%%
        if (isequal(Gray_Scale_STOne_Reconstruction_Popup.Value,2))
            dataPerFrame = 1024;  % 1024  How many samples to use in a frame - i.e. the width of the data window
            shiftPerFrame = 256;% 128/512 round(dataPerFrame/16); % /16for128 % How many samples does the data window shift between frames
    %       mu = 5; % 150,  The weight of the data term in the variational reconstruction
            mu = str2double(Mu);
            Nf = 1000;  %  MAXIMUM number of frames to do

%             video_reconstruction(n,csv_file_path,file_name,reflectances,dataPerFrame,shiftPerFrame,mu,Nf,order);
            video_reconstruction(n,output_folder,file_name,gray_data,dataPerFrame,shiftPerFrame,mu,Nf,order,rot_angle);
        end
        delete(f)
        uiwait(msgbox('Reconstruction Finished!','Success','custom',I));
        if (isequal(Gray_Scale_STOne_Reconstruction_Popup.Value,2))
            winopen(output_folder)
        else
            open_img_folder(output_folder)
        end
        
    end

% helper functions
    function [full_res_recon, rec]=image_reconstruction(mean_value_final,order,n, output_folder, Lambda, current_band_res, compratio, rows, Mu,rot_angle)
       meas = mean_value_final;
       meas = meas(:).';
       full_res_recon = zeros(n,n);
       rec = zeros(n,n);
       if (isequal(Lambda, 'Gray'))
           out = 'Gray';
       else
           out = [num2str(Lambda), ' nm'];
       end
       img_output_folder=fullfile(output_folder,'images');
        if(~ exist(img_output_folder,'dir'))
            mkdir(img_output_folder);
        end
       if (isequal(rows/n^2,1))
         b0(order.samplingOrder) = meas(1:n^2);
         vec_full = STO(b0);
         full_res_recon = nestedVectorToImage(vec_full,order);
         full_res_recon = (full_res_recon - min(full_res_recon(:)))/(max(full_res_recon(:))-min(full_res_recon(:)));
         full_res_recon = imrotate(full_res_recon,rot_angle);
         if (~isequal(current_band_res, "RGB"))
             save([fullfile(output_folder,[out '_fastInverse']) '.txt'],'full_res_recon','-ascii');
             imwrite(full_res_recon,[fullfile(img_output_folder,[out '_fastInverse']) '.png']);
%              figure;
%              subplot(1,2,1);
%              imagesc(full_res_recon); colormap gray; axis image;
%              title([out ' Fast Inverse 100% Reconstruction']);
         end
       end
            %% Sub-sampled Reconstruction
       if (~isequal(current_band_res, "RGB"))
          if (str2double(compratio) <= (rows/n^2)*100)
            ind = round(n^2*str2double(compratio)/100);
            out_ratio = compratio;
          else
              ind = rows;
              out_ratio = (ind/n^2)*100;
          end
            b_comp = zeros(n^2,1);
            R_comp = zeros(n^2,1);
            mu = str2double(Mu);
            % Get Data for Reconstruction
            rowsToSample = order.samplingOrder(1:ind);
            b_comp(rowsToSample) = meas(1:ind);
            R_comp(rowsToSample) = 1;
            % Reconstruct Image
            [vec_recon,~] = pdhg_image_l1(R_comp,b_comp,mu,order);
            rec = nestedVectorToImage(vec_recon,order);
%             rec = cleanImage(rec,0);
            rec = (rec - min(rec(:)))/(max(rec(:))-min(rec(:)));
            rec = imrotate(rec,rot_angle);
            save([fullfile(output_folder,['Compressive l1_',out, ' ' ,num2str(compratio),' Percent Reconstruction','_mu_',num2str(mu) ]) '.txt'],'rec','-ascii');
            imwrite(rec,[fullfile(img_output_folder,['Compressive l1_',out, ' ' ,num2str(compratio),' Percent Reconstruction','_mu_',num2str(mu)]) '.png']);
%             figure;
%             subplot(1,2,2);
%             imagesc(rec); colormap gray; axis image;
%             title(['Compressive $\ell_1$: ',num2str(out_ratio),'$\%$ Reconstruction'],'interpreter','latex');
       end
    end
    function fovea_reconstruction(mean_value_final,n,c_prev,order,output_folder,file_name,Mu,rot_angle)
        meas = mean_value_final;
        numpats = n^2;
        normval = n; % Coefficient of STOne Transform
        c=log2(n);
        res_prev = 2^c_prev;
        P = Make_STOne_Patterns(c);
        P = uint8(reshape(P,n,n,[])>0);
        order_prev = createOrderingData(res_prev,'full');
        % Foveate each pattern in measurement sequence.
        for i = 1:numpats
            P_tmp = sepblockfun(P(:,:,i),[2^(c-c_prev),2^(c-c_prev)],'sum');
            P_tmp = round(P_tmp/(2^(c-c_prev))^2);
            P_tmp = reshape(P_tmp,n/(2^(c-c_prev)),n/(2^(c-c_prev)));
            P_foveated(:,:,i) = kron(double(P_tmp),ones(2^(c-c_prev)))/normval;
            P_foveated(topLeftCorner(1):botRightCorner(1),topLeftCorner(2):botRightCorner(2),i) = ...
                double(P(topLeftCorner(1):botRightCorner(1),topLeftCorner(2):botRightCorner(2),i))/normval;
            clear P_tmp
        end
        bigP_foveated_t = reshape(P_foveated,n^2,n^2);
        bigP_NatSTOne_t = double(reshape(P,n^2,n^2))/normval;
        invperm = order.vector;
        invperm(invperm) = linspace(1,n^2,n^2);
        invsample = order.samplingOrder;
        invsample(invsample) = linspace(1,n^2,n^2);
        bigP_foveated_t = bigP_foveated_t(invperm,:); % Invert Row Permutations of Transpose
        bigP_foveated_t = bigP_foveated_t(:,invsample); % Invert Column Permutations of Transpose
        bigP_NatSTOne_t = bigP_NatSTOne_t(invperm,:);
        bigP_NatSTOne_t = bigP_NatSTOne_t(:,invsample);
        bigP_foveated = bigP_foveated_t';
        bigP_NatSTOne = bigP_NatSTOne_t';
        compratio = 1;
        ind = round(n^2*compratio);
        b_comp = zeros(n^2,1);
        R_comp = zeros(n^2,1);
        mu = str2double(Mu);
        % Get Data for Reconstruction
        rowsToSample = order.samplingOrder(1:ind);
        b_comp(rowsToSample) = meas(1:ind);
        R_comp(rowsToSample) = 1;
        % Reconstruct Image
        bigP_foveated(bigP_foveated==0) = -1/normval; % Convert transform to +/-
        bigP_foveated_t(bigP_foveated_t==0) = -1/normval; % Convert transform to +/-
        % Account for >50% light acceptance of STO pats and 1/0 -> +/-.
        count_1 = 1; count_0 = 0;
        for ii = 1:c
            count_1_new = count_1*3 + count_0;
            count_0_new = count_1 + count_0*3;
            count_1 = count_1_new; count_0 = count_0_new;
        end
        for ii = 1:size(b_comp,2)
            tmp = b_comp(R_comp(:,ii)==1,ii);
            tmp_mean = mean(tmp);
            tmp_mean = tmp_mean/count_1*(count_1+count_0)/2;
            tmp = tmp - tmp_mean;
            b_comp(R_comp(:,ii)==1,ii) = tmp;
            b_comp(:,ii) = b_comp(:,ii)/(2^(c-1));
        end
        [vec_recon,~] = pdhg_image_l1_fovea(R_comp,b_comp,mu,order,double(bigP_foveated),double(bigP_foveated_t));
        rec = nestedVectorToImage(vec_recon,order);

        % Intensity Correction
        test = rec(topLeftCorner(1):botRightCorner(1),topLeftCorner(2):botRightCorner(2))/(2^(c-c_prev));
        test2 = rec;
        test2(topLeftCorner(1):botRightCorner(1),topLeftCorner(2):botRightCorner(2))=test;
        test2 = imrotate(test2,rot_angle);
        img_output_folder=fullfile(output_folder,'images');
        if(~ exist(img_output_folder,'dir'))
            mkdir(img_output_folder);
        end
        imwrite(mat2gray(test2), fullfile(img_output_folder,strcat(strtok(file_name, '.'),'_',num2str(res_prev),'_',num2str(n),'_Foveated_Reconstruction_',num2str(topLeftCorner),'_',num2str(botRightCorner),'.jpg')));
        figure;imshow(test2,[]);
        title([num2str(res_prev),'/',num2str(n),' Foveated Reconstruction (',num2str(topLeftCorner),') (',num2str(botRightCorner),')'])
        set(gca,'fontsize',12);
    end
    function [output_folder]=video_reconstruction(n,csv_file_path,file_name,reflectances,dataPerFrame,shiftPerFrame,mu,Nf,order,rot_angle)
            output = sprintf('%s_%dx%d','video',n,n);
            output_folder=fullfile(csv_file_path,output);
            if(~ exist(output_folder,'dir'))
                mkdir(output_folder);
            end
            mat_file_final = fullfile(output_folder, [file_name '.mat']);
            save(mat_file_final, 'reflectances');
            data = reflectances(:);
            Nd = size(data,1);  % number of data
            Nf = min(Nf,floor((Nd-dataPerFrame)/shiftPerFrame)); % Number of frames
            R = zeros(n^2,Nf);
            b = zeros(n^2,Nf);
            rowsToSample = order.samplingOrder;
            %%  Bin the data into the columns of b.  Every column contains the transform coefficients for a single frame
            start = 1;
            stop = dataPerFrame;
            for g = 1:Nf
                rowsInThisFrame = rowsToSample(1:dataPerFrame);
                R(rowsInThisFrame,g) = 1;
                b(rowsInThisFrame,g) = data(start:stop);
                start = start+shiftPerFrame;
                stop = stop+shiftPerFrame;
                rowsToSample = circshift(rowsToSample,-shiftPerFrame);
            end
            %%  Subtract means to convert the data from 0/1 to +1/-1
            for q=1:Nf
                avZ = sum(b(:,q))/sum(R(:,q));
                avSTO = avZ/(n+1);
                b(:,q) = b(:,q) + (avSTO-avZ); 
            end
            %  SOLVE
            type=user_input_video_type;
            if exist('type','var') && strcmp(type,'l1')
                [u,outs] = pdhg_video_l1( R, b, mu, order );
                type = 'l1';
            else
                [u,outs] = pdhg_video( R, b, mu, order );
                type = 'l2';
            end
            %% Create an array of 2d frames from the column vectors by re-shaping them
            frames = zeros(n,n,Nf);
            for p = 1:Nf
                frames(:,:,p) = nestedVectorToImage(u(:,p),order);

            end
            frames = imrotate(frames,rot_angle);
            %%  Display 4 frames
            figure
            subplot(2,2,1);
            imagesc(frames(:,:,1))
            %{ hand
            subplot(2,2,2);
            imagesc(frames(:,:,2))
            subplot(2,2,3);
            imagesc(frames(:,:,round(Nf/2)))
            subplot(2,2,4);
            imagesc(frames(:,:,Nf))
            %}
            colormap gray;
            %frames_new=frames(:,:,1)-frames(:,:,2);
            %figure
            %imagesc(frames_new);
            colormap gray;
            small = min(frames(:));
            big = max(frames(:));

            frames = (frames-small)*255/(big-small);
            %%  Write the results to an animated gif file
            filename = [file_name '_' type '_Nr_',num2str(n) ,'_Nd_' ,num2str(length(data)) ,'_Ndf_', num2str(dataPerFrame),'_shift_',num2str(shiftPerFrame),'_Nf_',num2str(Nf), '_mu_',num2str(mu) ];
            imdata = permute(frames,[1 2 4 3]);
            imwrite(imdata,fullfile(output_folder,[filename '.gif']),'DelayTime',0,'LoopCount',inf);

            save(fullfile(output_folder,[filename '.mat']),'frames');
    end
    function rgb_reconstruction(n,Lambd,final_recon,output_folder,file_name)
     Lambda = Lambd;
     [~,~,ref_size]=size(final_recon);
     ref_lambdas = zeros(ref_size);
     for i = 1:ref_size
         ref_lambdas(i)=400+10*(i-1);
     end
     Lambda=0;
     if(Lambda~=0)
       Lambda_idx=floor((Lambda-400)./10)+2;
     else
       Lambda_idx=1;
     end
     radiances=zeros(size(final_recon));
     [illum_lambda,energy]=illuminant();
     energy=energy';
     illum_size=length(illum_lambda);
    
     for i=1:ref_size
          for j=1:illum_size
            if(ref_lambdas(i)==illum_lambda(j))
                radiances(:,:,i)=final_recon(:,:,i)*energy(j);
            end
          end
     end
       
     [r c w]=size(radiances);
     radiances=reshape(radiances,r*c, w);
     [xyz_lambda, xyzbar]=colorMatchFcn();
     xyz_size=length(xyz_lambda);
     if(Lambda==0)    
         xyz_value=zeros(ref_size,3);
         for i=1:ref_size
            if(i==1)
                 xyz_value(i,:)=mean(xyzbar,1);
            else
               for j=1:xyz_size 
                 if(ref_lambdas(i)==xyz_lambda(j))
                    xyz_value(i,:)=xyzbar(j,:);
                 end
               end
            end
         end
         XYZ=(xyz_value'*radiances')';
         XYZ=reshape(XYZ,r,c,3);
         
         XYZ=XYZ/max(XYZ(:));
     
         RGB=XYZ2sRGB_exgamma(XYZ);
         RGB=max(RGB,0);
         RGB=min(RGB,1);
        
         [input_img_imadjust]=enhance_img(RGB);
      %   z=max(RGB(32,32,:));
      %   RGB_clip=min(RGB,z)/z;
         figure;
         subplot(1,2,1);
         imshow(RGB);
         title(sprintf('%dx%d - 100 Percent RGB Image',n,n));
         subplot(1,2,2);
         imshow(input_img_imadjust);
         title('ImAdjusted');
         img_output_folder=fullfile(output_folder,'images');
        if(~ exist(img_output_folder,'dir'))
            mkdir(img_output_folder);
        end
         imwrite(RGB, fullfile(img_output_folder,strcat(file_name,'_',num2str(n),'x',num2str(n),' - 100 Percent RGB Image','.jpg')));
         imwrite(input_img_imadjust, fullfile(img_output_folder,strcat(file_name,'_',num2str(n),'x',num2str(n),' - 100 Percent RGB Image - Adjusted','.jpg')));
      %   figure
      %   imshow(RGB_clip);
       %  title('Reconstracted 100% RGB Image bright');
         
         
     else
         radiances1= radiances(:,Lambda_idx);
         for xyz_idx=1:xyz_size 
            if(Lambda==xyz_lambda(xyz_idx))
               xyz_value1=xyzbar(xyz_idx,:);
            end
         end
         XYZ1=(xyz_value1'*radiances1')';
         XYZ1=reshape(XYZ1,r,c,3);
         XYZ1=XYZ1/max(XYZ1(:));
     
         RGB1=XYZ2sRGB_exgamma(XYZ1);
        % z=max(RGB1(100,17,:))
        % RGB_clip=min(RGB1,z)/z;
         figure
         imshow(RGB1);
         %figure
         %imshow(RGB_clip);
         title(sprintf('%dx%d - %d nm RGB Image',n,n,Lambda));
         enhance_img(RGB1);
     end
     
    end
    function ROI_coordinates_input()
        spacialResolution = Spacial_Resolution_Popup.String{Spacial_Resolution_Popup.Value};
        [n]=Spatial_resolution(spacialResolution);
        topLeftMsg = sprintf('Enter (row column) of ROI top-left corner  < %d',n);
        botRightMsg = sprintf('Enter (row column) of ROI bottom-right corner < %d',n);
        prompt = {topLeftMsg,botRightMsg};
        dlgtitle = 'ROI Coordinates';
        dims = [1 35];
        definput = {'41 37','88 80'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        if (isempty(answer))
            topLeftCorner = [41,37];
            botRightCorner = [88,80];
        else
            topLeftCorner = [str2num(answer{1})];
            botRightCorner = [str2num(answer{2})];
        end
        
        for i = 1:2
            if (topLeftCorner(i) > botRightCorner(i))
                msg = ['Corordinates of Top-Left Corner (', num2str(topLeftCorner),') > Those of Bottom-Right Corner (', num2str(botRightCorner), ')! Please Recheck and Enter Again!'];
                uiwait(msgbox(msg,'Warning','custom',I));
                ROI_coordinates_input;
            end
            if (topLeftCorner(i) >= n || botRightCorner(i) >= n)
                msg = sprintf('Corordinates of ROI > Spacial Resolution (%d)! Please Recheck and Enter Again!',n);
                uiwait(msgbox(msg,'Warning','custom',I));
                ROI_coordinates_input;
            end
            if (mod(botRightCorner(i) - topLeftCorner(i),2)==0)
                uiwait(msgbox('The Width or Height of ROI Is EVEN. Please Recheck and Enter the Coordinates Again!','Warning','custom',I));
                ROI_coordinates_input;
            end
        end
    end
    function stat = compare_resolution(n1,msg)
            stat = true;
            spacialResolution = Spacial_Resolution_Popup.String{Spacial_Resolution_Popup.Value};
            [n]=Spatial_resolution(spacialResolution);
            if (n1>n)
                uiwait(msgbox(msg,'Warning','custom',I));
                stat = false;
            end
    end
    function open_img_folder(output_folder)
        img_output_folder=fullfile(output_folder,'images');
        if(~ exist(img_output_folder,'dir'))
            mkdir(img_output_folder);
        end
        winopen(img_output_folder);
    end
    function [v_type]=video_type()
        v_type=true;
        prompt = {'Please Enter "1" for "l1" or "2" for "l2 Preview" Reconstruction'};
        dlgtitle = 'Video Reconstruction Type';
        dims = [1 50];
        definput = {'2'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        if (isempty(answer))
            return
        elseif (answer{1} ~= "1" && answer{1} ~= "2")
            msg = ['Your Input "',answer{1}, '" Is Not "1" or "2"! Please Enter Again!'];
            uiwait(msgbox(msg,'Warning','custom',I));
            v_type=false;
        else
            user_input_video_type = ['l' answer{1}];
        end
    end
    function [record_file,start_wavelength,end_wavelength]=get_wavelength_range()
        current_csv_file = CSV_File_List.String;
        record_file=fullfile(csv_file_path, current_csv_file);
        
        csvID = fopen(record_file);
        d = textscan(csvID,'%s',2500);fclose(csvID);
        z=split(d{1,1}{1,1},',');
        l=size(z);
        start_wavelength = ceil(str2num(str2num(z{5})));
        end_wavelength = ceil(str2num(str2num(z{l(1)})));
    end
end
% helper functions
function [n]=Spatial_resolution(spacialResolution)
        switch spacialResolution
            case '1024x1024'
                n = 1024;
            case '512x512'
                n = 512;
            case '256x256'
                n = 256;
            case '128x128'
                n = 128;
            case '64x64'
                n = 64;
            case '32x32'
                n = 32;
        end
end
function [input_img_imadjust]=enhance_img(input_img)
    srgb2lab = makecform('srgb2lab');
    lab2srgb = makecform('lab2srgb');

    input_img_lab = applycform(input_img, srgb2lab); % convert to L*a*b*

    % the values of luminosity can span a range from 0 to 100; scale them
    % to [0 1] range (appropriate for MATLAB(R) intensity images of class double) 
    % before applying the three contrast enhancement techniques
    max_luminosity = 100;
    L = input_img_lab(:,:,1)/max_luminosity;

    % replace the luminosity layer with the processed data and then convert
    % the image back to the RGB colorspace
    input_img_imadjust = input_img_lab;
    input_img_imadjust(:,:,1) = imadjust(L)*max_luminosity;
    input_img_imadjust = applycform(input_img_imadjust, lab2srgb);

    % input_img_histeq = input_img_lab;
    % input_img_histeq(:,:,1) = histeq(L)*max_luminosity;
    % input_img_histeq = applycform(input_img_histeq, lab2srgb);
    % 
    % input_img_adapthisteq = input_img_lab;
    % input_img_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity;
    % input_img_adapthisteq = applycform(input_img_adapthisteq, lab2srgb);


    % figure, imshow(input_img_imadjust);
    % title('Imadjust');

    % figure, imshow(input_img_histeq);
    % title('Histeq');
    % 
    % figure, imshow(input_img_adapthisteq);
    % title('Adapthisteq');
end
