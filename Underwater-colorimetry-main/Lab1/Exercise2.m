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
%         Replace 'ConvertedImage.png' with your converted          %
%                    images with a color chart.                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You should have 3 .png images:                                    % 
%    - Your_image_with_a_color_chart.png                            %
%    - NikonImage.png                                               %
%    - CanonImage.png                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = im2double(imread('ConvertedImage.png'));
s = size(I);
figure;imshow(I*2)
title('Linear image','fontsize',20)

%% LOAD COLOR CHART DATA
% This example is given for a Macbeth ColorChecker.
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

% Generate masks using makeChartMask function
masks = makeChartMask(3*I,chart,colors,20);

% Define the save path, adjust the directory as needed.
savePath = 'Your_Path...'; 

% Create the folder if it doesn't exist
if ~isfolder(savePath)
    mkdir(savePath); 
end

% Saving masks struct as: masks_struct.mat
saveFile = fullfile(savePath, 'masks_struct.mat');

% Save the masks struct to a .mat file
save(saveFile, 'masks');

% Confirmation message
fprintf('Masks struct has been saved to %s\n', saveFile);

%% CHECK THE LINEARITY OF CAMERA RESPONSE  
% In this cell we will validate image linearity.

% RGB values extracted from patches 
% Dimensions 3 x size(neutralPatches,1)
neutralValues = getPatchValues(I,masks,neutralPatches,colors);

% Plotting Y values vs. RGB values
figure;
plot(neutralTarget, neutralValues(1,:), 'or', 'LineWidth', 2)
hold on;
plot(neutralTarget, neutralValues(2,:), 'og', 'LineWidth', 2)
plot(neutralTarget, neutralValues(3,:), 'ob', 'LineWidth', 2)

title('Camera sensor linearity check')
xlabel('Y values')
ylabel('RGB vlues')
legend('Red channel', 'Green channel', 'Blue channel', Location='northwest')