//#include "reg52.h"
//#include "headfile.h"

//uint ad_channel=0xbf00;
//#define commond XBYTE[0x7F00]  //控制位地址
//#define PA XBYTE[0x7F01]	   //PA地址，控制数码管
//#define PB XBYTE[0x7F02]	   //PB地址
//#define PC XBYTE[0X7F03]
//#define dac_channel XBYTE[0XF500]  //DAC寄存器
//sbit EOC=P3^0;
//#define AD_IN XBYTE[ad_channel] //AD转化通道选择
//uchar miao=0;	//设置秒
//uchar time0_cnt=0; //用于定时器统计进入几次
//void init();  //定时器初始化
//void smgshow();//数码管显示
//void adc();
//uchar  adc1=0;  //adc转化的结果
//void dac();
//sbit  mode=P2^2; //定义自动模式和手动模式
//#define num 12

//uchar exe(uchar i)
//{
//	uint adc2=0;
//	switch(i)
//	{
//		case 0: adc();break;//不滤波
//	}
//	return adc1;
//}
//void main()
//{

//	init();
////	commond=0x0d;//
//	while(1)
//	{
//		if(mode==1)
//		{
//			adc1=exe(0);  //ad转化，滤波
//	   smgshow();
//		 dac();
//			EA=1;
//		}
//		else
//		{
//			EA=0;
////			miao=P1&0X0F;
////			ad_channel=(ad_channel&0xfff0)+miao;
//			adc1=exe(0);
//	    smgshow();
//		  dac();
//		}

//	}
//}

//void dac()
//{
//	PA=adc1;   
//	dac_channel=0;   //da转化开始的标志
//	PA=	adc1%10+(adc1/10%10)*16;
//	
//}
//void adc()
//{
//	AD_IN=0;
//	while(EOC==0);
//	adc1=AD_IN;
//}
//void smgshow()
//{
//	//PA=	adc1%10+(adc1/10%10)*16;
//	adc1 = adc1*10/51;
//	PA=	adc1%10+(adc1/10)*16;
//	PC=miao;
//}
//初始化定时器
//void init(void)
//{
//	TMOD=0x11;	 //定时器模式
//	TH0=(65536-50000)/256;	 //初始值,50ms
//	TL0=(65536-50000)%256;
//	EA=1;	//中断总开关
//	ET0=1;	//定时器中断开启
//	TR0=1;	//定时器开启
//}

//定时器0执行函数
//void T0_time()interrupt 1
//{
//	TH0=(65536-50000)/256;	//初始值,50ms
//	TL0=(65536-50000)%256;
//	
//	time0_cnt++;   //定时器进入一次
//	
//	if(time0_cnt>=20)  //50ms*20 = 1S，所以1S进入一次
//	{
//		time0_cnt=0;//重新计数
//		miao++;	//秒加1
//		ad_channel++;
//		if(miao>=8)
//		{
//			miao=0;	 //清除秒
//			ad_channel=0xbf00;
//		}
//	}
//}