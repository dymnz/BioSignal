% Biosignal hw1: SA node vs. Ectopic focus

% An ectopic pacemaker or ectopic focus is an excitable group of cells that 
% causes a premature heart beat outside the normally functioning SA node of 
% the heart.

% Many parts of the heart possess inherent rhythmicity and pacemaker properties;
% for example, theSA node, the AV node, the Purkinje fibers, atrial tissue, 
% and ventricular tissue. If the SA node is depressed or inactive, anyone 
% of the above tissues may take over the roleof the pacemaker or introduce 
% ectopic beats.

% Time scaled to 100 = 1s
sa_beat = [0:100:900] + 1;
ectopic = [130, 280, 608, 725] + 1;

beat = -ones(1, 1000);
beat(sa_beat) = 1;
sa_beat = beat;

beat = -ones(1, 1000);
beat(ectopic) = 1;
ectopic = beat;

time_scale = [0:0.01:9.99];
figure;
plot(time_scale, sa_beat, '-o');
hold on;
plot(time_scale, ectopic, '-o');

legend('SA node','ectopic focus')
ylim([0 2])
xlabel('second')
