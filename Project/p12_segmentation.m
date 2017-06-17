% The entry point of the term project, includes preprocessing and ECG/PCG 
% segmentation
clear; close all;

%% Settings
% Parameter
fileIndex = 5;      % Choose a file (1...5)
range = [3 15.5];	% Interval of signals to test (sec)
win_ts = [330 380 290 200 320]; % Systolic(S1) window (m-sec)
win_t = win_ts(fileIndex); 

%% Get started
% Stuff to specify
fNames = {'pec1.dat' 'pec52.dat' 'pec33.dat' 'pec42.dat' 'pec41.dat'};
sig = load(['./data/' fNames{fileIndex}]);
fs = 1000;
limit = (range(1)*fs):min(size(sig,1),(range(2)*fs));   % Using only mid-section signal

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
            
% Weighted derpcg_fftsivative
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

% Window extension calculation, brilliant
win_pts = round(win_t / (1000/fs));
segment_starts = [mv_t1_ecg; 0] - [0; mv_t1_ecg];   % Find the starting location of each segment
segment_starts(segment_starts~=1) = 0;              % Impulse train of segment starts
segment_starts = upsample(segment_starts, fs/fs_d); % Upsample to f = fs
segment_starts = segment_starts(1:length(time));    % Remove the extended part from upsampling
segment_windows = conv(segment_starts, ones(win_pts, 1));       % Convolution -> Copy & Paste
segment_windows = segment_windows(1:length(segment_starts));    % Remove the extended part from convolution          

% ECG overlay - window extension
subplot_helper(time, ecg, [4 1 3], ...
                {'Time (s)' 'ECG (AU)' 'ECG windowing'});
hold on;
t_ecg = (segment_windows) * (max(ecg)-min(ecg)) + min(ecg) ;
subplot_helper(time, t_ecg, [4 1 3], ...
                {'Time (s)' 'ECG (AU)' sprintf('ECG windowing %d ms', win_t)});                                    
            
% PCG overlay - window extension
subplot_helper(time, pcg, [4 1 4], ...
                {'Time (s)' 'PCG (AU)' 'PCG windowing'});
hold on;
t_pcg = (segment_windows) * (max(pcg)-min(pcg)) + min(pcg) ;
subplot_helper(time, t_pcg, [4 1 4], ...
                {'Time (s)' 'PCG (AU)' sprintf('PCG windowing %d ms', win_t)});                 
                     