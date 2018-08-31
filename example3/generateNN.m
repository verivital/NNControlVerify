clc
clear
%% System and get the input and output of the system
A = 0.5*randn(2,2);%System matrices
B = [1;2];
C = [1,1];
D = [0];
%load system A B C D
sys = ss(A,B,C,D,-1);%state space model
input_min = 0.8;
input_max = 1.2;
K=100;
figure;

%u = input_min(1)+ (input_max(1)-input_min(1))*rand(1,K);

u = ones(1,K);% input sequence
x0=[];%initial state
[y,t,x]=lsim(sys,u,[],x0);%simulation of linear system to get output, time, state
y = y';%transpose output
plot(t,y) % draw pic for output
%save system A B C D
%% Get the input and output data to train neural network
du = 0; %set the delay of input
dy = 1; %set the delay of output, normally it is the order of the system to be modeled
%y(k) = f(u(k),..u(k-du))
for n = 1:1:length(u)-du %get the input data of system input to be trained
    u_input_temp = u(:,n);
    for k = n+1:1:n+du
    u_input_temp = [u_input_temp;u(:,k)];
    end
    u_input(:,n) = u_input_temp;
end
%y(k) = f(y(k-1),..y(k-dy))
for n = 1:1:length(y)-dy %get the input data of system output to be trained
    y_input_temp = y(:,n);
    for k = n+1:1:n+dy-1
    y_input_temp = [y_input_temp;y(:,k)];
    end
    y_input(:,n) = y_input_temp;
end

dsize = length(u_input)-length(y_input);

if dsize > 0
    u_input = u_input(:,dsize+1:length(u_input));
elseif dsize < 0
    y_input = y_input(:,dsize+1:length(y_input));
end
    
input = [u_input;y_input]; %get the input data to be trained for neural network
output = y(:,dy+1:length(y)); %get the output data to be trained for neural network

%% Train neural network
num_neuron = [5,1];
activefun = {'tansig','purelin'};
net=newff(minmax(input),num_neuron,activefun,'trainlm'); %intialize network
%net=newff(minmax(input),[5 5 2],{'poslin','poslin','purelin'}','trainlm');

net.trainParam.epochs=100;
net.trainParam.lr=0.01;
net.trainParam.goal=0.00001;
net=train(net,input,output);

network.weight{1} = net.IW{1}; %get the weight from net for computing reachable set
network.bias{1} = net.b{1};  %get the bias from net for computing reachable set

for i = 2:1:length(net.IW)
    network.weight{i} = net.LW{i,i-1};
    network.bias{i} = net.b{i};
end

network.activeType = activefun;

save data network net

input_min = 0.8;
input_max = 1.2;
K=50;
figure;
for n=1:1:20
    n
    input_sequence = input_min(1)+ (input_max(1)-input_min(1))*rand(1,K);
    [y,t,x]=lsim(sys,input_sequence,[],x0);
    y = y';%transpose output
    plot(t,y)
    hold on
end
