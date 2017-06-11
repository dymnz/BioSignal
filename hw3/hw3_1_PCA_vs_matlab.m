clear; close all;

% Signal specification
p1_limit = [- 40 40];
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

% Plot original signal
figure;
scatter(p1, p2);

xlim([min(min(source)) max(max(source))]);
ylim([min(min(source)) max(max(source))]);
daspect([1 1 1])

% Plot mixed
figure;
scatter(mixed(1, :), mixed(2, :));

xlim([min(min(mixed)) max(max(mixed))]);
ylim([min(min(mixed)) max(max(mixed))]);
daspect([1 1 1])



% PCA
Coeff = pca(mixed', 'Algorithm','eig');

% Plot transformed
figure;
processed_source = Coeff' * mixed; % (mixed' * Coeff')'
scatter(processed_source(1,:), processed_source(2,:));
hold on;

% Print stuff
fprintf('source var.: %.2f %.2f\n', ...
        var(source(1, :)), var(source(2, :)));
fprintf('mixed var.: %.2f %.2f\n', ...
        var(mixed(1, :)), var(mixed(2, :)));
fprintf('transformed var.: %.5f %.5f\n', ...
        var(processed_source(1, :)), var(processed_source(2, :)));    

% PCA
[processed_source, W, E] = PCA(mixed, false);

% Plot transformed
processed_source = W' * processed_source;
scatter(processed_source(1,:), processed_source(2,:));

% Print stuff
fprintf('source var.: %.2f %.2f\n', ...
        var(source(1, :)), var(source(2, :)));
fprintf('mixed var.: %.2f %.2f\n', ...
        var(mixed(1, :)), var(mixed(2, :)));
fprintf('transformed var.: %.5f %.5f\n', ...
        var(processed_source(1, :)), var(processed_source(2, :)));    

xlim([min(min(processed_source)) max(max(processed_source))]);
ylim([min(min(processed_source)) max(max(processed_source))]);
daspect([1 1 1])
