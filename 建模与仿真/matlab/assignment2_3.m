function[m]=Martix1(A)
m{1,1}=std2(A)
m{2,1}=A./repmat(sqrt(sum(A.^2,2)),1,size(A,2));
m{3,1}=mean(A);