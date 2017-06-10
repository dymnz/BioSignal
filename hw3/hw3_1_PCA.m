clear; close all;

% Signal specification
p1_limit = [10 80];
p2_limit = [700 900];
N = 1000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

figure;
% Plot original signal
scatter(p1, p2);

% Mixing
source = [p1;p2];
A = [0.8 0.3;
     0.6 0.3];
mixed = A * source;

% PCA
[processed_source, W, E] = PCA(mixed);

figure;
% Plot PC
scatter(processed_source(1,:), processed_source(2,:));
hold on;
plotv(W,'-');

figure;
% Plot transformed
processed_source = inv(W) * processed_source;
scatter(processed_source(1,:), processed_source(2,:));
hold on;
plotv(1.*eye(2, 2),'-');





