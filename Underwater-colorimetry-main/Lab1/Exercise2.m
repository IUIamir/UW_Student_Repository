% June 8, 2023
% Underwater Colorimetry Course @ IUI Eilat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                               Lab 1                                %%%
%       Basic Image Formation and RAW Image Manipulation Exercises       %
%                                                                        %
%                               Exercise 2                               %
%                          Real Image Exercises                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;clc; warning off

%% LOAD A LINEAR PNG IMAGE THAT HAS A Color Chart IN THE SCENE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Goal of this step: open a **linear** PNG that includes a Macbeth  %
% (or compatible) color chart somewhere in the frame.               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You should have 3 .png images saved from Exercise 1 or provided   %
% by the instructors:                                               %
%    - Your_image_with_a_color_chart.png (your own capture)         %
%    - NikonImage.png (example camera)                              %
%    - CanonImage.png (example camera)                              %
% Replace 'ConvertedImage.png' with one of these filenames. The     %
% image **must be linear** (gamma = 1) and contain the chart.       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = im2double(imread('ConvertedImage.png'));
s = size(I);
% Quick brightness boost (x2) so dark RAW conversions are visible
% even on dim laptop screens. Feel free to adjust the factor.
figure;imshow(I*2)
title('Linear image','fontsize',20)

%% LOAD COLOR CHART DATA
% This example is given for a Macbeth ColorChecker. If you use a
% different chart, swap the dataset accordingly.
load MacbethColorCheckerData.mat

% Location of grey patches in Macbeth ColorChecker.
neutralPatches = [4 1; 4 2; 4 3; 4 4; 4 5; 4 6];

% Y value of grey patches of a Macbeth ColorChecker.
neutralTarget = [89.57 57.76 35.15 19.44 9.08 3.43]./100; 

% Modify these to work for your color chart,
% if different than a Macbeth ColorChecker.

%% MAKE MASKS FOR THE PATCHES OF THE COLOR CHART
% It places the masks for each patch on the image, and waits for the user 
% to drag each mask over the correct patch.

% Once each mask is aligned its corresponding patch, the user should 
% double click the first patch in the chart that will accept the masks 
% for all patches.

% In a Macbeth ColorChecker, the first patch is the Dark Skin (top left).

% Generate masks using makeChartMask function. The scaling factor (3*I)
% brightens the preview so you can easily see the chart while dragging
% patches. The function will prompt you to place each mask on the
% corresponding patch.
masks = makeChartMask(3*I,chart,colors,20);

% Define where to save the masks. Use an **absolute path** or a path
% relative to this script (e.g., 'Masks/' will create a folder inside
% Lab1). Avoid spaces if you run into MATLAB path issues.
savePath = 'Your_Path...';

% Create the folder if it doesn't exist
if ~isfolder(savePath)
    mkdir(savePath); 
end

% Saving masks struct as: masks_struct.mat
saveFile = fullfile(savePath, 'masks_struct.mat');

% Save the masks struct to a .mat file so you can reuse the same
% selections without redragging for each camera/illuminant.
save(saveFile, 'masks');

% Confirmation message
fprintf('Masks struct has been saved to %s\n', saveFile);

%% CHECK THE LINEARITY OF CAMERA RESPONSE
% Purpose: validate that the PNG is still linear. For each gray patch we
% compare the target Y (luminance) to measured RGB values. A straight line
% through the origin indicates a linear camera response.

% Extract RGB patch values. Output dimensions: 3 x number_of_gray_patches.
neutralValues = getPatchValues(I,masks,neutralPatches,colors);

% Plot Y target vs. measured RGB for each channel.
figure;
plot(neutralTarget, neutralValues(1,:), 'or', 'LineWidth', 2)
hold on;
plot(neutralTarget, neutralValues(2,:), 'og', 'LineWidth', 2)
plot(neutralTarget, neutralValues(3,:), 'ob', 'LineWidth', 2)

title('Camera sensor linearity check')
xlabel('Y values')
ylabel('RGB values')
legend('Red channel', 'Green channel', 'Blue channel', Location='northwest')
