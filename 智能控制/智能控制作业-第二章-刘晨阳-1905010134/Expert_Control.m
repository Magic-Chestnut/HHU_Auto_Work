%% -1 脚本说明：
%提供专家PID控制程序范式from lcy

%% 0 脚本环境初始化：
clear;%清除工作空间所有 变量、函数、文件
clc;%清空命令窗口
close all;%关闭所有figure

%% 1 被控对象初始化
numc = 133;%连续传递函数分子
denc = [1,25,0];%连续传递函数分母
sysc = tf(numc,denc)%连续系统传递函数
ts = 0.001;%采样时间/s
dis_method = 'zoh';%零阶保持器离散化方法
sysd = c2d(sysc,ts,dis_method)%离散化系统传递函数
[numd,dend] = tfdata(sysd,'v');%获得脉冲传递函数分子、分母
numd_length = size(numd,2);%脉冲传递函数分母维数
dend_length = size(dend,2);%脉冲传递函数分子维数
y_buffer = zeros(1,dend_length);%系统输出缓存（索引越小，距现在越近）

%% 2 控制器参数设定
kp = 0.008;%比例系数
ki = 0.02;%积分系数
kd = 1;%微分系数
M1 = 0.7;%开环门槛
M2 = 0.25;%强化削弱门槛
M3 = 0.15;%PI门槛
k1 = 1;%PID强化增益
k2 = 1;%PID削弱增益
upper_limit = 10;%PID输出上限
lower_limit = -10;%PID输出下限
u_open = 1;
e_buffer = zeros(1,6);%1当前误差 2误差积分 3误差微分 4上次误差 5上上次误差 6上次误差微分
u_buffer = zeros(1,dend_length);%系统输入缓存（索引越小，距现在越近）

%% 3 运行参数设定
t_run = 10;%运行时间/s（最少1s）
loop_counter = t_run/ts;%循环次数
run_time = zeros(1,loop_counter);%时间队列
y_set = ones(1,loop_counter);%给定值队列
for i = 1:1:uint16(1/ts)%开头1s给0，制造阶跃响应
    y_set(i) = 0;
end
u = zeros(1,loop_counter);%系统输入队列
y = zeros(1,loop_counter);%系统输出队列

%% 4 控制器运行
for k = 1:1:loop_counter
    run_time(k) = k*ts;%更新时间队列
    %更新误差数据
    e_buffer(1) = y_set(k) - y_buffer(1);%更新当前误差
    e_buffer(2) = e_buffer(2) + e_buffer(1)*ts;%更新误差积分
    e_buffer(3) = (e_buffer(1) - e_buffer(4))/ts;%更新误差微分
    
%     更新控制量
    if abs(e_buffer(1)) > M1
        u(k) = sign(e_buffer(1))*u_open;%如果误差太大，就给开环
    elseif (abs(e_buffer(1)) <= M3) && (abs(e_buffer(4)) <= M3)
        if (e_buffer(1) == 0)
            u(k) = u_buffer(1);%如果连续两次小误差，且此次误差为0，则保持上一次控制量
        else
            u(k) = u_buffer(1) + kp*e_buffer(3) + ki*e_buffer(1);%如果连续两次小误差，但还有误差就PI控制
        end
    elseif (e_buffer(1)*e_buffer(3)<0) && (e_buffer(3)*e_buffer(6)>0)
        u(k) = u_buffer(1);%如果误差在减小，保持上一次控制量
    elseif (e_buffer(1)*e_buffer(3)>0) || (e_buffer(3)==0)
        if abs(e_buffer(1)) >= M2
            u(k) = u_buffer(1) + k1*(kp*e_buffer(3) + ki*e_buffer(1) + kd*(e_buffer(3)-e_buffer(6)));%如果误差没在减小，误差还较大，就增强PID控制
        else
            u(k) = u_buffer(1) + kp*e_buffer(3) + ki*e_buffer(1) + kd*(e_buffer(3)-e_buffer(6));%如果误差没在减小，误差不太大，就一般PID控制
        end
    elseif (e_buffer(1)*e_buffer(3)<0) || (e_buffer(3)*e_buffer(6)<0)
        if abs(e_buffer(1)) >= M2
            u(k) = u_buffer(1) + k1*(kp*e_buffer(3) + ki*e_buffer(1) + kd*(e_buffer(3)-e_buffer(6)));%如果误差到达极值，误差还较大，就增强PID控制
        else
            u(k) = u_buffer(1) + k2*(kp*e_buffer(3) + ki*e_buffer(1) + kd*(e_buffer(3)-e_buffer(6)));%如果误差到达极值，误差不太大，就削弱PID控制
        end
    else
        u(k) = u_buffer(1) + kp*e_buffer(3) + ki*e_buffer(1) + kd*(e_buffer(1)+e_buffer(5)-2*e_buffer(4));
    end
%     控制器输出限幅
    if u(k) > upper_limit
        u(k) = upper_limit;
    elseif u(k) < lower_limit
        u(k) = lower_limit;
    end
        
    for i = numd_length:-1:2
        u_buffer(i) = u_buffer(i-1);
    end
    u_buffer(1) = u(k);%更新系统输入队列
    
    %更新误差数据
    e_buffer(5) = e_buffer(4);%更新上上次误差
    e_buffer(4) = e_buffer(1);%更新上次误差
    e_buffer(6) = e_buffer(3);%更新上次误差微分
    
    %更新系统输出
    dend_adder = 0;
    for i = 2:1:dend_length
        dend_adder = dend_adder + dend(i)*y_buffer(i-1);
    end
    numd_adder = 0;
    for i = 1:1:numd_length
        numd_adder = numd_adder + numd(i)*u_buffer(i);
    end
    y(k) = (-dend_adder + numd_adder)/dend(1);%更新系统输出
    
    for i = dend_length:-1:2
        y_buffer(i) = y_buffer(i-1);
    end
    y_buffer(1) = y(k);%更新系统输出队列
end

%% 5 静态性能计算
fprintf('稳态性能:\n');

stable_error = y_set(loop_counter)*0.05;% 5%误差带

stable_index = loop_counter;
for i = loop_counter:-1:(1/ts)
    if (abs(y(i)-y_set(i))>stable_error)
        stable_index = i;
        stable_time = stable_index*ts;
        break;
    end
end%查找最早合适进入误差带

if stable_index == loop_counter%判断是否曾进入稳态
    fprintf('未达到稳态\n');
else
    fprintf('调整时间为%.3f s\n',stable_time);
    sum = 0;
    for i = stable_index:1:loop_counter
        sum = sum + y(i);
    end%求稳态后系统输出总和
    stable_value = sum/(loop_counter-stable_index);%求稳态后系统输出平均值
    stable_error = abs(stable_value - y_set(loop_counter));%求稳态误差
    fprintf('稳态误差为%.5f\n',stable_error);
end

%% 6 动态性能计算
fprintf('动态性能:\n');
tr = loop_counter*ts;
for i = (1/ts):1:loop_counter-1
    if  (y(i) <= y_set(loop_counter)) && (y(i+1) >= y_set(loop_counter))
        tr = i*ts - 1;
        break;
    end
end%求上升时间
[Mp,tpindex] = max(y);%求输出最大值和最大值的索引
tp = tpindex*ts-1;%求峰值时间
if tr ~= loop_counter*ts
    fprintf('上升时间为%.3f s\n',tr);
else
    fprintf('无上升时间\n');
end
if Mp > y_set
    fprintf('超调量为%.3f%%\n',(Mp-y_set)/y_set*100);
    fprintf('峰值时间为%.3f s\n',tp);
else
    fprintf('无超调量\n');
    fprintf('无峰值时间\n');
end

%% 7 绘图显示
figure(1);
plot(run_time,y_set,'k');%给定曲线
hold on;
plot(run_time,y,'r');%响应曲线
y_max = max(max(y_set),Mp);
y_min = min(y);
axis([0,t_run*1.2,y_min,y_max*1.1]);
grid on;
title('系统响应曲线',['kp=',num2str(kp),',ki=',num2str(ki),',kd=',num2str(kd)]);
xlabel('时间t/s');
ylabel('系统输出');
legend('给定','响应');

figure(2);
plot(run_time,y_set-y,'k');%误差曲线
hold on;
plot(run_time,u,'r');%控制曲线
y_max = max(max(y_set-y),max(u));
y_min = min(min(y_set-y),min(u));
axis([0,t_run*1.2,y_min,y_max*1.1]);
grid on;
title('控制器曲线',['kp=',num2str(kp),',ki=',num2str(ki),',kd=',num2str(kd)]);
xlabel('时间t/s');
ylabel('控制输出');
legend('误差','控制输出');




