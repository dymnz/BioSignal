clear; close all;

%Signal specification
age_limit = [10 30];
calorie_limit = [1500 2500];
N = 5000;
gaussian_var = 0; 

% Generation
p_age = unifrnd(age_limit(1), age_limit(2), 1, N);
p_calorie = unifrnd(calorie_limit(1), calorie_limit(2), 1, N);

height_mean = 4 * p_age + 0.01 * p_calorie;
p_height = normrnd(height_mean, gaussian_var, size(p_age));

weight_mean = 1 * p_age + 0.02 * p_calorie;
p_weight = normrnd(weight_mean, gaussian_var, size(p_age));

% The equivalent mixing matrix
A = [4 0.01; 
     1 0.02];

%% Plot original signal
figure;
scatter(p_age, p_height);
hold on;
scatter(p_age, p_weight);

%% Plot original signal
close all;
figure;
scatter(p_height, p_weight);

% PCA
[transformed, V, D] = PCA([p_height;p_weight]);

% Plot transformed
scatter(transformed(1,:), transformed(2,:));



