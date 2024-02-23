clear;
clc;
%生成一段时间t
t = 0:0.01:1;
L = length(t);

%生成真实信号x，和观测信号y
%初始化
x = zeros(1,L);
y = x;
%生成信号:x = t^2 , y = x + N(0,0.1)
for i = 1:L
    x(i) = t(i)^2;
    y(i) = x(i) + normrnd(0,0.1);
end
% plot(t,x,t,y,'LineWidth',2);

%滤波算法
%建立模型
%注意，卡尔曼滤波的模型都是线性模型，其中的噪声都是正态分布的

%根据观测数据，进行粗略建模1
%X(K) = X(K-1) + Q
%Y(K) = X(K) + R
%Q,R-N(0,1)
F1 = 1;
H1 = 1;
Q1 = 0.05;
R1 = 1;
%先验数据:X均值，P方差
Xminus1 = zeros(1,L);
Pminus1 = zeros(1,L);
%后验数据:X均值，P方差
Xplus1 = zeros(1,L);
Xplus1(1) = 1;
Pplus1 = zeros(1,L);
Pplus1(1) = 0.01^2;
%算法主体 plus后验，minus先验
%X(K)minus = F*X(K-1)plus
%P(K)minus = F*P(K-1)*F' + Q
%K = P(K)minus*H'*inv(H*P(K)minus*H' + R)
%X(K)plus = X(K)minus + K*(y(K) - H*X(K)minus)
%P(K)plus = (1 - K*H)*P(K)minus
for k=2:L
    Xminus1(k) = F1*Xplus1(k-1);
    Pminus1(k) = F1*Pplus1(k-1)*F1' + Q1;
    K1 = Pminus1(k)*H1'/(H1*Pminus1(k)*H1' + R1);
    Xplus1(k) = Xminus1(k) + K1*(y(k) - H1*Xminus1(k));
    Pplus1(k) = (1 - K1*H1)*Pminus1(k);
end

%泰勒展开提高维数，建模2
%X(K) = X(K-1) + X'(K-1)*dt + 0.5*X''(K-1)dt^2 + Q0
%X'(K) = X'(K-1) + X''(K-1)dt + Q1
%X''(K) = X''(K-1) + Q2
%Y(K) = X(K) + R
%Q,R-N(0,1)
dt = t(2)-t(1);
F2 = [1,dt,0.5*dt^2;
      0,1,dt;
      0,0,1];
H2 = [1,0,0];
Q2 = [1,0,0;
    0,0.01,0;
    0,0,0.001];
R2 = 0.1;
%先验数据:X均值，P方差
Xminus2 = zeros(3,L);
Pminus2 = zeros(3,3*L);
%后验数据:X均值，P方差
Xplus2 = zeros(3,L);
Xplus2(:,1) = [1;0;0];
Pplus2 = zeros(3,3*L);
Pplus2(1:3,1:3) = [0.01,0,0;
                    0,0.01,0;
                    0,0,0.01^2];
for k = 2:L
   Xminus2(:,k) = F2* Xplus2(:,k-1);
   Pminus2(:,3*k-2:3*k) = F2*Pplus2(:,3*(k-1)-2:3*(k-1))*F2' + Q2;
   K2 = Pminus2(:,3*k-2:3*k)*H2'/(H2*Pminus2(:,3*k-2:3*k)*H2' + R2);
   Xplus2(:,k) = Xminus2(:,k) + K2*(y(k) - H2*Xminus2(:,k));
   Pplus2(:,3*k-2:3*k) = (eye(3) - K2*H2)*Pminus2(:,3*k-2:3*k);
end

plot(t,x,'k');
hold on;
plot(t,y,'b');
hold on;
plot(t,Xplus1,'g');
hold on;
plot(t,Xplus2(1,:),'r');
hold on;



