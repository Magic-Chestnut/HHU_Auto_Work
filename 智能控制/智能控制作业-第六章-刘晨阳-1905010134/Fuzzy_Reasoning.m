%% -1 脚本说明：
%提供模糊推理程序范式

%% 0 脚本环境初始化：
clear;%清除工作空间所有 变量、函数、文件
clc;%清空命令窗口
close all;%关闭所有figure

%% 1 定义输入输出语言变量
fis = mamfis();
fis = addInput(fis,[1,10],'Name','Service');
fis = addOutput(fis,[0,30],'Name','Tip');

%% 2 在输入输出语言变量的论域上定义语言值和对应的隶属函数
fis = addMF(fis,"Service","trimf",[1,1,4.5],'Name',"差");
fis = addMF(fis,"Service","trimf",[2.5,5.5,8.5],'Name',"一般");
fis = addMF(fis,"Service","trimf",[6.5,10,10],'Name',"好");
fis = addMF(fis,"Tip","trimf",[0,0,12],'Name',"低");
fis = addMF(fis,"Tip","trimf",[8,15,22],'Name',"中等");
fis = addMF(fis,"Tip","trimf",[18,30,30],'Name',"高");
figure(1);
plotmf(fis,"input",1);
title('输入语言变量');
xlabel('输入值');
ylabel('隶属度');
figure(2);
plotmf(fis,"output",1);
title('输出语言变量');
xlabel('输出值');
ylabel('隶属度');

%% 3 定义模糊推理规则
rule1 = "Service==差 => Tip=低";
rule2 = "Service==一般 => Tip=中等";
rule3 = "Service==好 => Tip=高";
rules = [rule1,rule2,rule3];
fis = addRule(fis,rules);
showrule(fis)

%% 4 计算模糊推理结果
figure(3);
plotfis(fis);%模糊推理系统结构
ruleview(fis)%模糊推理交互界面



