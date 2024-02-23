x=0:0.1:1.9;
y=x-exp(-x);
a=polyfit(x-0.95,y,5);
plot(x,y,'r*')
hold on
z=polyval(a,x-0.95);
plot(x,z,'b-');
syms X f(x)
f(x)=a(1);
for i = 2:1:6
    f(x)=f(x)+a(i)*(X-0.95)^(i-1);
end
disp(f(x));