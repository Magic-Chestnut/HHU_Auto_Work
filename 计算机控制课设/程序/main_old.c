//#include "reg52.h"
//#include "headfile.h"

//uint ad_channel=0xbf00;
//#define commond XBYTE[0x7F00]  //����λ��ַ
//#define PA XBYTE[0x7F01]	   //PA��ַ�����������
//#define PB XBYTE[0x7F02]	   //PB��ַ
//#define PC XBYTE[0X7F03]
//#define dac_channel XBYTE[0XF500]  //DAC�Ĵ���
//sbit EOC=P3^0;
//#define AD_IN XBYTE[ad_channel] //ADת��ͨ��ѡ��
//uchar miao=0;	//������
//uchar time0_cnt=0; //���ڶ�ʱ��ͳ�ƽ��뼸��
//void init();  //��ʱ����ʼ��
//void smgshow();//�������ʾ
//void adc();
//uchar  adc1=0;  //adcת���Ľ��
//void dac();
//sbit  mode=P2^2; //�����Զ�ģʽ���ֶ�ģʽ
//#define num 12

//uchar exe(uchar i)
//{
//	uint adc2=0;
//	switch(i)
//	{
//		case 0: adc();break;//���˲�
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
//			adc1=exe(0);  //adת�����˲�
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
//	dac_channel=0;   //daת����ʼ�ı�־
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
//��ʼ����ʱ��
//void init(void)
//{
//	TMOD=0x11;	 //��ʱ��ģʽ
//	TH0=(65536-50000)/256;	 //��ʼֵ,50ms
//	TL0=(65536-50000)%256;
//	EA=1;	//�ж��ܿ���
//	ET0=1;	//��ʱ���жϿ���
//	TR0=1;	//��ʱ������
//}

//��ʱ��0ִ�к���
//void T0_time()interrupt 1
//{
//	TH0=(65536-50000)/256;	//��ʼֵ,50ms
//	TL0=(65536-50000)%256;
//	
//	time0_cnt++;   //��ʱ������һ��
//	
//	if(time0_cnt>=20)  //50ms*20 = 1S������1S����һ��
//	{
//		time0_cnt=0;//���¼���
//		miao++;	//���1
//		ad_channel++;
//		if(miao>=8)
//		{
//			miao=0;	 //�����
//			ad_channel=0xbf00;
//		}
//	}
//}