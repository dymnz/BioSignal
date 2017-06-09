clear; close all;
figure; hold on;

% (x1, x2)
fplot(@(x)x, [-10 10]); % x1 = x2
fplot(@(x)-x+5, [-10 10]);  % x1 = -x2+5
fplot(1, [-10 10]); % x2 = 1

plot(6, 5, '-o');

grid on;
xlim([-10 10]); ylim([-10 10]);
set(gca,'xtick',[-10:1:10])
set(gca,'ytick',[-10:1:10])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

