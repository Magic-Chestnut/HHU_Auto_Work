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
	filter_type = 2;//�˲������ͳ�ʼ��
	Disp_Init();//�������ʾ��ʼ��
	Timer0_Init();//��ʱ����ʼ��
}

void Task_Handler()
{
	Mode_Read();//��ȡ����
	if(mode == 1)//�Զ�ģʽ
	{
		Task_Auto();
	}
	else//�ֶ�ģʽ
	{
		Task_Manual();
	}
}

void Task_Auto()
{
	if(AdGet_Flag == 1)//�ж�AD��ʱ��ȡ��־
	{
		TR0 = 0;
		ET0 = 0;//�رն�ʱ�����ж�
		AdGet_Flag = 0;//AD��ʱ��ȡ��־����
		Read_Adc();//��ȡADֵ
		Filter_Choose(filter_type);//�˲���ѡ��
		DA_Out();//DA���
		Disp_Dig(channel, data_filtered);//�������ʾ
		ET0 = 1;
		TR0 = 1;//������ʱ�����ж�
	}
}

void Task_Manual()
{
	if(AdGet_Flag == 1)
	{
		TR0 = 0;
		ET0 = 0;
		Change_Channel();//�ֶ��ı�ͨ��
		Read_Adc();
		Filter_Choose(filter_type);
		DA_Out();
		Disp_Dig(channel, data_filtered);
		ET0 = 1;
		TR0 = 1;
	}
}
