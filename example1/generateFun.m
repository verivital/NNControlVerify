%% Generate layerOuput.m file
clc
clear
fileName = ['layerOutput' '.m'];
fid = fopen(fileName,'w');


load data network; 

layerNum = length(network.bias);

fprintf(fid,'function y = layerOutput(layerNum,input,network)\n');
fprintf(fid,'switch layerNum\n');

for k = 1:1:layerNum
    fprintf(fid,'case %i\n',k);
    [n,m] = size(network.weight{k});
    for i = 1:1:n
        fprintf(fid,'xmax(%i) = ',i);
        for j = 1:1:m-1
            if network.weight{k}(i,j) > 0
                fprintf(fid,'network.weight{%i}(%i,%i)*input.max(%i)+',k,i,j,j);
            else
                fprintf(fid,'network.weight{%i}(%i,%i)*input.min(%i)+',k,i,j,j);
            end
        end
        if network.weight{k}(i,m) > 0
            fprintf(fid,'network.weight{%i}(%i,%i)*input.max(%i)+network.bias{%i}(%i);\n',k,i,m,m,k,i);
        else
            fprintf(fid,'network.weight{%i}(%i,%i)*input.min(%i)+network.bias{%i}(%i);\n',k,i,m,m,k,i);
        end
        fprintf(fid,'xmin(%i) = ',i);
        for j = 1:1:m-1
            if network.weight{k}(i,j) > 0
                fprintf(fid,'network.weight{%i}(%i,%i)*input.min(%i)+',k,i,j,j);
            else
                fprintf(fid,'network.weight{%i}(%i,%i)*input.max(%i)+',k,i,j,j);
            end
        end
        if network.weight{k}(i,m) > 0
            fprintf(fid,'network.weight{%i}(%i,%i)*input.min(%i)+network.bias{%i}(%i);\n',k,i,m,m,k,i);
        else
            fprintf(fid,'network.weight{%i}(%i,%i)*input.max(%i)+network.bias{%i}(%i);\n',k,i,m,m,k,i);
        end
    end
    fprintf(fid,'y.min = activeFun(xmin,network.activeType{%i});\n',k);
    fprintf(fid,'y.max = activeFun(xmax,network.activeType{%i});\n',k);
end
fprintf(fid,'end\n');



            







