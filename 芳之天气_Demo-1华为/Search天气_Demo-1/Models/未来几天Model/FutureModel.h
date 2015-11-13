//
//  FutureModel.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/2.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "BaseModel.h"

@interface FutureModel : BaseModel

// 未来几天天气
@property (nonatomic, copy) NSString *temp_night_f;
@property (nonatomic, copy) NSString *wd;
@property (nonatomic, copy) NSString *sun_rise_time;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *sun_down_time;
@property (nonatomic, copy) NSString *ws;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *temp_day_f;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *temp_night_c;
@property (nonatomic, copy) NSString *temp_day_c;


@end
