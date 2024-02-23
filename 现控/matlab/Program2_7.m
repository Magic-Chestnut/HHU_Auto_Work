%MATLAB Program 2_7
clear all
T=0.1;                          
G=[0.986 0.086;-0.258 0.733];
H=[0.005;0.086];C=[1 0];D=0;
[yd,x,n]=dstep(G,H,C,D);  
for k=1:n                 
plot([k-1,k-1],[0,yd(k)],'k')  
hold on
end

e=1-yd;                         
for k=1:n
  for j=1:100
      u(j+(k-1)*100)=e(k);  
  end
end
t=(0:0.01:n-0.01)*T;
[yc]=lsim([0 1;-2 -3],[0;1],[1 0],[0],u,t);
plot(t/T,yc,':k')
axis([0 30 0 0.5]),xlabel('采样周期数k'),ylabel('y(k)')
hold off



            
                       
            



 


