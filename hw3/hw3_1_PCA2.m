clear; close all;

% Signal specification
p1_limit = [1500 2500];
p2_limit = [10 30];
N = 1000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

% Mixing
source = [p1;p2];
A = [0.04 0.03;
     2 1];
mixed = A' * source;

% PCA
[processed_source, W, E] = PCA(mixed, false);


% Plot transformed
figure; 
processed_source = W' * mixed;
equal_plot(processed_source);
title('Transformed signal: false', 'FontSize', 20); 

% PCA
[processed_source, W, E] = PCA(mixed, true);

% Plot transformed
figure; 
processed_source = W' * processed_source;
equal_plot(processed_source);
title('Transformed signal: true', 'FontSize', 20); 