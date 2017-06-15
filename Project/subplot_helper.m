function subplot_helper(X, Y, D, Label)
subplot(D(1), D(2), D(3));
plot(X, Y);
xlabel(Label(1));
ylabel(Label(2));
title(Label(3));
% y-axis scaling
h = findobj(gca,'Type','line');
ydata = get(h, 'Ydata');
if iscell(ydata)
    cat_ydata = ydata{1, :};
    for i = 2: size(ydata, 1)
        cat_ydata = [cat_ydata ydata{i, :}];
    end
    ydata = cat_ydata;
end
ylim([min(ydata) max(ydata)]);