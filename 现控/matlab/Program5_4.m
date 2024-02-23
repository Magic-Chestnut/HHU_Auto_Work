%MATLAB Program 5_4
A=[0 1 0 0;0 0 -0.5 0;0 0 0 1;0 0 20.6 0];
B=[0;0.5;0;-1];C=[1 0 0 0];
F=[-88.16 -55.93 -212.68 -47.96];
K=-88.16;
AA=[A-B*F B*K;-C 0];
BB=[zeros(4,1);1];
CC=[-C 0];
DD=0;
t=0:0.01:8;
[y,X,t]=step(AA,BB,CC,DD,1,t);
x1=X(:,1);
x2=X(:,2);
x3=X(:,3);
x4=X(:,4);
w=X(:,5);
subplot(3,2,1)
plot(t,x1,'k'),grid
xlabel('t(sec)'),ylabel('x1')
subplot(3,2,2)
plot(t,x2,'k'),grid
xlabel('t(sec)'),ylabel('x2')
subplot(3,2,3)
plot(t,x3,'k'),grid
xlabel('t(sec)'),ylabel('x3')
subplot(3,2,4)
plot(t,x4,'k'),grid
xlabel('t(sec)'),ylabel('x4')
subplot(3,2,5)
plot(t,w,'k'),grid
xlabel('t(sec)'),ylabel('w')

   











 


