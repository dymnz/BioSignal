clear; close all;
figure; hold on;

% Graph setting
Limit = [-10 10];
grid on;
xlim(Limit); ylim(Limit);
set(gca, 'xtick', Limit(1):1:Limit(2))
set(gca, 'ytick', Limit(1):1:Limit(2))
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

% Samples
Norm_set = [[2 6];[22 20];[10 14];[10 10]; ...
            [24 24];[8 10];[8 8];[6 10];[8 12];...
            [6 12]];
ANorm_set = [[4 10];[24 16];[16 18];[18 20]; ...
            [14 20];[20 22];[18 16];[20 20];[18 18];...
            [20 18]];
        
% Draw lines       
fplot(@(x)x, [-10 10]);     % x1 = x2
fplot(@(x)-x+5, [-10 10]);  % x1 = -x2+5
fplot(1, [-10 10]);         % x2 = 1

plot(6, 5, '-o');
        






