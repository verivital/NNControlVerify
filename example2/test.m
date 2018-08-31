clc
clear
A = [-1 -4; 4 -1]; B = [1; 1]; C = [1 0]; D = 0;
sysc = ss(A, B, C, D);
Ts = 0.02;
sys = c2d(sysc,Ts);

% set of initial states
X0 = Polyhedron([0.9 0.1; 0.9 -0.1; 1.1 0.1; 1.1 -0.1]);
%X0 = interval([0.9;-0.1],[1.1;0.1]);
% set of admissible inputs
U0 = Polyhedron('V',[-1;1]); % inputs should be such that |u| <= 0.1
%U0 = interval(-0.1,0.1);

N = 50;
X=X0;

 x = sys.A*X+sys.B*U0;
 output = sys.C*X+sys.D*U0;
 y.max = max(output.V);
 y.min = min(output.V);
%figure
for k = 1:1:N
    x = sysd.A*X+sysd.B*U0;
    
end
% plot the results
