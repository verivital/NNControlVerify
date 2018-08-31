%This function is to plot the inf norm centered at x with radius 
function squareplot(x,color,fillType)
x1=x.min(1);
x2=x.max(1);
y1=x.min(2);
y2=x.max(2);
if strcmp(fillType, 'empty')
    x = [x1, x2, x2, x1, x1];
    y = [y1, y1, y2, y2, y1];
    plot(x, y, 'b-', 'LineWidth', 1);
    hold on;
elseif strcmp(fillType, 'full')
    x = [x1, x2, x2, x1];
    y = [y1, y1, y2, y2];
    fill(x,y,color,'edgecolor','none');
    hold on
end