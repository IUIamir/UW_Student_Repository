clear all; close all; clc;
Sample_Dataset = importdata("Lab5\Datasets\UWC_morning_cruise_CAST_003_260115_090944_URC.csv");
wl = 400:10:700;
depth_start_for_eval = 1;
depth_end_for_eval = 80;

depth_for_evaluating_Kd = 5;
poly_deg = 18;
Deg_filter = 5;

[filtered_depth, filtered_Light_profile] = LightFiltrFunc(Sample_Dataset.data, depth_start_for_eval,depth_end_for_eval, Deg_filter);
plot_uw_light_profile(filtered_Light_profile, filtered_depth)

%%
close all; clc;
Kd_from_COPS = Estimate_Kd(filtered_Light_profile, filtered_depth, depth_for_evaluating_Kd, wl, poly_deg);
KdVz(filtered_Light_profile, filtered_depth, wl, poly_deg);