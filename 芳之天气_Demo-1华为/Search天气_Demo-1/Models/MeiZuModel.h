//
//  MeiZuModel.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/2.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "BaseModel.h"

@interface MeiZuModel : BaseModel
//第一层
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *redirect;
@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *provinceName;

//indexes 层
@property (nonatomic, copy) NSString *abbreviation;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *name;

//pm25 层
@property (nonatomic, copy) NSString *quality;
@property (nonatomic, assign) NSInteger citycount;
@property (nonatomic, copy) NSString *no2;
@property (nonatomic, copy) NSString *co;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *aqi;
@property (nonatomic, copy) NSString *so2;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *o3;
@property (nonatomic, copy) NSString *pm25;
@property (nonatomic, copy) NSString *advice;
@property (nonatomic, assign) NSInteger cityrank;
@property (nonatomic, copy) NSString *upDateTime;
@property (nonatomic, copy) NSString *pm10;

//realtime 层
@property (nonatomic, copy) NSString *sendibleTemp;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *sD;
@property (nonatomic, copy) NSString *temp;
@property (nonatomic, copy) NSString *wS;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *ziwaixian;
@property (nonatomic, copy) NSString *wD;



@end
