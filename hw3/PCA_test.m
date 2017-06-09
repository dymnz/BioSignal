%% PCA
clear; close all;

% Signal specification
p1_limit = [10 40];
p2_limit = [10 18];
N = 10000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

% Plot original signal
scatter(p1, p2);

% Mixing
source = [p1;p2];
A = [0.8 0.7;
     0.3 0.4];
mixed = A * source;

% Centering
centered_mixed = mixed - (mean(mixed')')*ones(1, size(mixed, 2));

% Variance normalization
centered_mixed = centered_mixed./((sqrt(var(centered_mixed'))')*ones(1, size(source, 2)));

% Covariance
Cov = centered_mixed*centered_mixed';

% Eigen
[V, D] = eig(Cov);
[B I] = sort(sum(D), 'descend');

% Construct W
W = zeros(size(V));
for i = 1 : size(V, 1)
    W(:, i) = V(:, I(i));
end

% Plot processed mixed
scatter(centered_mixed(1,:), centered_mixed(2,:));
hold on;
plotv(W,'-')
