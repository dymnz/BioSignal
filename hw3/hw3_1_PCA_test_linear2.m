clear; close all;

%Signal specification
age_limit = [10 30];
calorie_limit = [15 25];
N = 500;
gaussian_var = 0; 

% Generation
p_age = unifrnd(age_limit(1), age_limit(2), 1, N);
p_calorie = unifrnd(calorie_limit(1), calorie_limit(2), 1, N);

height_mean = 4 * p_age + 1 * p_calorie;
p_height = normrnd(height_mean, gaussian_var, size(p_age));

weight_mean = 1 * p_age + 2 * p_calorie;
p_weight = normrnd(weight_mean, gaussian_var, size(p_age));

% The equivalent mixing matrix
A = [4 0.01; 
     1 0.02];

% Cat
source = [p_height;p_weight];

% Centering
centered_source = source - (mean(source')')*ones(1, size(source, 2));

% Variance normalization
variance = (sqrt(var(centered_source'))') * ones(1, size(source, 2));
centered_norm_source = centered_source ./ variance;

% Correlation
Cov = centered_norm_source * centered_norm_source';

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

% Plot processed mixed
scatter(centered_norm_source(1,:), centered_norm_source(2,:));
hold on;
plotv(W,'-');


