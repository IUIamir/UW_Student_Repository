function Kdz = KdVz(filtered_Light_profile, filtered_depth, wl, poly_deg)

% KDvz Compute depth-resolved Kd and visualize 
% as a depth-wavelength surface
%
%   X axis: Depth [m]
%   Y axis: Wavelength [nm]
%   Z axis: Attenuation Kd [m^-1]

Nz  = round(max(filtered_depth)) - 1;
Nwl = numel(wl);

Kdz = nan(Nwl, Nz);  % [wavelength x depth]

% Compute Kd(z) 
for i = 1:Nz
    Kd_from_COPS = Estimate_Kd_without_plots( ...
        filtered_Light_profile, filtered_depth, i, wl, poly_deg);
    Kdz(:, i) = Kd_from_COPS(:);
end

depths_of_Kd = 1:Nz;

% Create grid for plotting:
%    X: depth replicated over wavelengths
%    Y: wavelength replicated over depths
[X, Y] = meshgrid(depths_of_Kd, wl);

% 3D surface plot 
figure
surf(X, Y, Kdz, 'EdgeColor', 'none');  % smooth surface
xlabel('Depth [m]', 'Interpreter', 'latex', 'FontSize', 20)
ylabel('Wavelength [nm]', 'Interpreter', 'latex', 'FontSize', 20)
zlabel('$K_d(z, \lambda)$ $[m^{-1}]$', 'Interpreter', 'latex', 'FontSize', 20)
set(gca, 'LineWidth', 2, 'Color', 'w', 'FontSize', 15)
zlim([0, inf])
set(gcf, 'Color', 'w')
view(45, 30)  % 3D view
grid on

% Optional: top-down heatmap view (comment out if not needed) 
figure
imagesc(depths_of_Kd, wl, Kdz);  % x = depth, y = wl, color = Kd
set(gca, 'YDir', 'normal')       % make wavelength increase upward
xlabel('Depth [m]', 'Interpreter', 'latex', 'FontSize', 20)
ylabel('Wavelength [nm]', 'Interpreter', 'latex', 'FontSize', 20)
title('$K_d(\lambda, z)$', 'Interpreter', 'latex', 'FontSize', 20)
set(gca, 'LineWidth', 2, 'Color', 'w')
set(gcf, 'Color', 'w')
colorbar
axis tight

end
