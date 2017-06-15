figure;
plot(mv_t1_ecg)
hold on;
d_mv_t1_ecg = [mv_t1_ecg; 0] - [0; mv_t1_ecg];
d_mv_t1_ecg(d_mv_t1_ecg~=1) = 0;

a = ones(70, 1);
plot(conv(d_mv_t1_ecg, a), 'o')
