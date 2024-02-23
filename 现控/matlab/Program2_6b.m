%MATLAB Program 2_6b
A=[-1,-1;25,-2];B=[1,1;0,2];
C=[1,0;0,1];D=[0,0;0,0];
t=0:0.01:4;                   
LT=length(t);                 
u1=ones(1,LT); u2=ones(1,LT);    
u=[u1;u2]';                   
lsim(A,B,C,D,u,t)
grid

            
                       
            



 


