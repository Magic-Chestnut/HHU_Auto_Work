%MATLAB Program 3_2
A=[4,1,0,0;0,4,0,0;0,0,4,1;0,0,0,4];
C=[1,1,2,1;1,2,2,0];
Q0=obsv(A,C);
r=rank(Q0);
L=size(A);
if r==L
    str='系统是状态完全能观测'
else
    str='系统是状态不完全能观测'    
end








 


