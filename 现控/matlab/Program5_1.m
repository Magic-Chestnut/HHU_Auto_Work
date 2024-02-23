%MATLAB Program 5_1
A=[1 3;0 -1]; B=[0;1];            
Qc=ctrb(A,B);         
rank_Qc=rank(Qc)      

P_A=poly(A)            

a2=P_A(3); a1=P_A(2);
P_x=poly([-1+j;-1-j])  

a_x2=P_x(3);a_x1=P_x(2);
Tc=Qc*[a1 1;1 0]       %«Û±‰ªªæÿ’Û
F=[a_x2-a2 a_x1-a1]*inv(Tc)










 


