function output = linearsysOutputSet(A,B,C,network,state,input,num_division)
y = C*state;
ymin = min(y.V);
ymax = max(y.V);
NNinput_min = [input.min,ymin];
NNinput_max = [input.max,ymax];
NNinput = inputDiscretize(NNinput_min,NNinput_max,num_division);
NNoutput = networkOutput(NNinput,network);
num_NNoutput = length(NNoutput);

for i = 1:1:num_NNoutput
    u = Polyhedron([NNoutput{i}.min;NNoutput{i}.max]);
    x{i} = A*state+B*u;
end
output = quickConvexHull(x);




            

