% LightFiltrFunc filters a radiometric dataset based on sensor orientation 
% and computes a depth-dependent light attenuation profile.
%
% This function processes an input dataset containing depth, platform
% orientation (roll and pitch) at the surface (Ed0) and at depth (Edz),
% and corresponding spectral downwelling irradiance measurements.
% Samples are retained only when both surface and subsurface roll and
% pitch angles are within ±5 degrees, ensuring that the radiometric
% measurements are minimally affected by sensor tilt or platform motion.
%
% The function iterates through the dataset up to the maximum recorded
% depth and extracts valid depth values together with their associated
% spectral irradiance vectors at the surface (Ed0) and at depth (Edz).
% For each valid sample, the natural logarithm of the ratio Ed0 / Edz
% is computed, yielding a spectral light attenuation profile as a
% function of depth.
%
% This filtering and normalization step is critical for underwater
% optical analysis, as it removes geometrically distorted measurements
% and produces a physically meaningful quantity suitable for estimating
% diffuse attenuation coefficients or studying light propagation in
% water columns.
%
% Inputs:
%   unfiltered_dataset : NxM numeric array containing depth, orientation,
%                        and spectral irradiance measurements.
%
% Outputs:
%   filtered_depth     : Column vector of depth values that pass
%                        the orientation quality criteria.
%   Light_profile      : Matrix of log(Ed0 ./ Edz) spectral attenuation
%                        values corresponding to filtered depths.
%
% Amir Hadad, 12.01.2026

function [filtered_depth, Light_profile] = LightFiltrFunc(unfiltered_dataset, start_depth_for_eval, stop_depth_for_eval, deg_filter)

depth = unfiltered_dataset(:,2);
Ed0_roll = unfiltered_dataset(:,3);
Ed0_pitch = unfiltered_dataset(:,4);
Edz_roll = unfiltered_dataset(:,5);
Edz_pitch = unfiltered_dataset(:,6);

[max_depth_val, max_depth_idx] = max(depth);
start_idx = find(round(depth) == start_depth_for_eval, 1);
end_idx = find(round(depth) == stop_depth_for_eval, 1);

clr_ind = 1;
for i = start_idx:end_idx
    if abs(Ed0_roll(i,1)) < deg_filter && abs(Ed0_pitch(i,1)) < deg_filter
        if abs(Edz_roll(i,1)) < deg_filter && abs(Edz_pitch(i,1)) < deg_filter
            filtered_depth(clr_ind,1) = depth(i,1);
            filtered_Ed0(clr_ind,1:19) = unfiltered_dataset(i,7:25);          
            filtered_Edz(clr_ind,1:19) = unfiltered_dataset(i,26:44);       
            clr_ind = clr_ind + 1;
        end
    end
end
Light_profile = log(filtered_Ed0./filtered_Edz);

end