function [Xd] = rangeDiscretize(xmin, xmax, numdx)
for i = 1:1:2
    step = (xmax-xmin)/numdx(i);
    xsequence{i} = xmin(i):step(i):xmax(i); %step(i) by XD
    if xmax(i) > xsequence{i}(end)
        xsequence{i} = [xsequence{i},xmax(i)];
    end
end
t = 1;
for m = 1:length(xsequence{1})-1
    for n = 1:length(xsequence{2})-1
        xmin_temp1 = xsequence{1}(m);
        xmin_temp2 = xsequence{2}(n);
        xmax_temp1 = xsequence{1}(m+1);
        xmax_temp2 = xsequence{2}(n+1);
        Xd{t} = Polyhedron([xmin_temp1, xmin_temp2; xmin_temp1, xmax_temp2;...
            xmax_temp1, xmin_temp2; xmax_temp1, xmax_temp2]);      
        t = t + 1;
    end
end
