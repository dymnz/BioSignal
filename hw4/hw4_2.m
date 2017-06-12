clear; close all;
figure; hold on;

% Graph setting
Limit = [0 10];
grid on;
xlim(Limit); ylim(Limit);
set(gca, 'xtick', Limit(1):1:Limit(2))
set(gca, 'ytick', Limit(1):1:Limit(2))
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

% Samples

z1 = [3; 4];
z2 = [10; 2];
x = [4; 5];

plotv([3; 4]);
plotv([10; 2]);
plotv([4; 5]);

d1 = norm(x-z1)
d2 = norm(x-z2)


