%MATLAB Program 2_4b
x0=[0;0;0;0];                         
t0=0;tf=6;tspan=[t0,tf]              
[t,x]=ode45('ode_example',tspan,x0);  
y=24*x(:,4);                          
subplot(1,2,1)
plot(t,x(:,1),'k',t,x(:,2),'-.r',t,x(:,3),':b',t,x(:,4),'-k')
                                      
subplot(1,2,2)
plot(t,y,'k')                         
            



 


