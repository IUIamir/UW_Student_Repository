function plot_uw_light_profile(Light_profile, filtered_depth)
n = 19;
colors = hsv(n);
figure
hold on
for plot_idx = 1:19
    plot(Light_profile(:,plot_idx), filtered_depth, ...
         'LineWidth', 2, ...
         'Color', colors(plot_idx,:))
end
ylabel('Depth [m]', 'Interpreter', 'latex', 'FontSize', 20)
xlabel('$\ln \big(\frac{E_0}{E_d} \big)$', 'Interpreter', 'latex', 'FontSize', 20)
set(gca,'YDir','reverse','LineWidth',2.5)
set(gca,'Color','w')
f = gcf;
set(f,'InvertHardcopy','off')
set(f,'Units','normalized')
set(f,'OuterPosition',[0 0 1 1])
axis square
set(gcf,'Color','w')

end