clear; close all;
figure; hold on;

% Graph setting
Limit = [0 25];
grid on;
xlim(Limit); ylim(Limit);
set(gca, 'xtick', Limit(1):1:Limit(2))
set(gca, 'ytick', Limit(1):1:Limit(2))
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlabel('x1'); ylabel('x2');

% Samples
Norm_set = [[2 6];[22 20];[10 14];[10 10]; ...
            [24 24];[8 10];[8 8];[6 10];[8 12];...
            [6 12]];
ANorm_set = [[4 10];[24 16];[16 18];[18 20]; ...
            [14 20];[20 22];[18 16];[20 20];[18 18];...
            [20 18]];
        
% Draw points        
scatter(Norm_set(:, 1), Norm_set(:, 2), 45, ...
        'MarkerEdgeColor', 'blue', ...
        'MarkerFaceColor', 'blue');
scatter(ANorm_set(:, 1), ANorm_set(:, 2), 45, ...
        'MarkerEdgeColor', 'red', ...
        'MarkerFaceColor', 'red');
        
fplot(@(x)-2*(x-20), Limit);     % x2 = -2 * (x1 - 20)

scatter(4, 10, 330, ...
        'MarkerEdgeColor', 'blue', ...
        'MarkerFaceColor', 'none');
scatter([22 24], [20 24], 330, ...
        'MarkerEdgeColor', 'red', ...
        'MarkerFaceColor', 'none');
    
    