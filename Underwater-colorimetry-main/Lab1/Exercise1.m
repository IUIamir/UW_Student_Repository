% June 8, 2023
% Underwater Colorimetry Course @ IUI Eilat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                               Lab 1                                 %%%
%%%      RAW Image Manipulation Exercises and Basic Image Formation     %%%
%%%                                                                     %%%
%%%                             Exercise 1                              %%%
%%%                    Image Manipulatoin Exercises                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part 1: Converting RAW images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this cell we will convert your image with a color chart and 2 other  %
% images provided to you in the course GitHub.                            % 
%                                                                         % 
%                                                                         % 
%   The goal is to take RAW camera data and produce two types of          %
%   viewable images:                                                      % 
%          1) TIFF files                                                  %
%          2) Compressed PNG files                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The 2 images from the Git are:                                          %
%       (1) CanonImage                                                    %  
%       (2) NikonImage                                                    %
% Those are Raw images, convert them in the same way as your own image.   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Instructions:                                                         %
%   Change 'yourpath...' to the appropriate path on your computer that    %
%   contains the Git repo.                                                %
%                                                                         %
%   Do NOT include the subfolders (\dng, \tiff, etc.) here—they are built %
%   automatically with fullfile below.                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

% Example to 'YourPath...' :
% 'C:\Users\colorlab\Documents\GitHub\UWC_2025_Student_Repository\UW_Student_Repository\Underwater-colorimetry-main'
Path_to_your_repository = 'YourPath...';
addpath(genpath(Path_to_your_repository))

%% Part 1.1
dngPath = fullfile(Path_to_your_repository, '\Lab1\Images\dng');           % Folder containing .dng RAW files
tiffSavePath = fullfile(Path_to_your_repository, '\Lab1\Images\tiff');     % Output folder for 16-bit TIFF files
CompresedPngPath = fullfile(Path_to_your_repository, '\Lab1\Images\Cpng'); % Output folder for compressed PNGs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "stage" controls the processing steps inside the conversion pipeline.   %
% Leave it at 4 unless instructed otherwise in the lecture.               % 
stage = 4;
non_UI_path = '\camera-pipeline-nonUI-master';
cd(fullfile(Path_to_your_repository, non_UI_path))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% After converting all RAW files to .dng, convert all .dng files in       %
% "dngPath" to linear TIFFs and save them in "tiffSavePath".              % 
% Each .dng becomes a .tiff file with minimal processing so the pixel     %
% values stay linear with respect to light intensity.                     %
dng2tiff(dngPath, tiffSavePath, stage);

% Convert the TIFFs to compressed PNGs for easy viewing.                  % 
tiff2png(CompresedPngPath, tiffSavePath);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part 2: Show linear and non-linear image side by side
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this cell we show a linear and non-linear images side by side.       %
% The goal is to visually compare how a camera's internal processing      %
% (gamma curves, tone mapping, sharpening) changes the appearance of an   %
% image compared to the linear sensor output.                             %
%                                                                         %
% Include here ONLY GoPro image                                           %
%   .jpg image as an example for a NOT linear image (processed by camera) %
%   .png image as an example for a linear image (from Part I TIFF output) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Instructions:                                                         %
%     1. Change non_linear_image.jpg to a .jpg image from your GoPro.     %
%        This is the camera-generated photo, typically non-linear.        %
%     2. Change linear_image.png to a .png image from your GoPro.         %
%        Use the PNG created from the TIFF in Part I (linear data).       %
%     3. Try few different B values to see which brightness looks best.   %
%        Larger B makes the images brighter; smaller B makes them darker. %
%        Start with B = 2 and adjust until both images are easy to compare.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read the images. Keep file names in quotes and ensure the files are in  %
% the current working directory or provide full paths.                    %
I_linear = imread('non_linear_image.png');
I_Not_linear = imread('non_linear_image.jpg');

% Adjust brightness by multiplying the pixel values by scalar B. Use a    %
% single value for both images so the comparison is fair.                 %
B = 2;

% Display the two images next to each other. The first entry is the       %
% non-linear JPG, the second is the linear PNG.                           %
montage({B*I_Not_linear, B*I_linear})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   - You should see your linear and not linear images side by side.      %
%   - You can change brightness by changing the scalar B.                 %
%   - If your images look clipped (too white) reduce B;                   % 
%     if too dark increase.                                               %
%   - Pause and write down your observations about color and contrast     %
%     differences—this will help during discussion in class.              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%