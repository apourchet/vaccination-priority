K = 6000;
K_y = 3600;
K_e = 600;
V = 400;

i_y = 1;
i_e = 2;
d_y = 10;
d_e = 3;

p_y = 1;    % Supposed to be closer to 1.88
f_y = 0.01;
c_y = .05;

p_e = 0.5;
f_e = 0.1;
c_e = 0.025;

f = figure; hold on;

alpha = 1.0;

T_y = K_y - V*alpha;
T_e = K_e - V*(1-alpha);

s_d = zeros(601,1); % Should be time*compound+1
s_i = zeros(601,1);
for t=0:10
    [tt, e_i, e_d, e_c] = flu_sim(T_e, p_e, f_e, c_e);
    s_d = s_d + e_d;
    s_i = s_i + e_i;
    plot(tt, e_i, 'r');
    plot(tt, e_d, 'black');
    %plot(tt, e_c, 'g');
end
mean_i = s_i/11;
mean_d = s_d/11;
plot(tt, mean_i, 'b');
plot(tt, mean_d, 'b');


f2 = figure; hold on;
s_d = zeros(601,1);
s_i = zeros(601,1);
for t=0:10
    [tt, y_i, y_d, y_c] = flu_sim(T_y, p_y, f_y, c_y);
    s_d = s_d + y_d;
    s_i = s_i + y_i;
    plot(tt, y_i, 'r');
    plot(tt, y_d, 'black');
    %plot(tt, y_c, 'g');
end
mean_i2 = s_i/11;
mean_d2 = s_d/11;
plot(tt, mean_i2, 'b');
plot(tt, mean_d2, 'b');

elderlyill = max(mean_i)
elderlydead = mean_d(end)
youngill = max(mean_i2)
youngdead = mean_d2(end)
    
cost = i_e*elderlyill + d_e*elderlydead + i_y*youngill + d_y*youngdead
% saveas(f, './young_infec.png', 'png');

