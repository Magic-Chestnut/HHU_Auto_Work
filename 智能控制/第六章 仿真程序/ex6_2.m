%ex6_2.m
%��֪���ĵ�һ���׶Ρ���ѧϰ�ڣ�ѵ����Ȩϵ��w_ij��
clear all;
err_goal=0.001;lr=0.8; max_epoch=10000;   %��������������Сֵ��ѧϰ���ʺ�ѵ����������
X=[0 0 1 1; 0 1 0 1];  % �ṩ����ѵ������2����1�����
T=[0 1 1 1]; %T=[0 1 1 0];  % ���������            ��������� 
%��ʼ��w_ij (M ������ڵ�j��������L������ڵ�i��������NΪѵ�����Ķ�����)
[M,N]=size(X);[L,N]=size(T);Wij=rand(L,M);y=0;b=rand(L);
for epoch=1:max_epoch 
    %�������Ԫ�����
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
%��������
E=(T-y); EE=0;
for j=1:N
  EE=EE+abs(E(j));
end 
if (EE<err_goal) break;end
Wij=Wij+lr*E*X';         
b=b+sqrt(EE);    %����������Ȩϵ�����������Ԫ����ֵ     
end
epoch,Wij,b   %��ʾ�����������Ȩϵ������ֵ

%��֪���ĵڶ����׶Ρ��������ڣ�����ѵ���õ�W_ij,�͸�����������������
X1=X;       %��������
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
              %��ʾ��������
