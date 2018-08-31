function y = layerOutput(layerNum,input,network)
switch layerNum
case 1
xmax(1) = network.weight{1}(1,1)*input.min(1)+network.weight{1}(1,2)*input.min(2)+network.bias{1}(1);
xmin(1) = network.weight{1}(1,1)*input.max(1)+network.weight{1}(1,2)*input.max(2)+network.bias{1}(1);
xmax(2) = network.weight{1}(2,1)*input.max(1)+network.weight{1}(2,2)*input.min(2)+network.bias{1}(2);
xmin(2) = network.weight{1}(2,1)*input.min(1)+network.weight{1}(2,2)*input.max(2)+network.bias{1}(2);
xmax(3) = network.weight{1}(3,1)*input.min(1)+network.weight{1}(3,2)*input.max(2)+network.bias{1}(3);
xmin(3) = network.weight{1}(3,1)*input.max(1)+network.weight{1}(3,2)*input.min(2)+network.bias{1}(3);
xmax(4) = network.weight{1}(4,1)*input.max(1)+network.weight{1}(4,2)*input.max(2)+network.bias{1}(4);
xmin(4) = network.weight{1}(4,1)*input.min(1)+network.weight{1}(4,2)*input.min(2)+network.bias{1}(4);
xmax(5) = network.weight{1}(5,1)*input.max(1)+network.weight{1}(5,2)*input.min(2)+network.bias{1}(5);
xmin(5) = network.weight{1}(5,1)*input.min(1)+network.weight{1}(5,2)*input.max(2)+network.bias{1}(5);
xmax(6) = network.weight{1}(6,1)*input.min(1)+network.weight{1}(6,2)*input.max(2)+network.bias{1}(6);
xmin(6) = network.weight{1}(6,1)*input.max(1)+network.weight{1}(6,2)*input.min(2)+network.bias{1}(6);
xmax(7) = network.weight{1}(7,1)*input.max(1)+network.weight{1}(7,2)*input.max(2)+network.bias{1}(7);
xmin(7) = network.weight{1}(7,1)*input.min(1)+network.weight{1}(7,2)*input.min(2)+network.bias{1}(7);
y.min = activeFun(xmin,network.activeType{1});
y.max = activeFun(xmax,network.activeType{1});
case 2
xmax(1) = network.weight{2}(1,1)*input.max(1)+network.weight{2}(1,2)*input.max(2)+network.weight{2}(1,3)*input.min(3)+network.weight{2}(1,4)*input.min(4)+network.weight{2}(1,5)*input.max(5)+network.weight{2}(1,6)*input.max(6)+network.weight{2}(1,7)*input.min(7)+network.bias{2}(1);
xmin(1) = network.weight{2}(1,1)*input.min(1)+network.weight{2}(1,2)*input.min(2)+network.weight{2}(1,3)*input.max(3)+network.weight{2}(1,4)*input.max(4)+network.weight{2}(1,5)*input.min(5)+network.weight{2}(1,6)*input.min(6)+network.weight{2}(1,7)*input.max(7)+network.bias{2}(1);
xmax(2) = network.weight{2}(2,1)*input.min(1)+network.weight{2}(2,2)*input.min(2)+network.weight{2}(2,3)*input.max(3)+network.weight{2}(2,4)*input.min(4)+network.weight{2}(2,5)*input.min(5)+network.weight{2}(2,6)*input.max(6)+network.weight{2}(2,7)*input.max(7)+network.bias{2}(2);
xmin(2) = network.weight{2}(2,1)*input.max(1)+network.weight{2}(2,2)*input.max(2)+network.weight{2}(2,3)*input.min(3)+network.weight{2}(2,4)*input.max(4)+network.weight{2}(2,5)*input.max(5)+network.weight{2}(2,6)*input.min(6)+network.weight{2}(2,7)*input.min(7)+network.bias{2}(2);
y.min = activeFun(xmin,network.activeType{2});
y.max = activeFun(xmax,network.activeType{2});
end
