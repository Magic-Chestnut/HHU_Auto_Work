#include "reg52.h"
#include "headfile.h"

#define DAC 0xF5FF

void DA_Out()
{
////	PA=adc_value;  
//	PA=data_filtered; 	
//	dac_channel=0;   //da转化开始的标志
////	PA=	adc_value%10+(adc_value/10)*16;
//	PA=	data_filtered%10+(data_filtered/10)*16;
	
	PA=adc_value;
	XBYTE[DAC] = 0xff;
}