#include "reg52.h"
#include "headfile.h"

uchar channel = 0;
bit AdGet_Flag = 0;

void Timer0_Init(void)
{
	TMOD=0x11;	 //��ʱ��ģʽ
	TH0=(65536-50000)/256;	 //��ʼֵ,50ms
	TL0=(65536-50000)%256;
	EA=1;	//�ж��ܿ���
	ET0=1;	//��ʱ���жϿ���
	TR0=1;	//��ʱ������
}

void Timer0_Server()interrupt 1
{
//	static uchar time0_cnt=0; //���ڶ�ʱ��ͳ�ƽ��뼸��
	static uchar cnt_100ms;
	static uchar cnt_6times;
	
	TH0=(65536-50000)/256;	//��ʼֵ,50ms
	TL0=(65536-50000)%256;
	
	if(++cnt_100ms == 2)
	{
		cnt_100ms = 0;
		AdGet_Flag = 1;
		cnt_6times ++;
	}
	
	if(cnt_6times == 7)
	{
		cnt_6times = 0;
		if(++channel == 8)
		{
			channel = 0;
			ad_channel=0xbf00;
		}
	}
}