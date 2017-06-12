function plot_line(x1, x2, color)
t = (x2(2)-x1(2))/(x2(1)-x1(1));
if isinf(t)
    limit = [min(x1(2), x2(2)) max(x1(2), x2(2))];
    fplot(@(x)x1(1), @(y)y, limit, 'Color', color);
else
    b = x1(2) - t*x1(1);
    limit = [min(x1(1), x2(1)) max(x1(1), x2(1))];
    fplot(@(x)t*x + b, limit, 'Color', color);
end
