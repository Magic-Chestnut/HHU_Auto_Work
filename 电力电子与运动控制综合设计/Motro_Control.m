%% -1 脚本说明：
%转速电流双闭环电机调速

%% 0 脚本环境初始化：
clear;%清除工作空间所有 变量、函数、文件
clc;%清空命令窗口
close all;%关闭所有figure

%% 1 加载仿真数据
% Speed_Set = 150;
% Speed_Set = 500;
% Speed_Set = 1000;
Speed_Set = 1200;
% Speed_Set = 1500;
% Disterb_Switch = 0;
Disterb_Switch = 1;
% open_system('Motor_Control');
set_param('Motor_Control/Step3','After',num2str(Speed_Set));
set_param('Motor_Control/Gain6','Gain',num2str(Disterb_Switch));

%% 2 读取仿真数据
simtime = 12;
sim('Motor_Control',[0,simtime]);                %开启仿真
load('Motor_Control.mat');                       %读取仿真结果

%% 3 显示响应曲线
figure(1);
plot(motor_response(1,:),motor_response(2,:),'k','LineWidth',1.5);    %转速指令
hold on;
plot(motor_response(1,:),motor_response(3,:),'r','LineWidth',1.5);    %转速响应
axis([0,simtime,0,1.2*Speed_Set]);
title('电机转速响应曲线');
xlabel('时间t/s');
ylabel('转速n/r/min');
legend('转速指令','转速响应');

figure(2);
plot(motor_response(1,:),motor_response(4,:),'k','LineWidth',1.5);    %电流指令
hold on;
plot(motor_response(1,:),motor_response(5,:),'r','LineWidth',1.5);    %电流响应
axis([0,simtime,0,140]);
title('电流响应曲线');
xlabel('时间t/s');
ylabel('电流A');
legend('电流指令','电流响应');

%% 4 静态性能分析
fprintf('稳态性能\n');
Total_length = length(motor_response);                           %序列长度
Total_time = motor_response(1,Total_length);                     %总时长

stable_error = Speed_Set*0.05;

stable_index = Total_length;
for i = 2:1:Total_length
    temp_now = motor_response(3,i);
    temp_last = motor_response(3,i-1);
    if ((abs(temp_now-Speed_Set)<=stable_error)&&(abs(temp_last-Speed_Set)>stable_error)&&(abs(motor_response(3,Total_length)-Speed_Set)<=stable_error))
        stable_index = i;
        stable_time = motor_response(1,stable_index)-1;
    end
end

if stable_index == Total_length
    fprintf('未达到稳态\n');
else
    fprintf('调整时间为%.3f\n',stable_time);
    sum = 0;
    for i = stable_index:1:Total_length
        sum = sum + motor_response(3,i);
    end
    stable_value = sum/(Total_length-stable_index);
    stable_error = abs(stable_value - Speed_Set);
     fprintf('稳态误差为%.3f\n',stable_error);
end
    
%% 5 动态性能分析
fprintf('动态性能\n');
[Mp,tpindex] = max(motor_response(3,:));
tp = motor_response(1,tpindex) - 1;
if Mp > Speed_Set
    fprintf('超调量为%.3f%%\n',(Mp-Speed_Set)/Speed_Set*100);
    fprintf('峰值时间为%.3f\n',tp);
else
    fprintf('无超调量\n');
    fprintf('无峰值时间\n');
end





