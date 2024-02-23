%MATLAB Program 3_1
A=[-2,2,-1;0,-2,0;1,-4,0];
B=[0,0;0,1;1,0];
Qc=ctrb(A,B);
n=rank(Qc);
L=length(A);
if n==L
    str='系统是状态完全能控'
else
    str='系统是状态不完全能控'
end






 


