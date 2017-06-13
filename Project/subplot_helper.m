function subplot_helper(X, Y, D, Label)
subplot(D(1), D(2), D(3));
plot(X, Y);
xlabel(Label(1));
ylabel(Label(2));
ylim([min(Y) max(Y)]);