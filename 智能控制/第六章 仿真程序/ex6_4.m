%ex6_4.m
lr=0.05;err_goal=0.001;  %Lr(learning-rate)Ϊѧϰ���ʣ�err_goal Ϊ���������Сֵ
max_epoch=10000;a=0;   %ѵ������������aΪ����ϵ�� a=0.9
Oi=0;Ok=0;               %�������������������Ԫ���ֵΪ��
%�ṩһ��ѵ������Ŀ��ֵ��3����2�����
X=[1;-1;1];T=[1;1];
%��ʼ��Wki, Wij,(M-����ڵ�j��������q��������ڵ�i��������L-����ڵ�k������)
[M,N]=size(X);q=8;[L,N]=size(T);  %NΪѵ����������
Wij=rand(q,M);Wki=rand(L,q);Wij0=zeros(size(Wij));Wki0=zeros(size(Wki));
for epoch=1:max_epoch
    %�������������Ԫ���
NETi=Wij*X;
for j=1:N
  for i=1:q
    Oi(i,j)=2/(1+exp(-NETi(i,j)))-1;
  end
end
%�������Ԫ���
NETk=Wki*Oi;
for i=1:N
  for k=1:L
    Ok(k,i)=2/(1+exp(-NETk(k,i)))-1;
  end
end

E=((T-Ok)'*(T-Ok))/2; %��������
if (E<err_goal) break;end
deltak=Ok.*(1-Ok).*(T-Ok);W=Wki;    %����������Ȩϵ��
Wki=Wki+lr*deltak*Oi'+a*(Wki-Wki0);Wki0=W;
deltai=Oi.*(1-Oi).*(deltak'*Wki)';W=Wij; %�����������Ȩϵ��
Wij=Wij+lr*deltai*X'+a*(Wij-Wij0);Wij0=W;
end
epoch  
%BP�㷨�ĵڶ��׶Ρ��������ڣ�����ѵ���õ�W_ki,W_ij�͸�����������������
X1=X;       %��������
NETi=Wij*X1; %�������������Ԫ���
for j=1:N 
  for i=1:q
    Oi(i,j)=2/(1+exp(-NETi(i,j)))-1;
  end
end
NETk=Wki*Oi;  %������������Ԫ���
for i=1:N
  for k=1:L
    Ok(k,i)=2/(1+exp(-NETk(k,i)))-1;
  end
end
Ok %��ʾ�������������
