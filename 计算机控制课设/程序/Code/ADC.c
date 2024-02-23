#include "reg52.h"
#include "headfile.h"

#define AD_IN XBYTE[ad_channel] //AD转化通道选择

sbit EOC=P3^0;

uint ad_channel=0xbf00;

uchar  adc_value=0;  //adc转化的结果

void Read_Adc()
{
	uchar adc_temp;
	AD_IN = 0;
	while(EOC==0);
	adc_temp = AD_IN;
	adc_value = adc_temp*10/51;
}

void Change_Channel()
{
	channel=P1&0X0F;
	ad_channel=(ad_channel&0xfff0)+channel;
}