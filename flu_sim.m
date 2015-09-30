function [tt, y_i, y_d, y_c] = flu_sim(T_y, p_y, f_y, c_y, init_y, lookback, compound, time)

if nargin < 5
    init_y = 10;
end
if nargin < 6
    lookback = 4;
end
if nargin < 7
    compound = 4;
end
if nargin < 8
    time = 150;
end

delta_time = 1/compound; % compound once a day
tt = delta_time * (0:compound*time);

y_i = [0;init_y];
y_d = [0;0];
y_c = [0;0];

for t=tt(3:end)
    infected = y_i(end);
    if t-lookback*compound <= 0
        contagious = y_i(end);
    else
        contagious = y_i(end) - y_i(end-lookback*compound);
    end
    dead = y_d(end);
    cured = y_c(end);
    pop = [ones(infected, 1); zeros(T_y-infected-dead, 1)];
    for n=1:infected
        iscured = rand() < c_y/compound;
        pop(n) = pop(n) && ~iscured;
        if iscured
            cured = cured + 1;
        end
    end
    for n=1:contagious % INFECT MORE
        pop = or(pop, rand(T_y-dead, 1) < (p_y/(T_y-dead)/compound));
    end
    for n=1:infected
        isdead = rand() < f_y/compound;
        pop(n) = pop(n) && ~isdead;
        if isdead
            dead = dead + 1;
        end
    end
    y_i = [y_i; sum(pop)];
    y_d = [y_d; dead];
    y_c = [y_c; cured];
    y_i(end);
end

