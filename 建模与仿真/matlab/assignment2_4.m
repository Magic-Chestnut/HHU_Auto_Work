syms x
fun=@(x)exp(-2*x);
k=@(a)quad(fun,0,a);
fplot(k,[0,3],'b')
y=exp(-2*x);
k2=int(y,x,0,2)
