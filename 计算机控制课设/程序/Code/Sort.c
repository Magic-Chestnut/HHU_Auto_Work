#include "reg52.h"
#include "headfile.h"

void Bubble_Sort(uchar arr[], uchar len) 
{
	int i, j, temp;
	for (i = 0; i < len - 1; i++)
	{
		for (j = 0; j < len - 1 - i; j++)
		{
			if (arr[j] > arr[j + 1]) 
				{
					temp = arr[j];
					arr[j] = arr[j + 1];
					arr[j + 1] = temp;
        }
		}
	}
}

uchar Mid_Sort(uchar arr[], uchar len)
{
	uchar data_temp;
	
	Bubble_Sort(arr,len);
	
	if(len%2 == 1)
	{
		data_temp = arr[(len-1)/2];
	}
	else
	{
		data_temp = (arr[len/2] + arr[len/2-1])/2;
	}
	
	return data_temp;
}