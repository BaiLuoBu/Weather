//
//  FangModel.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/8.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FangModel : NSManagedObject

@property (nonatomic, retain) NSString * cityId;
@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * cityName;

@end
