//
//  Define.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/10/30.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#ifndef Search___Demo_1_Define_h
#define Search___Demo_1_Define_h

#import "GSHelper.h"
#import "LZXHelper.h"
#import "NetInterface.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "JHRefresh.h"
#import "MMProgressHUD.h"
#import "ForDictAndArr.h"

//获取屏幕大小
#define kScreenSize [UIScreen mainScreen].bounds.size

//调试代码
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


#endif
