#ifndef _DISP_H
#define _DISP_H

#include "headfile.h"

#define PA XBYTE[0x7F01]	   //PA��ַ�����������
#define PC XBYTE[0X7F03]
#define commond XBYTE[0x7F00]  //����λ��ַ

void Disp_Init();
void Disp_Dig(unsigned char channel, unsigned char adc_value);

#endif