clear; close all;
addpath('./FastICA_21');

% Signal specification
p1_limit = [10 80];
p2_limit = [700 1000];
N = 1000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

% Plot original signal
scatter(p1, p2);

% Mixing
source = [p1;p2];
A = [0.8 0.3;
     0.6 0.3];
mixed = A * source;

% ICA
[icasig] = fastica(mixed);

close all;

figure;
% Plot mixed
scatter(icasig(1,:), icasig(2,:));
hold on;


