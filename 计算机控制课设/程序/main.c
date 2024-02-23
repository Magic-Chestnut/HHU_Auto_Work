#include "reg52.h"
#include "headfile.h"

void All_Init();
void Task_Handler();
void Task_Auto();
void Task_Manual();

void main()
{
	All_Init();
	while(1)
	{
		Task_Handler();
	}
}

void All_Init()
{
	filter_type = 2;//滤波器类型初始化
	Disp_Init();//数码管显示初始化
	Timer0_Init();//定时器初始化
}

void Task_Handler()
{
	Mode_Read();//读取按键
	if(mode == 1)//自动模式
	{
		Task_Auto();
	}
	else//手动模式
	{
		Task_Manual();
	}
}

void Task_Auto()
{
	if(AdGet_Flag == 1)//判断AD定时读取标志
	{
		TR0 = 0;
		ET0 = 0;//关闭定时器及中断
		AdGet_Flag = 0;//AD定时读取标志清零
		Read_Adc();//读取AD值
		Filter_Choose(filter_type);//滤波器选择
		DA_Out();//DA输出
		Disp_Dig(channel, data_filtered);//数码管显示
		ET0 = 1;
		TR0 = 1;//开启定时器及中断
	}
}

void Task_Manual()
{
	if(AdGet_Flag == 1)
	{
		TR0 = 0;
		ET0 = 0;
		Change_Channel();//手动改变通道
		Read_Adc();
		Filter_Choose(filter_type);
		DA_Out();
		Disp_Dig(channel, data_filtered);
		ET0 = 1;
		TR0 = 1;
	}
}
