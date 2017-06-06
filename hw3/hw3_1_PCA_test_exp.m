clear; close all;

%Signal specification
age_limit = [10 30];
N = 5000;
gaussian_var = 10; 

% Generation
p_age = unifrnd(age_limit(1), age_limit(2), 1, N);
height_mean = 100 + 75*( 1 - exp(-(p_age-age_limit(1))/(0.2*(age_limit(2)-age_limit(1)))) );
p_height = normrnd(height_mean, gaussian_var, size(p_age));



% Plot original signal
figure;
scatter(p_age, p_height);



