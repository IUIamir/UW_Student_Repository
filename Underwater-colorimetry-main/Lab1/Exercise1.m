% June 8, 2023
% Underwater Colorimetry Course @ IUI Eilat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                               Lab 1                                %%%
%%%      RAW Image Manipulation Exercises and Basic Image Formation    %%%

%%%                             Exercise 1                             %%%
%%%                    Image Manipulatoin Exercises                    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part I: Converting RAW images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this cell we will convert your image you captured with a color chart % 
%        and 2 other images provided to you in the course GitHub.         %                                                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% The 2 images from the Git are:                                          %                                                                     
%       (1) CanonImage                                                    % 
%       (2) NikonImage                                                    %
% Those are Raw images, convert them in the same way as your own image.   % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Instructions:                                                         % 
%   Change all "yourpath..." to the appropriate path on your computer     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
YourPath = 'yourpath...';

dngPath = fullfile(YourPath, '\dng');  
tiffSavePath = fullfile(YourPath, '\tiff'); 
CompresedPngPath = fullfile(YourPath, '\Cpng'); 
stage = 4;
cd(fullfile(YourPath, '\Underwater-colorimetry-main\camera-pipeline-nonUI-master'))
dng2tiff(dngPath, tiffSavePath, stage);
tiff2png(CompresedPngPath, tiffSavePath);


%% Part II: Show linear and non-linear image side by side
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    In this cell we show a linear and non-linear images side by side   %
%                     Include here ONLY GoPro image                     %
%           .jpg image as an example for a NOT linear image             %
%             .png image as an example for a linear image               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Instructions:                                                       % 
%     1. Change non_linear_image.jpg to a .jpg image from your GoPro.   %
%     2. Change linear_image.png to a .png image from your GoPro.       %
%     3. Try few different B to see which one looks best.               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I_linear = imread('non_linear_image.png');
I_Not_linear = imread('non_linear_image.jpg');
B = 2;
montage({B*I_Not_linear, B*I_linear})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    You should see your linear and not linear images side by side.     %
%         You can change brightness by changing the scalar B.           % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%