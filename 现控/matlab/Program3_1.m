%MATLAB Program 3_1
A=[-2,2,-1;0,-2,0;1,-4,0];
B=[0,0;0,1;1,0];
Qc=ctrb(A,B);
n=rank(Qc);
L=length(A);
if n==L
    str='ϵͳ��״̬��ȫ�ܿ�'
else
    str='ϵͳ��״̬����ȫ�ܿ�'
end






 


