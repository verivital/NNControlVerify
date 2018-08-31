function [output, NNu]= linearsysOutputSet(A,B,network,state,NNinput)


NNoutput = networkOutput(NNinput,network);
num_NNoutput = length(NNoutput);

for i = 1:1:num_NNoutput
    u = Polyhedron([NNoutput{i}.min;NNoutput{i}.max]);
    x{i} = A*state+B*u;
    U{i} = u;
end
output = quickConvexHull(x);
NNu = quickConvexHull2(U);




            

