function output = linearsysOutputSingle(A,B,network,state,NNinput)


NNoutput = networkOutputSingle(NNinput,network);
output = A*state+B*NNoutput;


            

