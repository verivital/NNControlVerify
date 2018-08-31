function [x,y] = linearsysOutput(A,B,C,D,state,input)
%state.min = [-1;-1];
%state.max =[1;1];
%input.min = -1;
%input.max =1;
%A = [1 2;-1 -2];
%B = [1;-1];
%C = [1,-1];
%D = [1];

[nA,nB] = size(B);
[nC,nA] = size(C);
[nC,nD] = size(D);
x.min = zeros(nA,1);
x.max = zeros(nA,1);
y.min = zeros(nC,1);
y.max = zeros(nC,1);

for i = 1:1:nA
    for j = 1:1:nA
        if A(i,j) > 0 
            x.min(i) = x.min(i)+A(i,j)*state.min(j);
            x.max(i) = x.max(i)+A(i,j)*state.max(j);
        elseif A(i,j) <= 0 
            x.min(i) = x.min(i)+A(i,j)*state.max(j);
            x.max(i) = x.max(i)+A(i,j)*state.min(j);
        end
    end
    
    for j = 1:1:nB
        if B(i,j) > 0
            x.min(i) = x.min(i)+B(i,j)*input.min(j);
            x.max(i) = x.max(i)+B(i,j)*input.max(j);
        else
            x.min(i) = x.min(i)+B(i,j)*input.max(j);
            x.max(i) = x.max(i)+B(i,j)*input.min(j);
        end
    end
end

for i = 1:1:nC
    for j = 1:1:nA
        if C(i,j) > 0 
            y.min(i) = y.min(i)+C(i,j)*state.min(j);
            y.max(i) = y.max(i)+C(i,j)*state.max(j);
        elseif A(i,j) <= 0 
            y.min(i) = y.min(i)+C(i,j)*state.max(j);
            y.max(i) = y.max(i)+C(i,j)*state.min(j);
        end
    end
    
    for j = 1:1:nD
        if D(i,j) > 0
            y.min(i) = y.min(i)+D(i,j)*input.min(j);
            y.max(i) = y.max(i)+D(i,j)*input.max(j);
        else
            y.min(i) = y.min(i)+D(i,j)*input.max(j);
            y.max(i) = y.max(i)+D(i,j)*input.min(j);
        end
    end
end


            

