%洗涤时间隶属函数设计仿真程序：chap4_4.m
%Define N+1 triangle membership function
clear all;
close all;
z=0:0.1:60;

u=trimf(z,[0 0 10]);
figure(1);
plot(z,u);

u=trimf(z,[0,10,25]);
hold on;
plot(z,u);
u=trimf(z,[10,25,40]);
hold on;
plot(z,u);

u=trimf(z,[25,40 60]);
hold on;
plot(z,u);

u=trimf(z,[40,60 60]);
hold on;
plot(z,u);
xlabel('z');
ylabel('Degree of membership');