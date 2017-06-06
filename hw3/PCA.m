function [transformed, V, D] = PCA(source)
%% PCA

% Centering
centered_mixed = source - (mean(source')')*ones(1, size(source, 2));

% Plot centered mixed
scatter(centered_mixed(1,:), centered_mixed(2,:));

% Covariance
Cov = centered_mixed*centered_mixed';

% Eigen
[V, D] = eig(Cov);

% Transform
transformed = V * centered_mixed;