clear; close all;

% Signal specification
p1_limit = [10 80];
p2_limit = [1210 1280];
N = 1000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

% Plot original signal
scatter(p1, p2);

% Mixing
source = [p1;p2];
A = [0.8 0.6;
     0.6 0.8];
mixed = A' * source;

% Plot mixed
scatter(mixed(1,:), mixed(2,:));

% PCA
[processed_source, W, E] = PCA(mixed, false);

% Transform
processed_source = W * processed_source;

% Plot transformed
scatter(processed_source(1,:), processed_source(2,:));
hold on;

% Print stuff
fprintf('source var.: %.2f %.2f\n', ...
        var(source(1, :)), var(source(2, :)));
fprintf('mixed var.: %.2f %.2f\n', ...
        var(mixed(1, :)), var(mixed(2, :)));
fprintf('transformed var.: %.5f %.5f\n', ...
        var(processed_source(1, :)), var(processed_source(2, :)));    
