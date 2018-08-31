%% Compute reach set for MLP
function y = networkOutput(input,network)

layerNum = length(network.bias);
weight = network.weight;
bias = network.bias;
activeType =network.activeType;
inputNum = length(input);

for i= 1:1:inputNum
    for j = 1:1:layerNum
        input{i} = layerOutput(j,input{i},network);
    end
end
y = input;