//
//  SectionModel.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/2.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "BaseModel.h"

@interface SectionModel : BaseModel

// weather3HoursDetailsInfos层 区间段天气
@property (nonatomic, copy) NSString *highestTemperature;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *isRainFall;
@property (nonatomic, copy) NSString *wd;
@property (nonatomic, copy) NSString *lowerestTemperature;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *precipitation;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *ws;


@end
