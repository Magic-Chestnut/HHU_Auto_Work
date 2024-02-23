%MATLAB Program 2_3
syms z k                  
G=[0,1;-0.2,-0.9];
Fz=(inv(z*eye(2)-G))*z;     
Fk=iztrans(Fz,z,k)          
Fk=simple(Fk)              



 


