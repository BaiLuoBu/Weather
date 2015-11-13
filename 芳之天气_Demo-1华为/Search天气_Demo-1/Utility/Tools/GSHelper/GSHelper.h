//
//  GSHelper.h
//  MyMapDemo
//
//  Created by qianfeng01 on 15/10/29.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GSHelper : NSObject

+ (UIColor *)createColorWithRed:(NSInteger)red
                          green:(NSInteger)green
                           bule:(NSInteger) bule;

+ (UIButton *)createButtonFrame:(CGRect)frame
                          Title:(NSString *)title
                        withTag:(NSInteger)num;

+ (UILabel *) createLabelFrame:(CGRect)frame
                       withTag:(NSInteger)tag;
//检测屏幕宽高
+ (CGFloat)testSelfWidth:(CGFloat)width heigh:(CGFloat)height;


@end
