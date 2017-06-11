clear; close all;
addpath('./FastICA_21');

% Signal specification
p1_limit = [-80 80];
p2_limit = [-10 10];
N = 1000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

% Mixing
source = [p1;p2];
A = [0.8 0.3;
     0.6 0.4];
mixed = A' * source;

% ICA
[icasig] = fastica(mixed);
close all;

figure;
% Plot original signal
scatter(p1, p2);

figure;
% Plot mixed
scatter(mixed(1,:), mixed(2,:));

% Histogram source/mixed
figure; 
histogram(source(1, :), 30); 
hold on;
histogram(source(2, :), 30);
figure; 
histogram(mixed(1, :), 30); 
hold on;
histogram(mixed(2, :), 30);


figure;
% Plot ICA
scatter(icasig(1,:), icasig(2,:));


% Print stuff
fprintf('source var.: %.2f %.2f\n', ...
        var(source(1, :)), var(source(2, :)));
fprintf('mixed var.: %.2f %.2f\n', ...
        var(mixed(1, :)), var(mixed(2, :)));
fprintf('ICA var.: %.5f %.5f\n', ...
        var(icasig(1, :)), var(icasig(2, :)));    



