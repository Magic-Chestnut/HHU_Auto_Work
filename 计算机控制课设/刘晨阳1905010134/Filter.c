#include "reg52.h"
#include "headfile.h"

uchar data_filtered;
xdata float ratio_buffer[3] = {0.6,0.3,0.1};
uchar filter_type = 11;

uchar SpeedLimit_Filter(uchar data_raw, uchar limit_threshold)//限速滤波
{
	static uchar data_buff[3];
	static uchar income_times;
	uchar data_temp;
	
	if(income_times<3)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		data_buff[0] = data_buff[1];
		data_buff[1] = data_buff[2];
		data_buff[2] = data_raw;
	}
	
	if(income_times<3)
	{
		data_temp = data_buff[2];
	}
	else
	{
		if(abs(data_buff[1] - data_buff[0]) <= limit_threshold)
		{
			data_temp = data_buff[1]; 
		}
		else
		{
			if(abs(data_buff[1] - data_buff[0]) > limit_threshold)
			{
				data_temp = (data_buff[2] + data_buff[1])/2;
			}
			else
			{
				data_temp = data_buff[2]; 
			}
		}
	}
	return data_temp;
}

uchar Limiting_Filter(uchar data_raw, uchar limit_threshold)//限幅滤波
{
	static uchar data_buff[2];
	static uchar income_times;
	uchar data_temp;
	
	if(income_times<2)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		data_buff[0] = data_buff[1];
		data_buff[1] = data_raw;
	}
	
	if(abs(data_buff[1] - data_buff[0]) <= limit_threshold)
	{
		data_temp = data_buff[1];
	}
	else
	{
		data_buff[1] = data_buff[0];
		data_temp = data_buff[1];
	}
	return data_temp;
}

uchar Median_Filter(uchar data_raw, uchar buffer_size)//中位数滤波
{
	static uchar data_buff[5];
	static uchar income_times;
	uchar data_temp;
	uchar i;
	
	if(income_times<buffer_size)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		for(i=0;i<income_times-1;income_times++)
		{
			data_buff[i] = data_buff[i+1];
		}
		data_buff[income_times-1] = data_raw;
	}
	
	if(income_times<buffer_size)
	{
		data_temp = data_buff[income_times];
	}
	else
	{
		data_temp = Mid_Sort(data_buff,buffer_size);
	}
	
	return data_temp;
}

uchar Average_Filter(uchar data_raw, uchar buffer_size)//算数平均滤波
{
	static uchar data_buff[5];
	static uchar income_times;
	static uchar load_times;
	static uchar data_temp;
	uchar i;
	uchar sum = 0;
	
	if(income_times<buffer_size)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		for(i=0;i<income_times-1;income_times++)
		{
			data_buff[i] = data_buff[i+1];
		}
		data_buff[income_times-1] = data_raw;
	}
	
	if(income_times<buffer_size)
	{
		data_temp = data_buff[income_times];
	}
	else
	{
		if(++load_times==buffer_size)
		{
			buffer_size = 0;
			for(i=0;i<buffer_size;i++)
			{
				sum = sum + data_buff[i];
			}
			data_temp = sum/buffer_size;
		}
	}
	
	return data_temp;
}


uchar MovingAverage_Filter(uchar data_raw, uchar buffer_size)//滑动平均滤波
{
	static uchar data_buff[5];
	static uchar income_times;
	uchar data_temp;
	uchar i;
	uchar sum = 0;
	
	if(income_times<buffer_size)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		for(i=0;i<income_times-1;income_times++)
		{
			data_buff[i] = data_buff[i+1];
		}
		data_buff[income_times-1] = data_raw;
	}
	
	if(income_times<buffer_size)
	{
		data_temp = data_buff[income_times];
	}
	else
	{
			for(i=0;i<buffer_size;i++)
			{
				sum = sum + data_buff[i];
			}
			data_temp = sum/buffer_size;

	}
	
	return data_temp;
}

uchar MidAvg_Filter(uchar data_raw, uchar buffer_size)//中位值平均滤波
{
	static uchar data_buff[5];
	static uchar income_times;
	uchar data_temp;
	uchar i;
	uchar sum = 0;
	uchar temp_buff[5];
	
	if(income_times<buffer_size)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		for(i=0;i<income_times-1;income_times++)
		{
			data_buff[i] = data_buff[i+1];
		}
		data_buff[income_times-1] = data_raw;
	}
	
	if(income_times<buffer_size)
	{
		data_temp = data_buff[income_times];
	}
	else
	{
			for(i=0;i<buffer_size;i++)
			{
				temp_buff[i] = data_buff[i];
			}
			Bubble_Sort(temp_buff,buffer_size);
			for(i=1;i<buffer_size-1;i++)
			{
				sum = sum + temp_buff[i];
			}
			data_temp = sum/(buffer_size-2);
	}
	
	return data_temp;
}

uchar LimitAvg_Filter(uchar data_raw, uchar buffer_size, uchar limit_threshold)//限幅平均滤波
{
	static uchar data_buff[5];
	static uchar income_times;
	uchar data_temp;
	uchar i;
	uchar sum = 0;
	uchar temp_buff[5];
	
	if(income_times<buffer_size)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		for(i=0;i<income_times-1;income_times++)
		{
			data_buff[i] = data_buff[i+1];
		}
		data_buff[income_times-1] = data_raw;
	}
	
	if(income_times<buffer_size)
	{
		data_temp = data_buff[income_times];
	}
	else
	{
		temp_buff[0] = data_buff[0];
		for(i=1;i<buffer_size;i++)
		{
			if(abs(data_buff[i]-data_buff[i-1])<=limit_threshold)
			{
				temp_buff[i] = data_buff[i];
			}
			else
			{
				temp_buff[i] = data_buff[i-1];
			}
			sum = sum + temp_buff[i];
		}
		sum = sum + temp_buff[0];
		data_temp = sum/buffer_size;
	}
	
	return data_temp;
}

uchar FirstOrderLag_Filter(uchar data_raw, float ratio)//一阶滞后滤波
{
	static uchar data_buff[3];
	static uchar income_times;
	uchar data_temp;
	
	if(income_times<2)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		data_buff[0] = data_buff[1];
		data_buff[1] = data_raw;
	}
	
	if(income_times<2)
	{
		data_temp = data_buff[income_times];
	}
	else
	{
		data_temp = ratio*data_buff[1] + (1-ratio)*data_buff[0];
	}
	
	return data_temp;
}

uchar WeightedMovAvg_Filter(uchar data_raw, uchar buffer_size, float ratio_buffer[])//加权平均滤波
{
	static uchar data_buff[5];
	static uchar income_times;
	float data_temp;
	uchar i;
	
	if(income_times<buffer_size)
	{
		data_buff[income_times] = data_raw;
		income_times = income_times + 1;
	}
	else
	{
		for(i=0;i<income_times-1;income_times++)
		{
			data_buff[i] = data_buff[i+1];
		}
		data_buff[income_times-1] = data_raw;
	}
	
	if(income_times<2)
	{
		data_temp = data_buff[income_times];
	}
	else
	{
		for(i=0;i<buffer_size;i++)
		{
			data_temp = data_temp + ratio_buffer[i] * data_buff[i];
		}
	}
	
	return (uchar)data_temp;
}

uchar Glitch_Filter(uchar data_raw, uchar buffer_size)//消抖滤波
{
	static uchar data_buff;
	static uchar income_times;
	static uchar diff_times;
	uchar data_temp;
	
	if(income_times<1)
	{
		data_buff = data_raw;
	}
	else
	{
		if(data_raw!=data_buff)
		{
			if(++diff_times>buffer_size)
			{
				diff_times = 0;
				data_buff = data_raw;
			}
		}
	}
	data_temp = data_buff;
	
	return data_temp;
}

uchar LimitGlitch_Filter(uchar data_raw, uchar buffer_size, uchar limit_threshold)//限幅消抖滤波
{
	static uchar data_buff;
	static uchar income_times;
	static uchar data_last;
	static uchar diff_times;
	uchar data_temp;
	uchar data_now;
	
	if(income_times<buffer_size)
	{
		data_now = data_raw;
		data_buff = data_now;
	}
	else
	{
		if(abs(data_now - data_last)>limit_threshold)
		{
			data_now = data_last;
			if(data_now!=data_buff)
			{
				if(++diff_times>buffer_size)
				{
					diff_times = 0;
					data_buff = data_raw;
				}
			}
		}
	}
	
	data_temp = data_buff;
	data_last = data_temp;
	
	return data_temp;
}

void Filter_Choose(uchar choice)
{
	switch(choice)
	{
		case 0: data_filtered = SpeedLimit_Filter(adc_value, 5);break;
		case 1: data_filtered = Limiting_Filter(adc_value, 10);break;
		case 2: data_filtered = Median_Filter(adc_value, 3);break;
		case 3: data_filtered = Average_Filter(adc_value, 5);break;
		case 4: data_filtered = MovingAverage_Filter(adc_value, 5);break;
		case 5: data_filtered = MidAvg_Filter(adc_value, 5);break;
		case 6: data_filtered = LimitAvg_Filter(adc_value, 3, 5);break;
		case 7: data_filtered = FirstOrderLag_Filter(adc_value, 0.7);break;
		case 8: data_filtered = WeightedMovAvg_Filter(adc_value, 3, ratio_buffer);break;
		case 9: data_filtered = Glitch_Filter(adc_value, 3);break;
		case 10: data_filtered = LimitGlitch_Filter(adc_value, 3, 5);break;
		case 11: data_filtered = adc_value;break;
		default: break;
	}
}





