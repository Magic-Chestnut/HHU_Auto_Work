#ifndef _ADC_H
#define _ADC_H

#include "headfile.h"

extern uchar  adc_value;
extern uint ad_channel;

void Read_Adc();
void Change_Channel();

#endif