#include "reg52.h"
#include "headfile.h"

uchar channel = 0;
bit AdGet_Flag = 0;

void Timer0_Init(void)
{
	TMOD=0x11;	 //定时器模式
	TH0=(65536-50000)/256;	 //初始值,50ms
	TL0=(65536-50000)%256;
	EA=1;	//中断总开关
	ET0=1;	//定时器中断开启
	TR0=1;	//定时器开启
}

void Timer0_Server()interrupt 1
{
//	static uchar time0_cnt=0; //用于定时器统计进入几次
	static uchar cnt_100ms;
	static uchar cnt_6times;
	
	TH0=(65536-50000)/256;	//初始值,50ms
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