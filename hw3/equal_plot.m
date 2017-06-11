function equal_plot(source)
scatter(source(1,:), source(2,:));
xlim([min(min(source(1,:))) max(max(source(1,:)))]);
ylim([min(min(source(2,:))) max(max(source(2,:)))]);
daspect([1 1 1])
