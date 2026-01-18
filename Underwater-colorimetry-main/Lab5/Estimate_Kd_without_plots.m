function Kd = Estimate_Kd_without_plots(filtered_light_profile, filtered_depth, Evaluation_depth, wl, poly_deg)
COPS_wl = [313, 330, 340, 380, 395, 412, 443, 465, 490, 510, 532, 555, ...
    565, 589, 625, 665, 683, 710, 765];

z = filtered_depth';
EvalDepth = find(round(filtered_depth) == Evaluation_depth, 1);
EvalDepth = z(EvalDepth);
vQnoisy = filtered_light_profile';
vKd2  = zeros(19, 1);

for i = 1:19
    pQ = polyfit(z, vQnoisy(i,:), poly_deg);
    vQ = polyval(pQ, z);
    pKd = -polyder(pQ);
    vKd2(i) = polyval(pKd, EvalDepth);
end

Kd = -vKd2;
Kd = interp1(COPS_wl, Kd, wl)';

end