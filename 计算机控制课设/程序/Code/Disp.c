#include "reg52.h"
#include "headfile.h"

void Disp_Init()
{
	commond=0x0d;
}

void Disp_Dig(uchar channel, uchar adc_value)
{
	uchar adc_disp;
	adc_disp = (adc_value/10)*16 + adc_value%10;
	PC = channel;
	PA = adc_disp;
}
