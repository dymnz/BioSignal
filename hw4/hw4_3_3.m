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
Test_set = [[12 15]; [14 15]];
        
% Draw points        
scatter(Norm_set(:, 1), Norm_set(:, 2), 45, ...
        'MarkerEdgeColor', 'blue', ...
        'MarkerFaceColor', 'blue');
scatter(ANorm_set(:, 1), ANorm_set(:, 2), 45, ...
        'MarkerEdgeColor', 'red', ...
        'MarkerFaceColor', 'red');
scatter(Test_set(:, 1), Test_set(:, 2), 45, ...
        'MarkerEdgeColor', 'green', ...
        'MarkerFaceColor', 'green');  
    
% KNN 
Neighbor = 7;
Data_set = [Norm_set; ANorm_set];
Data_label = [ones(size(Norm_set, 1), 1); ...
                2*ones(size(ANorm_set, 1), 1)];

Nt = size(Test_set, 1);
Nd = size(Data_set, 1);
colors = 'rb';
for i = 1 : Nt
    d = (Test_set(i, :) - Data_set);
    diff = sqrt(diag(d*d')');   % This is stupid
    [B I] = sort(diff);
%     Data_label(I(1:Neighbor))
    for r = 1 : Neighbor
        disp(r)
        disp(Data_set(I(r), :))
        plot_line(Test_set(i, :), Data_set(I(r), :), colors(i));
    end
end

fplot(@(x)-2*(x-20), Limit);     % x2 = -2 * (x1 - 20)

