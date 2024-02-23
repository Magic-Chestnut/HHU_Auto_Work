%MATLAB Program 2_6c
A=[-1,-1;25,-2];B=[1,1;0,2];C=[1,0;0,1];D=[0,0;0,0];
t=0:0.01:4;
[YY1,XX1]=step(A,B,C,D,1,t);   
[YY2,XX2]=step(A,B,C,D,2,t);  
y1=YY1(:,1)+YY2(:,1);      
y2=YY1(:,2)+YY2(:,2);      
subplot(2,1,1),plot(t,y1),ylabel('To:Y(1)'),grid
subplot(2,1,2),plot(t,y2),ylabel('To:Y(2)'),xlabel('time(sec)'),grid


            
                       
            



 


