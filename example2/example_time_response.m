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
%plot(X,'color','c','linewidth', 0.1);
%hold on
K=10;
num_division = [20,20];

%% Compute the reachable set for linear system
for k = 1:1:K
    X = linearsysOutputSet(A,B,C,network,X,input,num_division);
    X1_max(k) = max(X.V(:,1));
    X1_min(k) = min(X.V(:,1));
    X2_max(k) = max(X.V(:,2));
    X2_min(k) = min(X.V(:,2));
    %plot(X,'color','c','linewidth', 0.1);
    %hold on
end

X1_max = [state.max(1),X1_max];
X1_min = [state.min(1),X1_min];
X2_max = [state.max(2),X2_max];
X2_min = [state.min(2),X2_min];

k=0:1:K;
%figure
%subplot(211)
hold on;
fill([k fliplr(k)],[X2_min fliplr(X2_max)],'c','edgecolor','c');

%% Generate random trajectories of linear system
%load data network net
num_sim = 100;
for i = 1:1:num_sim
    x_1 = state.min(1)+ (state.max(1)-state.min(1))*rand;
    x_2 = state.min(2)+ (state.max(2)-state.min(2))*rand;
    x = [x_1;x_2];
    %plot(x(1),x(2),'.','color','b');
    %hold on;
    u = input.min+ (input.max(1)-input.min(1))*rand;
    k=0:1:K;
    for n=1:1:K
        x = linearsysOutputSingle(A,B,C,network,x,u);
        x1(n) = x(1);
        x2(n) = x(2);
        %plot(x(1),x(2),'.','color','b');
        %hold on;
    end
    X1 = [x_1,x1];
    X2 = [x_2,x2];
    %subplot(211)
    plot(k,X2,'r');
    hold on
end