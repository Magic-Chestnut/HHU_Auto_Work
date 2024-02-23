#include "reg52.h"
#include "headfile.h"

sbit  mode_key = P2^2; //手动、自动切换按键
bit mode = 0;//0手动 1自动

void Mode_Read()
{
	mode = mode_key;
}