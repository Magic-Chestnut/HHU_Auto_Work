#include "reg52.h"
#include "headfile.h"

sbit  mode_key = P2^2; //�ֶ����Զ��л�����
bit mode = 0;//0�ֶ� 1�Զ�

void Mode_Read()
{
	mode = mode_key;
}