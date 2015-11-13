//
//  SixWeatherModel.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/10/30.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "BaseModel.h"

@interface SixWeatherModel : BaseModel
// 城市 有无预警
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *yujing;
// 气温
@property (nonatomic, copy) NSString *temp0;
@property (nonatomic, copy) NSString *temp1;
@property (nonatomic, copy) NSString *temp2;
@property (nonatomic, copy) NSString *temp3;
@property (nonatomic, copy) NSString *temp4;
@property (nonatomic, copy) NSString *temp5;
@property (nonatomic, copy) NSString *temp6;
// 天气
@property (nonatomic, copy) NSString *weather0;
@property (nonatomic, copy) NSString *weather1;
@property (nonatomic, copy) NSString *weather2;
@property (nonatomic, copy) NSString *weather3;
@property (nonatomic, copy) NSString *weather4;
@property (nonatomic, copy) NSString *weather5;
@property (nonatomic, copy) NSString *weather6;
// 风
@property (nonatomic, copy) NSString *wind0;
@property (nonatomic, copy) NSString *wind1;
@property (nonatomic, copy) NSString *wind2;
@property (nonatomic, copy) NSString *wind3;
@property (nonatomic, copy) NSString *wind4;
@property (nonatomic, copy) NSString *wind5;
@property (nonatomic, copy) NSString *wind6;

@property (nonatomic, copy) NSString *windlevel0;
@property (nonatomic, copy) NSString *windlevel1;
@property (nonatomic, copy) NSString *windlevel2;
@property (nonatomic, copy) NSString *windlevel3;
@property (nonatomic, copy) NSString *windlevel4;
@property (nonatomic, copy) NSString *windlevel5;
@property (nonatomic, copy) NSString *windlevel6;
// 日期 上次更新时间
@property (nonatomic, copy) NSString *tdtime;
@property (nonatomic, copy) NSString *intime;
//   实时温度  湿度 更新 湿度感觉
@property (nonatomic, copy) NSString *tempNow;
@property (nonatomic, copy) NSString *shidu;
@property (nonatomic, copy) NSString *winNow;
@property (nonatomic, copy) NSString *shiduNow;
// 整点 有太阳时间 无太阳时间 实时天气污染指数
@property (nonatomic, copy) NSString *RelTime;
@property (nonatomic, copy) NSString *todaySun;
@property (nonatomic, copy) NSString *tomorrowSun;
@property (nonatomic, copy) NSString *AQIData;

@property (nonatomic, copy) NSString *USAAQIData;
@property (nonatomic, copy) NSString *PM2Dot5Data;
@property (nonatomic, copy) NSString *PM10Data;
// 时间段 天气 最高温度 最低温度 风向 风速 又无降雨
@property (nonatomic, copy) NSString *timespan1;
@property (nonatomic, copy) NSString *sixweather1;
@property (nonatomic, copy) NSString *highTemp1;
@property (nonatomic, copy) NSString *lowTemp1;
@property (nonatomic, copy) NSString *windDirection1;
@property (nonatomic, copy) NSString *windSpeed1;
@property (nonatomic, copy) NSString *rainfall1;

@property (nonatomic, copy) NSString *timespan2;
@property (nonatomic, copy) NSString *sixweather2;
@property (nonatomic, copy) NSString *highTemp2;
@property (nonatomic, copy) NSString *lowTemp2;
@property (nonatomic, copy) NSString *windDirection2;
@property (nonatomic, copy) NSString *windSpeed2;
@property (nonatomic, copy) NSString *rainfall2;

@property (nonatomic, copy) NSString *timespan3;
@property (nonatomic, copy) NSString *sixweather3;
@property (nonatomic, copy) NSString *highTemp3;
@property (nonatomic, copy) NSString *lowTemp3;
@property (nonatomic, copy) NSString *windDirection3;
@property (nonatomic, copy) NSString *windSpeed3;
@property (nonatomic, copy) NSString *rainfall3;

@property (nonatomic, copy) NSString *timespan4;
@property (nonatomic, copy) NSString *sixweather4;
@property (nonatomic, copy) NSString *highTemp4;
@property (nonatomic, copy) NSString *lowTemp4;
@property (nonatomic, copy) NSString *windDirection4;
@property (nonatomic, copy) NSString *windSpeed4;
@property (nonatomic, copy) NSString *rainfall4;


// 小米
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;


@end
