#ifndef _DISP_H
#define _DISP_H

#include "headfile.h"

#define PA XBYTE[0x7F01]	   //PA地址，控制数码管
#define PC XBYTE[0X7F03]
#define commond XBYTE[0x7F00]  //控制位地址

void Disp_Init();
void Disp_Dig(unsigned char channel, unsigned char adc_value);

#endif