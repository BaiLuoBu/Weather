//
//  BaseModel.m
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/10/30.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
//kvc 赋值时如果没有 找到对应的key 那么 就会调用下面的方法。如果没有实现那么就会崩溃

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
