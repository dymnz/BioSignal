function [processed_source, W, E] = PCA(source, toNormalize)
%% PCA
if nargin < 2
toNormalize = true;
end

N = size(source, 2);

% Centering
processed_source = source - (mean(source')')*ones(1, N);

% Variance normalization
if toNormalize
    variance = (sqrt(var(processed_source'))') * ones(1, N);
    processed_source = processed_source ./ variance;
end

% Normalized variance
fprintf('normalized var.: %.2f %.2f\n', ...
        var(processed_source(1, :)), var(processed_source(2, :)));    

% Correlation
Cov = (processed_source * processed_source') ./ N;

% Eigen
[V, D] = eig(Cov);
[B I] = sort(sum(D), 'descend');

% Construct W
W = zeros(size(V));
E = zeros(size(D));
for i = 1 : size(V, 1)
    W(:, i) = V(:, I(i));
    E(:, i) = D(:, I(i));
end


