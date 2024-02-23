%% -1 脚本说明：
%各种滤波算法效果测试

%% 0 脚本环境初始化：
clear;%清除工作空间所有 变量、函数、文件
clc;%清空命令窗口
close all;%关闭所有figure

%% 1 生成含真实数据、噪声、观测数据
t = 0:0.01:1.49;%生成一段时间t
L = length(t);%计算时间序列长度
x1 = zeros(1,L);%初始化真实数据x1
x2 = zeros(1,L);%初始化真实数据x2
for i = 1:L
    x1(i) = 0;%设x1为常量
    x2(i) = sin(2*t(i));%设x2为正弦函数
end

n1 = zeros(1,L);%初始化噪声n1
n2 = zeros(1,L);%初始化噪声n2
for i = 1:L
    n1(i) = normrnd(0,0.1);%设n1为高斯噪声N（0，0.1）
    n2(i) = normrnd(0.1,0.1);%设n2为偏置高斯噪声N（0.1，0.1）
end

y11 = t;%初始化观测数据y11
y12 = t;%初始化观测数据y12
y21 = t;%初始化观测数据y21
y22 = t;%初始化观测数据y22
for i = 1:L
    y11(i) = x1(i) + n1(i);%生成观测信号y11
    y12(i) = x1(i) + n2(i);%生成观测信号y12
    y21(i) = x2(i) + n1(i);%生成观测信号y21
    y22(i) = x2(i) + n2(i);%生成观测信号y22
end

%% 2 显示数据曲线
figure(1);%创建第一个图片
subplot(2,2,1);%创建第一个图像
plot(t(1,:),x1(1,:),'k-','LineWidth',1);    %显示真实数据
hold on;
plot(t(1,:),y11(1,:),'b-','LineWidth',1);    %显示观测数据
axis([0,2,-0.3,0.3]);
title('定值叠加无偏置高斯噪声');
xlabel('时间');
ylabel('数值');
hold on;
subplot(2,2,2);%创建第二个图像
plot(t(1,:),x1(1,:),'k-','LineWidth',1.5);     %显示真实数据
hold on;
plot(t(1,:),y12(1,:),'b-','LineWidth',1.5);    %显示观测数据
axis([0,2,-0.2,0.4]);
title('定值叠加有偏置高斯噪声');
xlabel('时间');
ylabel('数值');
hold on;
subplot(2,2,3);%创建第三个图像
plot(t(1,:),x2(1,:),'k','LineWidth',1.5);    %显示真实数据
hold on;
plot(t(1,:),y21(1,:),'k','LineWidth',1.5);    %显示观测数据
axis([0,2,-0.5,1.5]);
title('正弦值叠加无偏置高斯噪声');
xlabel('时间');
ylabel('数值');
hold on;
subplot(2,2,4);%创建第四个图像
plot(t(1,:),x2(1,:),'k','LineWidth',1.5);    %显示真实数据
hold on;
plot(t(1,:),y22(1,:),'k','LineWidth',1.5);    %显示观测数据
axis([0,2,-0.5,1.5]);
title('正弦值叠加有偏置高斯噪声');
xlabel('时间');
ylabel('数值');
hold on;

%% 4 应用滤波算法
%1限幅、2限速、3中位数、4算数平均、5滑动平均、6加权递推平均、7限幅平均、8一阶滞后、9消抖、10限幅消抖、11卡尔曼
data_filtered111 = Limiting_Filter(y11,0.04);
data_filtered112 = Median_Filter(y11,3);
data_filtered113 = Average_Filter(y11,3);
data_filtered114 = MovingAverage_Filter(y11,3);
data_filtered115 = FirstOrderLag_Filter(y11,0.6);
data_filtered116 = WeightedMovingAverage_Filter(y11,5,[0.4,0.3,0.2,0.1,0]);
data_filtered117 = Glitch_Filter(y11,3);
data_filtered118 = LimitingGlitch_Filter(y11,0.06,3);
data_filtered119 = LimitingAverage_Filter(y11,3,0.06);
data_filtered1110 = SpeedLimit_Filter(y11,0.01);

data_filtered121 = Limiting_Filter(y12,0.04);
data_filtered122 = Median_Filter(y12,3);
data_filtered123 = Average_Filter(y12,3);
data_filtered124 = MovingAverage_Filter(y12,3);
data_filtered125 = FirstOrderLag_Filter(y12,0.6);
data_filtered126 = WeightedMovingAverage_Filter(y12,5,[0.4,0.3,0.2,0.1,0]);
data_filtered127 = Glitch_Filter(y12,3);
data_filtered128 = LimitingGlitch_Filter(y12,0.06,3);
data_filtered129 = LimitingAverage_Filter(y12,3,0.06);
data_filtered1210 = SpeedLimit_Filter(y12,0.01);

data_filtered211 = Limiting_Filter(y21,0.04);
data_filtered212 = Median_Filter(y21,3);
data_filtered213 = Average_Filter(y21,3);
data_filtered214 = MovingAverage_Filter(y21,3);
data_filtered215 = FirstOrderLag_Filter(y21,0.6);
data_filtered216 = WeightedMovingAverage_Filter(y21,5,[0.4,0.3,0.2,0.1,0]);
data_filtered217 = Glitch_Filter(y21,3);
data_filtered218 = LimitingGlitch_Filter(y21,0.08,3);
data_filtered219 = LimitingAverage_Filter(y21,3,0.08);
data_filtered2110 = SpeedLimit_Filter(y21,0.01);

data_filtered221 = Limiting_Filter(y22,0.04);
data_filtered222 = Median_Filter(y22,3);
data_filtered223 = Average_Filter(y22,3);
data_filtered224 = MovingAverage_Filter(y22,3);
data_filtered225 = FirstOrderLag_Filter(y22,0.6);
data_filtered226 = WeightedMovingAverage_Filter(y22,5,[0.4,0.3,0.2,0.1,0]);
data_filtered227 = Glitch_Filter(y22,3);
data_filtered228 = LimitingGlitch_Filter(y22,0.08,3);
data_filtered229 = LimitingAverage_Filter(y22,3,0.08);
data_filtered2210 = SpeedLimit_Filter(y22,0.01);

%% 5 显示滤波效果
figure(1);%创建第一个图片
subplot(2,2,1);%创建第一个图像
% plot(t(1,:),data_filtered111(1,:),'r','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered1110(1,:),'g','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered112(1,:),'y','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered113(1,:),'c','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered114(1,:),'m','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered116(1,:),'color',[1,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered119(1,:),'color',[0.5,0.5,0.5],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered115(1,:),'color',[0.5,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered117(1,:),'color',[0,0.5,0],'LineWidth',1);    %显示
% hold on;
plot(t(1,:),data_filtered118(1,:),'color',[0,0,0.5],'LineWidth',1);    %显示
hold on;
% legend('真实信号','观测信号','限幅滤波','限速滤波','中位数滤波','算数平均滤波','滑动平均滤波','加权递推平均滤波','限幅平均滤波','一阶滞后滤波','消抖滤波','限幅消抖滤波','卡尔曼滤波');
legend('真实信号','观测信号','限幅消抖滤波');

subplot(2,2,2);%创建第二个图像
% plot(t(1,:),data_filtered121(1,:),'r','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered1210(1,:),'g','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered122(1,:),'y','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered123(1,:),'c','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered124(1,:),'m','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered126(1,:),'color',[1,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered129(1,:),'color',[0.5,0.5,0.5],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered125(1,:),'color',[0.5,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered127(1,:),'color',[0,0.5,0],'LineWidth',1);    %显示
% hold on;
plot(t(1,:),data_filtered128(1,:),'color',[0,0,0.5],'LineWidth',1);    %显示
hold on;
% legend('真实信号','观测信号','限幅滤波','限速滤波','中位数滤波','算数平均滤波','滑动平均滤波','加权递推平均滤波','限幅平均滤波','一阶滞后滤波','消抖滤波','限幅消抖滤波','卡尔曼滤波');
legend('真实信号','观测信号','限幅消抖滤波');

subplot(2,2,3);%创建第三个图像
% plot(t(1,:),data_filtered211(1,:),'r','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered2110(1,:),'g','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered212(1,:),'y','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered213(1,:),'c','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered214(1,:),'m','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered216(1,:),'color',[1,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered219(1,:),'color',[0.5,0.5,0.5],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered215(1,:),'color',[0.5,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered217(1,:),'color',[0,0.5,0],'LineWidth',1);    %显示
% hold on;
plot(t(1,:),data_filtered218(1,:),'color',[0,0,0.5],'LineWidth',1);    %显示
hold on;
% legend('真实信号','观测信号','限幅滤波','限速滤波','中位数滤波','算数平均滤波','滑动平均滤波','加权递推平均滤波','限幅平均滤波','一阶滞后滤波','消抖滤波','限幅消抖滤波','卡尔曼滤波');
legend('真实信号','观测信号','限幅消抖滤波');

subplot(2,2,4);%创建第四个图像
% plot(t(1,:),data_filtered221(1,:),'r','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered2210(1,:),'g','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered222(1,:),'y','LineWidth',1);    %
% hold on;
% plot(t(1,:),data_filtered223(1,:),'c','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered224(1,:),'m','LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered226(1,:),'color',[1,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered229(1,:),'color',[0.5,0.5,0.5],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered225(1,:),'color',[0.5,0,0],'LineWidth',1);    %显示
% hold on;
% plot(t(1,:),data_filtered227(1,:),'color',[0,0.5,0],'LineWidth',1);    %显示
% hold on;
plot(t(1,:),data_filtered228(1,:),'color',[0,0,0.5],'LineWidth',1);    %显示
hold on;
% legend('真实信号','观测信号','限幅滤波','限速滤波','中位数滤波','算数平均滤波','滑动平均滤波','加权递推平均滤波','限幅平均滤波','一阶滞后滤波','消抖滤波','限幅消抖滤波','卡尔曼滤波');
legend('真实信号','观测信号','限幅消抖滤波');
%% 3 编写滤波算法
function [data_filtered] = Limiting_Filter(data_raw, limit_threshold)%限幅滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    data_filtered(1) = data_raw(1);
    for i = 2:data_length
        data_filtered(i) = data_raw(i);
        if abs(data_raw(i) - data_raw(i-1)) > limit_threshold
            data_filtered(i) = data_filtered(i-1);
        end
    end
end

function [data_filtered] = Median_Filter(data_raw, buffer_size)%中位数滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    data_buffer = zeros(1,buffer_size);
    for i = 1:buffer_size-1
        data_filtered(i) = data_raw(i);
    end
    for i = buffer_size:data_length
        data_buffer = sort(data_raw(:,i-buffer_size+1:i));
        data_filtered(i) = data_buffer((buffer_size+1)/2);
    end
end

function [data_filtered] = Average_Filter(data_raw, buffer_size)%算数平均滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    for i = buffer_size:buffer_size:data_length
        sum = 0;
        for j = i-buffer_size+1:i
            sum = sum + data_raw(j);
        end
        for j = i-buffer_size+1:i
            data_filtered(j) = sum/buffer_size;
        end
        if i > data_length - buffer_size + 1
            sum = 0;
            for j = i:data_length
                sum = sum  + data_raw(j);
            end
            for j = i:data_length
                data_filtered(i) = sum/(data_length-i+1);
            end
        end
    end
end

function [data_filtered] = MovingAverage_Filter(data_raw, buffer_size)%滑动平均滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    for i = 1:buffer_size-1
        data_filtered(i) = data_raw(i);
    end
    for i = buffer_size:data_length
        data_filtered(i) = mean(data_raw(:,i-buffer_size+1:i));
    end
end

function [data_filtered] = FirstOrderLag_Filter(data_raw, ratio)%一阶滞后滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    data_filtered(1) = data_raw(1);
    for i = 2:data_length
        data_filtered(i) = ratio*data_raw(i) + (1-ratio)*data_filtered(i-1);
    end
end

function [data_filtered] = WeightedMovingAverage_Filter(data_raw, buffer_size, ratio_buffer)%滑动平均滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    for i = 1:buffer_size-1
        data_filtered(i) = data_raw(i);
    end
    for i = buffer_size:data_length
        for j = 1:buffer_size
            data_filtered(i) = data_filtered(i) + ratio_buffer(j)*data_raw(i-j+1);
        end
    end
end

function [data_filtered] = Glitch_Filter(data_raw, buffer_size)%消抖滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    data_value = data_raw(1);
    buffer_counter = 0;
    for i = 2:data_length
        if data_raw(i) ~= data_value
            buffer_counter = buffer_counter + 1;
            if buffer_counter >= buffer_size
            	data_value = data_raw(i);
                buffer_counter = 0;
            end
        end
        data_filtered(i) = data_value;
    end           
end

function [data_filtered] = LimitingGlitch_Filter(data_raw, limit_threshold, buffer_size)%限幅消抖滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    data_filtered(1) = data_raw(1);
    data_value = data_raw(1);
    buffer_counter = 0;
    for i = 2:data_length
        data_filtered(i) = data_raw(i);
        if abs(data_raw(i) - data_filtered(i-1)) > limit_threshold
            data_filtered(i) = data_filtered(i-1);    
        end
        if data_filtered(i) ~= data_value
            buffer_counter = buffer_counter + 1;
            if buffer_counter >= buffer_size
            	data_value = data_filtered(i);
                buffer_counter = 0;
            end
        end
        data_filtered(i) = data_value;
    end
end

function [data_filtered] = LimitingAverage_Filter(data_raw, buffer_size, limit_threshold)%限幅平均滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    data_filtered(1) = data_raw(1);
    for i = 2:data_length
        data_filtered(i) = data_raw(i);
        if abs(data_raw(i) - data_filtered(i-1)) > limit_threshold
            data_filtered(i) = data_raw(i-1);    
        end
        if i >= buffer_size
            data_filtered(i) = mean(data_filtered(:,i-buffer_size+1:i));
        end
    end
end

function [data_filtered] = SpeedLimit_Filter(data_raw, limit_threshold)%限速滤波
    data_length = length(data_raw);
    data_filtered = zeros(1,data_length);
    for i = 1:2
        data_filtered(i) = data_raw(i);
    end
    for i = 3:data_length
        if abs(data_raw(i-1) - data_raw(i-2)) <= limit_threshold
            data_filtered(i) = data_raw(i-1);
        elseif abs(data_raw(i) - data_raw(i-1)) <= limit_threshold
            data_filtered(i) = data_raw(i);
        else
            data_filtered(i) = (data_raw(i) + data_raw(i-1))/2;
        end
    end
end