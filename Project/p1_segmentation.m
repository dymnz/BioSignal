
clear; close all;

%% Settings
% Parameter
fileIndex = 1;      % Choose a file (1...4)
range = [6.5 12.5]; % Interval of signals to test (sec)
win_t = 330;        % Systolic(S1) window (m-sec)

%% Get started
% Stuff to specify
fNames = {'pec1.dat' 'pec52.dat' 'pec33.dat' 'pec42.dat'};
sig = load(['./data/' fNames{fileIndex}]);
fs = 1000;
limit = (range(1)*fs):(range(2)*fs);   % Using only mid-section signal

% Separating pcg, ecg, and carotid signals
pcg = sig(limit, 1);
ecg = sig(limit, 2);
carotid = sig(limit, 3);
time = [limit]/fs;

%% Preprocessing 

% Orignal
figure;
subplot_helper(time, ecg, [4 1 1], ...
                {'Time (s)' 'ECG (AU)' 'Original ECG'});
                       
% Low-pass
signal = ecg; order = 8; fc = 90;
[f_ecg, cb, ca] = butter_filter(signal, order, fc, fs);
subplot_helper(time, f_ecg, [4 1 2], ...
                {'Time (s)' 'ECG (AU)' 'ECG Low-passed'})

% Downsample        
fs_d = 200;
d_f_ecg = downsample(f_ecg, fs/fs_d);
d_time = [downsample(time, fs/fs_d)];
subplot_helper(d_time, d_f_ecg, [4 1 3], ...
                {'Time (s)' 'ECG (AU)' 'ECG Downsampled'})

% Normalization
n_d_f_ecg = d_f_ecg / max(d_f_ecg);
subplot_helper(d_time, n_d_f_ecg, [4 1 4], ...
                {'Time (s)' 'ECG (AU)' 'ECG Normalized'})
            
%% QRS processing

% Orignal
figure;
subplot_helper(d_time, n_d_f_ecg, [4 1 1], ...
                {'Time (s)' 'ECG (AU)' 'ECG Normalized'});

% First derivative
d1_ecg = abs([n_d_f_ecg; 0; 0;] ...
            - [0; 0; n_d_f_ecg]);
d1_ecg = d1_ecg(3:end);             % Remove the leading zeros
subplot_helper(d_time, d1_ecg, [4 1 2], ...
                {'Time (s)' 'Magnitude (AU)' 'ECG 1st derivative'})
            
% Second derivative
d2_ecg = abs([n_d_f_ecg; 0; 0; 0; 0;] ...
            - 2*[0; 0; n_d_f_ecg; 0; 0;] ...
            + [0; 0; 0; 0; n_d_f_ecg]);   
d2_ecg = d2_ecg(5:end);             % Remove the leading zeros
subplot_helper(d_time, d2_ecg, [4 1 3], ...
                {'Time (s)' 'Magnitude (AU)' 'ECG 2nd derivative'}) 
            
% Weighted derivative
w_ecg = 1.3 * d1_ecg + 1.1 * d2_ecg;
subplot_helper(d_time, w_ecg, [4 1 4], ...
                {'Time (s)' 'Magnitude (AU)' 'ECG Weighted derivative'})   
           
            
%% QRS detection

% Orignal
figure;
subplot_helper(d_time, w_ecg, [4 1 1], ...
                {'Time (s)' 'Magnitude (AU)' 'ECG Weighted derivative'});
            
% Threshold on original
Threshold = 1;
t1_ecg = ones(size(w_ecg));
t1_ecg(w_ecg<Threshold) = 0;
subplot_helper(d_time, t1_ecg, [4 1 2], ...
                {'Time (s)' 'Magnitude (AU)' 'Weighted derivative 1.0 thresholding'});  
            
% Moving average
pt = 8;
mv_w_ecg = movmean(w_ecg, pt);
subplot_helper(d_time, mv_w_ecg, [4 1 3], ...
                {'Time (s)' 'Magnitude (AU)' 'Weighted derivative 8pt MA'});   

% Threshold on moving averaged
mv_t1_ecg = ones(size(w_ecg));
mv_t1_ecg(mv_w_ecg<Threshold) = 0;
subplot_helper(d_time, mv_t1_ecg, [4 1 4], ...
                {'Time (s)' 'Magnitude (AU)' 'Weighted derivative 8pt MA 1.0 thresholding'});  
         
            
%% Overlay

% ECG overlay
figure;
subplot_helper(time, ecg, [4 1 1], ...
                {'Time (s)' 'ECG (AU)' 'ECG QRS overlay'});
hold on;
t_ecg = (mv_t1_ecg) * (max(ecg)-min(ecg)) + min(ecg) ;
subplot_helper(d_time, t_ecg, [4 1 1], ...
                {'Time (s)' 'ECG (AU)' 'ECG QRS overlay'});  
           
% PCG overlay
subplot_helper(time, pcg, [4 1 2], ...
                {'Time (s)' 'PCG (AU)' 'PCG QRS overlay'});
hold on;
t_pcg = (mv_t1_ecg) * (max(pcg)-min(pcg)) + min(pcg) ;
subplot_helper(d_time, t_pcg, [4 1 2], ...
                {'Time (s)' 'PCG (AU)' 'PCG QRS overlay'});     

% Window extension calculation
win_pts = round(win_t / (1000/fs_d));
d_mv_t1_ecg = [mv_t1_ecg; 0] - [0; mv_t1_ecg];
d_mv_t1_ecg(d_mv_t1_ecg~=1) = 0;

extension = conv(d_mv_t1_ecg, ones(win_pts, 1));
            
% ECG overlay - window extension
subplot_helper(time, ecg, [4 1 3], ...
                {'Time (s)' 'ECG (AU)' 'ECG windowing'});
hold on;
t_ecg = extension(1:length(mv_t1_ecg));
t_ecg = (t_ecg) * (max(ecg)-min(ecg)) + min(ecg) ;
subplot_helper(d_time, t_ecg, [4 1 3], ...
                {'Time (s)' 'ECG (AU)' sprintf('ECG windowing %d ms', win_t)});                                    
% PCG overlay - window extension
subplot_helper(time, pcg, [4 1 4], ...
                {'Time (s)' 'PCG (AU)' 'PCG windowing'});
hold on;
t_pcg = extension(1:length(mv_t1_ecg));
t_pcg = (t_pcg) * (max(pcg)-min(pcg)) + min(pcg) ;
subplot_helper(d_time, t_pcg, [4 1 4], ...
                {'Time (s)' 'PCG (AU)' sprintf('PCG windowing %d ms', win_t)});                 
                     