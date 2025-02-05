% June 8, 2023 modified January 22, 2024
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 1                                %%%
%%%     Basic Image Formation and RAW Image Manipulation Exercises     %%%


%%%                             Exercise 3                             %%%
%%%                        Simulation Exercises                        %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all; close all; clc; 


%% Step 1 - Simulate a Macbeth ColorChecker

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%       Use the function importdata to read the csv files.     %


% The importdata function will create a struct with fields:    %

%     - data                                                   % 
%     - textdata                                               %
%     - rowheaders                                             %  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load the reflectances %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The data will be 25 x 81, where 1st row is wavelength, and
% rows 2-25 are the patches of the color checker.
refl = importdata('data/MacbethColorCheckerReflectances.csv');
% Inspect the data — pay attention that the wavelength range is 380:5:780.
% This commend will print out the wavelength range:
refl.data(1,:)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load the relevant camera's curves %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cam = importdata('data/Nikon_D90.csv');


% Again, inspect the wavelength ranges, this dataset is 400:10:700. 
% This commend will print out the wavelength range:
cam.data(:,1)

% Don't forget to also load the second camera!
 



%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load the light data %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Uploading illuminant-D65 as: Illuminant_D65
Illuminant_D65 = importdata('data/illuminant-D65.csv');
% Inspect the wavelength ranges. This dataset is 300:5:830 nm.
Illuminant_D65.data(:,1)

% Uploading illuminant-A as: Illuminant_A
Illuminant_A = importdata('data/illuminant-A.csv');
Illuminant_A.data(:,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Interpolating wavelength to 400:10:700 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is quite common. 
% We will have to interpolate to a common range of 400:10:700 
% (corresponding to the camera, as that appears to be the coarsest) 
% as follows:

WL = 400:10:700;
refl_spectra = (interp1(refl.data(1,:)',refl.data(2:end,:)',WL))';


% Interpolate values for light

% Illuminant-D65
light_spectra_D65 = interp1(Illuminant_D65.data(:,1),Illuminant_D65.data(:,2),WL);

% Illuminant-A
light_spectra_A = interp1(Illuminant_A.data(:,1),Illuminant_A.data(:,2),WL);

% Both illuminants D-65 and A.
light_spectra = [light_spectra_D65; light_spectra_A];




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculate radiance for the ColorChecker %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This calculation is for a given illuminant and a given camera!!!
% for illuminant-D65 use: light_spectra(1,:).
% for illuminant-A use: light_spectra(2,:).
rgb = getradiance(refl_spectra, light_spectra(1,:), cam.data(:,2:end));

% Visualize the resulting colors
mcc = visualizeColorChecker(mat2gray(rgb));

% figure;imshow(mcc)
% This line saves the figure
% saveas(gcf,'data/Macbeth_no_wb.png');

% Select an achromatic (gray) patch with which to white balance.
% Let's pick the 23rd gray, with 9% reflectance but experiment with
% different patches!
wbpatch = rgb(23,:); 

% perform simple white balancing 
rgb_wb = 0.09*rgb./repmat(wbpatch,[size(rgb,1),1]);

% Visualize the resulting colors
mcc_wb = visualizeColorChecker(rgb_wb);

% Display and save the resulting image
figure;
montage({mcc, mcc_wb}, 'BorderSize', [0 20], 'BackgroundColor', [0.9 0.9 0.9])



%% Saving the figures:
% This line saves the figure, change the image name as you see fit

% Remember to change name when changing illuminant !!!!

save_path = 'change_to_your_path';
saveas(gcf, fullfile(save_path, 'Macbeth_sim.png'));
fprintf('Figure saved to %s\n', fullfile(save_path, 'Macbeth_sim.png'));

 


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  Include In Your Report - Exercise 3  %%%

% You should end up with 4 figures of combinations of Illuminant A and D65
% as well as the Nikon and Canon camera.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%        Simulated Nikon images         %%%
%
%   Illuminant A:
%                1. White Balanced image
%                2. Not white balanced image
%
%   Illuminant D65:
%                3. White Balanced image
%                4. Not white balanced image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%        Simulated Cannon images        %%%
%
%   Illuminant A:
%                1. White Balanced image
%                2. Not white balanced image
%
%   Illuminant D65:
%                3. White Balanced image
%                4. Not white balanced image


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%