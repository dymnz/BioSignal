% QRS detection %
clear; close all;

%% Settings

% Parameter
sig = load('./data/pec41.dat');
fs = 1000;
limit = 4500:6000;   % Using only mid-section signal

% Separating pcg, ecg, and carotid signals
pcg = sig(limit, 1);
ecg = sig(limit, 2);
carotid = sig(limit, 3);
time = [limit]/fs;

%% Preprocessing 

% Orignal
figure;
subplot_helper(time, ecg, [4 1 1], ...
                {'Time in seconds' 'Original'});
                       
% Low-pass
signal = ecg; order = 8; fc = 90;
[f_ecg, cb, ca] = butter_filter(signal, order, fc, fs);
subplot_helper(time, f_ecg, [4 1 2], ...
                {'Time in seconds' 'Low-passed'})

% Downsample        
fs_d = 200;
d_f_ecg = downsample(f_ecg, fs/fs_d);
d_time = [downsample(time, fs/fs_d)];
subplot_helper(d_time, d_f_ecg, [4 1 3], ...
                {'Time in seconds' 'Downsampled'})

% Normalization
n_d_f_ecg = d_f_ecg / max(d_f_ecg);
subplot_helper(d_time, n_d_f_ecg, [4 1 4], ...
                {'Time in seconds' 'Normalized'})

%% QRS processing

% Orignal
figure;
subplot_helper(d_time, n_d_f_ecg, [4 1 1], ...
                {'Time in seconds' 'Normalized'});

% First derivative
d1_ecg = abs([n_d_f_ecg; 0; 0;] ...
            - [0; 0; n_d_f_ecg]);
d1_ecg = d1_ecg(3:end);             % Remove the leading zeros
subplot_helper(d_time, d1_ecg, [4 1 2], ...
                {'Time in seconds' '1st drvtve'})
            
% Second derivative
d2_ecg = abs([n_d_f_ecg; 0; 0; 0; 0;] ...
            - 2*[0; 0; n_d_f_ecg; 0; 0;] ...
            + [0; 0; 0; 0; n_d_f_ecg]);   
d2_ecg = d2_ecg(5:end);             % Remove the leading zeros
subplot_helper(d_time, d2_ecg, [4 1 3], ...
                {'Time in seconds' '2nd drvtve'}) 
            
% Weighted derivative
w_ecg = 1.3 * d1_ecg + 1.1 * d2_ecg;
subplot_helper(d_time, w_ecg, [4 1 4], ...
                {'Time in seconds' 'Weighted drvtve'})   
            
%% QRS detection

% Orignal
figure;
subplot_helper(d_time, w_ecg, [4 1 1], ...
                {'Time in seconds' 'Weighted drvtve'});
            
% Threshold on original
Threshold = 1;
t1_ecg = ones(size(w_ecg));
t1_ecg(w_ecg<Threshold) = 0;
subplot_helper(d_time, t1_ecg, [4 1 2], ...
                {'Time in seconds' 'Naive threshold'});  
            
% Moving average
pt = 8;
mv_w_ecg = movmean(w_ecg, pt);
subplot_helper(d_time, mv_w_ecg, [4 1 3], ...
                {'Time in seconds' '8pt MA'});   

% Threshold on moving averaged ECG
mv_t1_ecg = ones(size(w_ecg));
mv_t1_ecg(mv_w_ecg<Threshold) = 0;
subplot_helper(d_time, mv_t1_ecg, [4 1 4], ...
                {'Time in seconds' '8pt MA threshold'});  

%% Overlay

figure;
subplot_helper(time, ecg, [4 1 1], ...
                {'Time in seconds' 'Original'});
hold on;
mv_t1_ecg = (mv_t1_ecg) * (max(ecg)-min(ecg)) + min(ecg) ;
subplot_helper(d_time, mv_t1_ecg, [4 1 1], ...
                {'Time in seconds' 'Original'});