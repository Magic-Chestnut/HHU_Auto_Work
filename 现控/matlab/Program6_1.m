% MATLAB Program 6_1
% Design of Quadratic optimal control system md6-10.m
% Enter state matrix A B C D
a=[0 1 0;0 0 1; 0 -2 -3];  b=[0; 0; 1];
c=[1 0 0]; d=0;
% Enter matrices Q and R of the quadratic performance
Q=[1000 0 0; 0 1 0; 0 0 1];  R=1;
% To obtain the optimal state feedback gain matrix F
F=lqr(a,b,Q,R)
f1=F(1)
% To obtain the unit-step response curve 
ac=a-b*F;  bc=b*f1; cc=c; dc=d;
step(ac,bc,cc,dc);
grid

