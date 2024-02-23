#ifndef _FILTER_H
#define _FILTER_H

extern uchar data_filtered;
extern uchar filter_type;

uchar SpeedLimit_Filter(uchar data_raw, uchar limit_threshold);//�����˲�
uchar Limiting_Filter(uchar data_raw, uchar limit_threshold);//�޷��˲�
uchar Median_Filter(uchar data_raw, uchar buffer_size);//��λ���˲�
uchar Average_Filter(uchar data_raw, uchar buffer_size);//����ƽ���˲�
uchar MovingAverage_Filter(uchar data_raw, uchar buffer_size);//����ƽ���˲�
uchar MidAvg_Filter(uchar data_raw, uchar buffer_size);//��λֵƽ���˲�
uchar LimitAvg_Filter(uchar data_raw, uchar buffer_size, uchar limit_threshold);//�޷�ƽ���˲�
uchar FirstOrderLag_Filter(uchar data_raw, float ratio);//һ���ͺ��˲�
uchar WeightedMovAvg_Filter(uchar data_raw, uchar buffer_size, float ratio_buffer[]);//��Ȩƽ���˲�
uchar Glitch_Filter(uchar data_raw, uchar buffer_size);//�����˲�
uchar LimitGlitch_Filter(uchar data_raw, uchar buffer_size, uchar limit_threshold);//�޷������˲�
void Filter_Choose(uchar choice);

#endif