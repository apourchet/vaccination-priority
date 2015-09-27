K = 6000;
K_y = 3600;
K_e = 360;
V = 400;

i_y = 1;
i_e = 2;
d_y = 4;
d_e = 1;

p_y = 1;
f_y = 0.001;
c_y = 0.1;

p_e = 0.1;
f_e = 0.1;
c_e = 0.05;

f = figure; hold on;
for alpha=0:.2:1
    T_y = K_y - V*alpha;
    T_e = K_e - V*(1-alpha);

    [tt, y_i, y_d, y_c] = flu_sim(T_y, p_y, f_y, c_y, 4);
    plot(tt, y_i, 'r');
end
% plot(tt, y_d, 'black');
% plot(tt, y_c, 'g');
% saveas(f, './young_infec.png', 'png');

