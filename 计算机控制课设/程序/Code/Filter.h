#ifndef _FILTER_H
#define _FILTER_H

extern uchar data_filtered;
extern uchar filter_type;

uchar SpeedLimit_Filter(uchar data_raw, uchar limit_threshold);//限速滤波
uchar Limiting_Filter(uchar data_raw, uchar limit_threshold);//限幅滤波
uchar Median_Filter(uchar data_raw, uchar buffer_size);//中位数滤波
uchar Average_Filter(uchar data_raw, uchar buffer_size);//算数平均滤波
uchar MovingAverage_Filter(uchar data_raw, uchar buffer_size);//滑动平均滤波
uchar MidAvg_Filter(uchar data_raw, uchar buffer_size);//中位值平均滤波
uchar LimitAvg_Filter(uchar data_raw, uchar buffer_size, uchar limit_threshold);//限幅平均滤波
uchar FirstOrderLag_Filter(uchar data_raw, float ratio);//一阶滞后滤波
uchar WeightedMovAvg_Filter(uchar data_raw, uchar buffer_size, float ratio_buffer[]);//加权平均滤波
uchar Glitch_Filter(uchar data_raw, uchar buffer_size);//消抖滤波
uchar LimitGlitch_Filter(uchar data_raw, uchar buffer_size, uchar limit_threshold);//限幅消抖滤波
void Filter_Choose(uchar choice);

#endif