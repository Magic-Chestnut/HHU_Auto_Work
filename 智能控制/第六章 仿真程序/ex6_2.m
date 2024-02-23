%ex6_2.m
%感知机的第一个阶段——学习期（训练加权系数w_ij）
clear all;
err_goal=0.001;lr=0.8; max_epoch=10000;   %给定期望误差的最小值，学习速率和训练的最大次数
X=[0 0 1 1; 0 1 0 1];  % 提供四组训练集（2输入1输出）
T=[0 1 1 1]; %T=[0 1 1 0];  % 或运算输出            与运输输出 
%初始化w_ij (M 是输入节点j的数量，L是输出节点i的数量，N为训练集的对数量)
[M,N]=size(X);[L,N]=size(T);Wij=rand(L,M);y=0;b=rand(L);
for epoch=1:max_epoch 
    %计算各神经元的输出
NETi=Wij*X;
for j=1:N
  for i=1:L
    if (NETi(i,j)>=b(i))
        y(i,j)=1;
    else
        y(i,j)=0;
    end
  end
end
%计算误差函数
E=(T-y); EE=0;
for j=1:N
  EE=EE+abs(E(j));
end 
if (EE<err_goal) break;end
Wij=Wij+lr*E*X';         
b=b+sqrt(EE);    %调整输出层加权系数和输出层神经元的阈值     
end
epoch,Wij,b   %显示计算次数、加权系数、阈值

%感知机的第二个阶段——工作期（根据训练好的W_ij,和给定的输入计算输出）
X1=X;       %给定输入
NETi=Wij*X1; [M,N]=size(X1);
for j=1:N  
  for i=1:L
    if (NETi(i,j)>=b(i))
        y(i,j)=1;
    else
        y(i,j)=0;
    end
  end
end
y
              %显示网络的输出
