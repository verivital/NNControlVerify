%% Compute the single output of the layer y = f(x)
function y = networkOutputPoint(input,network) 

layerNum = length(network.bias);
for i=1:1:layerNum
    input =  activeFun(network.weight{i}*input + network.bias{i},network.activeType{i});    
end

y = input;



 