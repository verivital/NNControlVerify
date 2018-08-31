function output = linearsysOutputSingle(A,B,C,network,state,input)

y = C*state;
NNinput = [input;y];
NNoutput = networkOutputSingle(NNinput,network);
output = A*state+B*NNoutput;




            

