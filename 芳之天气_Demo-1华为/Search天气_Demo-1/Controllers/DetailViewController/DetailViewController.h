//
//  DetailViewController.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/5.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "BaseViewController.h"
//定义 block 类型
typedef void(^DetailBlock)(NSString *cityData);

@interface DetailViewController : BaseViewController

- (void)showDataWithFutureArr:(NSArray *)arr;

- (void)showDataWithWeatherArr:(NSArray *)arr;

@property (nonatomic,strong) NSArray *cityArr;
@property (nonatomic,copy) DetailBlock myBlock;

@end
