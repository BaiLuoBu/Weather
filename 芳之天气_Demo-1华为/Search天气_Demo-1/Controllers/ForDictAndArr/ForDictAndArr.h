//
//  ForDictAndArr.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/2.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ForDictAndArr : NSObject
// 判断天气图片
+ (NSString *)imageNameWithWeather:(NSString *)weather;
// 创建UIImageView
+ (UIImageView *)createUIImageViewFrame:(CGRect)frame
                                UIImage:(NSString *)imageName;
// 创建手势
+ (UISwipeGestureRecognizer *)createUISwipeGestureRecognizerTarget:(id)target
                                                               sel:(SEL)sel
                                                        withNumber:(NSInteger)num;
// 创建View
+ (UIView *)createViewFrame:(CGRect)frame
                        tag:(NSInteger)tag;
// 创建Label
+ (UILabel *) createlabelFrame:(CGRect)frame
                         title:(NSString *)title
                         textColor:(UIColor *)color
                     textPlace:(NSTextAlignment)NSTextAlignmentCenter;
// 创建button
+ (UIButton *)createButtonFrame:(CGRect)frame
                            Tag:(NSInteger)tag
                          title:(NSString *)title
                backgroundImage:(NSString *)imageName
                         target:(id)target
                            sel:(SEL)sel;
// 解析model (没有用到)
+ (NSArray *)forCirculateArray:(NSArray *)arr WithModel:(BaseModel *)model;
// 天气质量(没有用到)
+ (NSString *)qualityWeatherWithPM:(NSString *)PM25;
// 字符串拼接
+ (NSString *)addStringWithStr1:(NSString *)str1
                           str2:(NSString *)str2
                           str3:(NSString *)str3
                           str4:(NSString *)str4
                           str5:(NSString *)str5;
// 再次封装 根据指定num 创建UIImageView 
+ (UIImageView *)createUIImageViewnum:(NSInteger)num
                                compare:(CGFloat)_compare;
// 弹簧动画
+ (void)animateWithUIImageView:(UIImageView *)imageView
                          Time:(CGFloat)time
                         delay:(CGFloat)delay
        usingSpringWithDamping:(CGFloat)obstruction
         initialSpringVelocity:(CGFloat)speed
                    beginFrame:(CGRect)beginFrame
                      enfFrame:(CGRect)endFrame;
// 再次封装 根据指定num 显示动画
+ (void)animateWithUIImageViewNum:(NSInteger)num
                          compare:(CGFloat)_compare
                        imageView:(UIImageView *)imageView;



@end
