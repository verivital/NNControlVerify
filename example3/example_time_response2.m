%% Example 2 by Xiaodong
%clear
addpath('../');
load NN.mat;
load sysd.mat;

A = sysd.A;
B = sysd.B;
C = [1, 0];
D = 0;
network.weight = {[weights_first_layer1, weights_first_layer2], weights_second_layer};
network.bias = {bias_first_layer,bias_second_layer}; 
network.activeType = {'tansig','purelin'} ;
save data network A B C
run('generateFun.m')

%load data network net
 input.min = -1;
 input.max = -0.99;
 state.min = [0.8 -1];
 state.max = [1 -0.8];

% numdx = [1,1];
% numdr = 1;
% numd = [1,20,20];
Xd = rangeDiscretize(state.min, state.max, numdx);
Rd = RdDiscretize(input.min, input.max, numdr);
K = 20;

%%
tic
for n = 1:length(Xd)
    for m = 1:length(Rd)
        y_delay1min = 0;
        y_delay1max = 0.000001;
        y_delay2min = 0;
        y_delay2max = 0.000001;
        X = Xd{n};
        y = C*X;
        ymin = min(y.V);
        ymax = max(y.V);
        y_delay1min = ymin;
        y_delay1max = ymax;
        NNinput_min = [Rd{m}.min, y_delay1min, y_delay2min];
        NNinput_max = [Rd{m}.max, y_delay1max, y_delay2max];
        NNinput = inputDiscretize(NNinput_min, NNinput_max, numd);
        Xprev = X; % store previous X
        
        [X, NNu] = linearsysOutputSet(A,B,network,X,NNinput);
        Xall{n}(m,1) = X;
        y_delay2min = y_delay1min;
        y_delay2max = y_delay1max;
        for k = 2:K
            y = C*X;
            ymin = min(y.V);
            ymax = max(y.V);
            y_delay1min = ymin;
            y_delay1max = ymax;
            NNinput_min = [input.min, y_delay1min, y_delay2min];
            NNinput_max = [input.max, y_delay1max, y_delay2max];
            NNinput = inputDiscretize(NNinput_min,NNinput_max,numd);

            % polyhedron of y(k+1) and y(k) with dependancy
            S = (B*NNu);
            Ak = S.A*[eye(2), -A];
            newA = [Ak;zeros(size(Xprev.A,1),2), Xprev.A];
            newb = [S.b; Xprev.b];
            newxk = Polyhedron('A', newA, 'b', newb, 'Ae', [], 'be', []);
            newyk = [C,zeros(size(C)); zeros(size(C)) C]*newxk;
            %     figure
            %     plot(newyk)
            %check intersection between NNinput and newyk
            NNinputd = intersec(NNinput, newyk);
            %NNinputd= intersec2(NNinput, newyk, 6, numd);
            %NNinput_len = length(NNinput) 
            %NNinputd_len = length(NNinputd)
            %delta = NNinput_len - NNinputd_len
            Xprev = X; % store previous X
            
            [X, NNu] = linearsysOutputSet(A,B,network,X,NNinputd);

            Xall{n}(m,k) = X;
            y_delay2min = y_delay1min;
            y_delay2max = y_delay1max;
            toc
        end
        
    end
end
%%
figure
for k = 1:K
  t = 1; Xk = {};
  for n = 1:length(Xd)
      for m = 1:length(Rd)
          Xk{t} = Xall{n}(m,k);
          t =t + 1;
      end
  end
  Xpk = quickConvexHull(Xk);
  plot(Xpk)
  hold on
  X1_max(k) = max(Xpk.V(:,1));
  X1_min(k) = min(Xpk.V(:,1));
  X2_max(k) = max(Xpk.V(:,2));
  X2_min(k) = min(Xpk.V(:,2));
end
hold off
X1_max = [state.max(1),X1_max];
X1_min = [state.min(1),X1_min];
X2_max = [state.max(2),X2_max];
X2_min = [state.min(2),X2_min];
%%
k=0:1:K;
figure
%subplot(211)
%hold on;
fill([k fliplr(k)],[X1_min fliplr(X1_max)],'c','edgecolor','c');
title('X1')
hold on
figure
fill([k fliplr(k)],[X2_min fliplr(X2_max)],'c','edgecolor','c');
title('X2')
%% Generate random trajectories of linear system
% load data network net
% num_sim = 500;
% for i = 1:1:num_sim
%     x_1 = state.min(1)+ (state.max(1)-state.min(1))*rand;
%     x_2 = state.min(2)+ (state.max(2)-state.min(2))*rand;
%     x = [x_1;x_2];
%     %plot(x(1),x(2),'.','color','b');
%     %hold on;
%     
%     k=0:1:K;
%     y_delay1 = 0;
%     y_delay2 = 0;
%     for n=1:1:K
%         u = input.min+ (input.max(1)-input.min(1))*rand;
%         y_delay1 = C*x;
%         NNinput = [u;y_delay1;y_delay2];
%         x = linearsysOutputSingle(A,B,network,x,NNinput);
%         x1(n) = x(1);
%         x2(n) = x(2);
%         %plot(x(1),x(2),'.','color','b');
%         %hold on;
%         y_delay2 = y_delay1; 
%     end
%     X1 = [x_1,x1];
%     X2 = [x_2,x2];
%     %subplot(211)
%     plot(k,X1,'r');
%     hold on
% end
% hold off


