%% Example 2
clear
A =0.5*randn(2,2);
B = randn(2,1);
C = randn(1,2);
network.weight = {randn(5,2),randn(1,5)};
network.bias = {randn(5,1),randn(1,1)};
network.activeType = {'tansig','purelin'} ;
%save data_1 network A B C
load data_1 network A B C

run('generateFun.m')

%load data network net
input.min = -0.5;
input.max = 0.5;
state.min = [2 2];
state.max = [3 3];
X = Polyhedron([state.min(1) state.min(2); state.min(1) state.max(2); state.max(1) state.min(2); state.max(1) state.max(2)]);
plot(X,'color','c','linewidth', 0.1);
hold on
K=10;
num_division = [20,20];

%% Compute the reachable set for linear system
for k = 1:1:K
    X = linearsysOutputSet(A,B,C,network,X,input,num_division);
    plot(X,'color','c','linewidth', 0.1);
    hold on
end
%% Generate random trajectories of linear system
%load data network net
num_sim = 500;
for i = 1:1:num_sim
    x_1 = state.min(1)+ (state.max(1)-state.min(1))*rand;
    x_2 = state.min(2)+ (state.max(2)-state.min(2))*rand;
    x = [x_1;x_2];
    plot(x(1),x(2),'.','color','r');
    hold on;
    u = input.min+ (input.max(1)-input.min(1))*rand;
    for n=1:1:K
        x = linearsysOutputSingle(A,B,C,network,x,u);
        plot(x(1),x(2),'.','color','r');
        hold on;
    end
end