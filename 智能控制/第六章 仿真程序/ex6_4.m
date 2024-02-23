%ex6_4.m
lr=0.05;err_goal=0.001;  %Lr(learning-rate)为学习速率，err_goal 为期望误差最小值
max_epoch=10000;a=0;   %训练的最大次数，a为惯性系数 a=0.9
Oi=0;Ok=0;               %置隐含层和输出层各种神经元输出值为零
%提供一组训练集合目标值（3输入2输出）
X=[1;-1;1];T=[1;1];
%初始化Wki, Wij,(M-输入节点j的数量，q—隐含层节点i的数量，L-输出节点k的数量)
[M,N]=size(X);q=8;[L,N]=size(T);  %N为训练集对数量
Wij=rand(q,M);Wki=rand(L,q);Wij0=zeros(size(Wij));Wki0=zeros(size(Wki));
for epoch=1:max_epoch
    %计算隐含层各神经元输出
NETi=Wij*X;
for j=1:N
  for i=1:q
    Oi(i,j)=2/(1+exp(-NETi(i,j)))-1;
  end
end
%计算各神经元输出
NETk=Wki*Oi;
for i=1:N
  for k=1:L
    Ok(k,i)=2/(1+exp(-NETk(k,i)))-1;
  end
end

E=((T-Ok)'*(T-Ok))/2; %计算误差函数
if (E<err_goal) break;end
deltak=Ok.*(1-Ok).*(T-Ok);W=Wki;    %调整输出层加权系数
Wki=Wki+lr*deltak*Oi'+a*(Wki-Wki0);Wki0=W;
deltai=Oi.*(1-Oi).*(deltak'*Wki)';W=Wij; %调整隐含层加权系数
Wij=Wij+lr*deltai*X'+a*(Wij-Wij0);Wij0=W;
end
epoch  
%BP算法的第二阶段——工作期（根据训练好的W_ki,W_ij和给定的输入计算输出）
X1=X;       %给定输入
NETi=Wij*X1; %计算隐含层各神经元输出
for j=1:N 
  for i=1:q
    Oi(i,j)=2/(1+exp(-NETi(i,j)))-1;
  end
end
NETk=Wki*Oi;  %计算各输出层神经元输出
for i=1:N
  for k=1:L
    Ok(k,i)=2/(1+exp(-NETk(k,i)))-1;
  end
end
Ok %显示网络输出层的输出
