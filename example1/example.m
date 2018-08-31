%% Example 1 
clc
clear
%% Generate or load random NN
numNueron = [2,7,2];
network.activeType = {'tansig','purelin'};
numLayer = length(numNueron)-1;

for n = 1:1:numLayer
    network.weight{n} = randn(numNueron(n+1),numNueron(n));
    network.bias{n} = randn(numNueron(n+1),1);
end

load data network
%save data network

%% Generate the optimal solution m file, if use the line below, need to pause for a while to generate the m file
run('generateFun.m')

%% Generate 2D disceretized input sets 
M = [50, 50];
inputMin = [-1;-1];
inputMax = [1;1];
for i = 1:1:length(M)
    step(i) = (inputMax(i)-inputMin(i))/M(i);
end

k=0;
for i = inputMin(1):step(1):inputMax(1)-step(1)
    for j = inputMin(2):step(2):inputMax(2)-step(2)
        k=k+1;
        input{k}.min(1) = j;
        input{k}.min(2) = i;
        if j+step(2) < inputMax(2)
            input{k}.max(1) = j+step(2);
        else
            input{k}.max(1) = inputMax(2);
        end
        if i+step(1) < inputMax(1)
            input{k}.max(2) = i+step(1);
        else
            input{k}.max(2) = inputMax(1);
        end       
    end
end

%% Compute output set
tic
y = networkOutput(input,network);
toc
%% Draw picture for reachable set
%figure
for i = 1:1:length(y)
     squareplot(y{i},'c','full');
     hold on
end
for i = 1:1:3000
    inputPoint = [inputMin(1) + (inputMax(1)-inputMin(1))*rand;inputMin(2) + (inputMax(2)-inputMin(2))*rand];% center of input set
    yPoint = networkOutputPoint(inputPoint,network); % [y.y0,y.radius] = [center of output set, radius of output set]
    plot(yPoint(1),yPoint(2),'.r')
    hold on
end






