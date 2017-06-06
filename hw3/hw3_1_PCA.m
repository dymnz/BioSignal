clear; close all;

% Signal specification
p1_limit = [10 40];
p2_limit = [100 180];
N = 1000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

% Plot original signal
scatter(p1, p2);

% Mixing
source = [p1;p2];
A = [0.8 0.2;
     0.6 0.4];
mixed = A * source;

% Plot mixed
scatter(mixed(1,:), mixed(2,:));

% PCA
[transformed, V, D] = PCA(mixed);

% Plot transformed
scatter(transformed(1,:), transformed(2,:));
