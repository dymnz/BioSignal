clear; close all;

% Signal specification
p1_limit = [50 70];
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

% PCA
Coeff = pca(mixed', 'Algorithm','eig');

% Plot original signal
figure;
scatter(p1, p2);

% Plot transformed
figure;
processed_source = Coeff' * mixed; % (mixed' * Coeff')'
scatter(processed_source(1,:), processed_source(2,:));

% Print stuff
fprintf('source var.: %.2f %.2f\n', ...
        var(source(1, :)), var(source(2, :)));
fprintf('mixed var.: %.2f %.2f\n', ...
        var(mixed(1, :)), var(mixed(2, :)));
fprintf('transformed var.: %.5f %.5f\n', ...
        var(processed_source(1, :)), var(processed_source(2, :)));    




