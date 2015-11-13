//
//  ForDictAndArr.m
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/2.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "ForDictAndArr.h"
#import "MeiZuModel.h"
#import "SectionModel.h"
#import "FutureModel.h"

@implementation ForDictAndArr

+ (NSString *)imageNameWithWeather:(NSString *)weather{
    NSString *imageName = [[NSString alloc] init];
    if ([weather isEqualToString:@"多云"]) {
        imageName = @"iconfont-duoyun";

    }else{
        imageName = @"iconfont-yin";
    }
    
    if ([weather isEqualToString:@"晴"]){
        imageName = @"iconfont-qingtian";
    }
    if ([weather isEqualToString:@"小雨"] || [weather isEqualToString:@"阵雨"] || [weather isEqualToString:@"小到中雨"]){
        imageName = @"iconfont-xiaoyu";
    }
    if ([weather isEqualToString:@"中雨"] || [weather isEqualToString:@"中到大雨"]){
        imageName = @"iconfont-zhongyu";
    }
    if ([weather isEqualToString:@"大雨"] || [weather isEqualToString:@"大到暴雨"]){
        imageName = @"iconfont-dayu";
    }
    
    if ([weather isEqualToString:@"雷阵雨"]){
        imageName = @"iconfont-leizhenyu";
    }
    
    if ([weather isEqualToString:@"暴雨"]){
        imageName = @"iconfont-baoyu";
    }
    if ([weather isEqualToString:@"小雪"] || [weather isEqualToString:@"阵雪"] || [weather isEqualToString:@"小到中雪"]){
        imageName = @"iconfont-xiaoxue";
    }
    if ([weather isEqualToString:@"中雪"] || [weather isEqualToString:@"中到大雪"]){
        imageName = @"iconfont-zhongxue";
    }
    if ([weather isEqualToString:@"大雪"] || [weather isEqualToString:@"大到暴雪"]){
        imageName = @"iconfont-daxue";
    }
    if ([weather isEqualToString:@"暴雪"]){
        imageName = @"iconfont-baoxue";
    }
    if ([weather isEqualToString:@"雨夹雪"]){
        imageName = @"iconfont-yujiaxue";
    }
    return imageName;
}

+ (UISwipeGestureRecognizer *)createUISwipeGestureRecognizerTarget:(id)target
                                                               sel:(SEL)sel
                                                        withNumber:(NSInteger)num{
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:sel];
    switch (num) {
        case 1:
            swipe.direction = UISwipeGestureRecognizerDirectionUp;
            break;
        case 2:
            swipe.direction = UISwipeGestureRecognizerDirectionLeft;
            break;
        case 3:
            swipe.direction = UISwipeGestureRecognizerDirectionDown;
            break;
        case 4:
            swipe.direction = UISwipeGestureRecognizerDirectionRight;
            break;
        default:
            break;
    }
    return swipe;
}

+(UIButton *)createButtonFrame:(CGRect)frame Tag:(NSInteger)tag title:(NSString *)title backgroundImage:(NSString *)imageName target:(id)target sel:(SEL)sel{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.tag = tag;
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}



+ (NSString *)addStringWithStr1:(NSString *)str1 str2:(NSString *)str2 str3:(NSString *)str3 str4:(NSString *)str4 str5:(NSString *)str5{
    NSMutableString *returnStr = [[NSMutableString alloc] init];
    [returnStr appendString:str1];
    [returnStr appendString:str2];
    [returnStr appendString:str3];
    [returnStr appendString:str4];
    [returnStr appendString:str5];
    return returnStr;
}

+ (NSArray *)forCirculateArray:(NSArray *)arr WithModel:(BaseModel *)model{
    NSMutableArray *meiArr = [[NSMutableArray alloc] init];
    for (NSDictionary *indexDict in arr) {
        
        [model setValuesForKeysWithDictionary:indexDict];
        [meiArr addObject:model];
        
    }
    return meiArr;
}

+ (NSString *)qualityWeatherWithPM:(NSString *)PM25{
    NSInteger pm = [PM25 integerValue];
    if (pm < 51) {
        return [PM25 stringByAppendingString:@"优"];
    } else if (pm < 101){
        return [PM25 stringByAppendingString:@"良"];
    } else if (pm < 150) {
        return [PM25 stringByAppendingString:@"轻度污染"];
    } else if (pm < 200) {
        return [PM25 stringByAppendingString:@"中度污染"];
    } else if (pm < 300) {
        return [PM25 stringByAppendingString:@"重度污染"];
    } else{
        return [PM25 stringByAppendingString:@"严重污染"];
    }
}

+ (UILabel *)createlabelFrame:(CGRect)frame
                        title:(NSString *)title
                    textColor:(UIColor *)color
                    textPlace:(NSTextAlignment)NSTextAlignmentCenter{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
//    if ([title compare:@"多云"]) {
//        imageView.image = [UIImage imageNamed:@"iconfont-duoyun"];
//        label.text = @"";
//    } else if ([title compare:@"晴"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-qingtian"];
//        label.text = @"";
//    } else if ([title compare:@"小雨"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-xiaoyu"];
//        label.text = @"";
//    } else if ([title compare:@"中雨"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-zhongyu"];
//        label.text = @"";
//    } else if ([title compare:@"大雨"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-dayu"];
//        label.text = @"";
//    } else if ([title compare:@"雷阵雨"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-leizhenyu"];
//        label.text = @"";
//    }else if ([title compare:@"暴雨"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-baoyu"];
//        label.text = @"";
//    }else if ([title compare:@"小雪"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-xiaoxue"];
//        label.text = @"";
//    }else if ([title compare:@"中雪"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-zhongxue"];
//        label.text = @"";
//    }else if ([title compare:@"大雪"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-daxue"];
//        label.text = @"";
//    }else if ([title compare:@"暴雪"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-baoxue"];
//        label.text = @"";
//    }else if ([title compare:@"雨夹雪"]){
//        imageView.image = [UIImage imageNamed:@"iconfont-yujiaxue"];
//        label.text = @"";
//    }
//    [label addSubview:imageView];
    return label;
}

+ (UIImageView *)createUIImageViewnum:(NSInteger)num compare:(CGFloat)_compare{
    if (num == 1) {
        UIImageView *imageView1 = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width/2 - 80*_compare, 100*_compare, 160*_compare, 160*_compare) UIImage:@"iconfont-taiyangend"];
        return imageView1;
        
    }
    if (num == 2) {
        UIImageView *imageView2 = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width/2-200*_compare, kScreenSize.height/2+15*_compare, 120*_compare, 70*_compare) UIImage:@"yunEnd"];
        return imageView2;
        
    }
    if (num == 3) {
        UIImageView *imageView3 = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width/2+120*_compare, kScreenSize.height/2+10*_compare, 120*_compare, 70*_compare) UIImage:@"yunEnd"];
        return imageView3;
        
    }
    if (num == 4) {
        UIImageView *imageView4 = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width/2-30*_compare, kScreenSize.height/2+130*_compare, 120*_compare, 70*_compare) UIImage:@"yunEnd"];
        return imageView4;
        
    }
    if (num == 5) {
        UIImageView *imageView5 = [ForDictAndArr createUIImageViewFrame:CGRectMake(-50*_compare, kScreenSize.height-160*_compare+100*_compare, kScreenSize.height/2+50*_compare, 160*_compare) UIImage:@"leftyun"];
        return imageView5;
        
    }
    if (num == 6) {
        UIImageView *imageView6 = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width/2-50*_compare, kScreenSize.height-150*_compare+110*_compare, kScreenSize.height/2+50*_compare, 160*_compare) UIImage:@"rightyun"];
        return imageView6;
        
    }
    
    if (num == 7) {
        UIImageView *imageView7 = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width/2-30*_compare, kScreenSize.height-170*_compare, 50*_compare, 80*_compare) UIImage:@"flower"];
        return imageView7;
        
    }
    UIImageView *imageView8 = [self createUIImageViewFrame:CGRectMake(-20*_compare, kScreenSize.height-100*_compare, kScreenSize.width+20*_compare, 100*_compare) UIImage:@"downground"];
    return imageView8;

}

+ (UIImageView *)createUIImageViewFrame:(CGRect)frame UIImage:(NSString *)imageName{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
    
}

+ (UIView *)createViewFrame:(CGRect)frame tag:(NSInteger)tag{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.tag = tag;
    return view;
}

+ (void)animateWithUIImageView:(UIImageView *)imageView
                          Time:(CGFloat)time
                         delay:(CGFloat)delay
        usingSpringWithDamping:(CGFloat)obstruction
         initialSpringVelocity:(CGFloat)speed
                    beginFrame:(CGRect)beginFrame
                      enfFrame:(CGRect)endFrame{

    [UIView animateWithDuration:3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.frame = beginFrame;
    } completion:^(BOOL finished) {
        imageView.frame = endFrame;
    }];

    
}

+ (void)animateWithUIImageViewNum:(NSInteger)num
                          compare:(CGFloat)_compare
                        imageView:(UIImageView *)imageView{
    
    switch (num) {
        case 1:
        {
            [self animateWithUIImageView:imageView Time:3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:5 beginFrame:CGRectMake(kScreenSize.width/2-80*_compare, kScreenSize.height/2-100*_compare, 160*_compare, 160*_compare) enfFrame:CGRectMake(kScreenSize.width/2-80*_compare, kScreenSize.height/2-100*_compare, 160*_compare, 160*_compare)];

        }
            break;
        case 2:
        {

            [ForDictAndArr animateWithUIImageView:imageView Time:3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:5 beginFrame:CGRectMake(kScreenSize.width/2-100*_compare, kScreenSize.height/2-5, 120*_compare, 70*_compare) enfFrame:CGRectMake(kScreenSize.width/2-100*_compare, kScreenSize.height/2-5, 120*_compare, 70*_compare)];

            
        }
            break;
        case 3:
        {
            [ForDictAndArr animateWithUIImageView:imageView Time:3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:5 beginFrame:CGRectMake(kScreenSize.width/2+20*_compare, kScreenSize.height/2-10*_compare, 120*_compare, 70*_compare) enfFrame:CGRectMake(kScreenSize.width/2+20*_compare, kScreenSize.height/2-10*_compare, 120*_compare, 70*_compare)];
            
        }
            break;
        case 4:
        {
            [ForDictAndArr animateWithUIImageView:imageView Time:3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:5 beginFrame:CGRectMake(kScreenSize.width/2-30*_compare, kScreenSize.height/2+10*_compare, 120*_compare, 70*_compare) enfFrame:CGRectMake(kScreenSize.width/2-30*_compare, kScreenSize.height/2+10*_compare, 120*_compare, 70*_compare)];
            
        }
            break;
        case 5:
        {
            [ForDictAndArr animateWithUIImageView:imageView Time:3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:5 beginFrame:CGRectMake(-50*_compare, kScreenSize.height-160*_compare, kScreenSize.height/2+50*_compare, 160*_compare) enfFrame:CGRectMake(-50*_compare, kScreenSize.height-160*_compare, kScreenSize.height/2+50*_compare, 160*_compare)];

        }
            break;
        case 6:
        {
            [ForDictAndArr animateWithUIImageView:imageView Time:3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:5 beginFrame:CGRectMake(kScreenSize.width/2-50*_compare, kScreenSize.height-150*_compare, kScreenSize.height/2+50*_compare, 160*_compare) enfFrame:CGRectMake(kScreenSize.width/2-50*_compare, kScreenSize.height-150*_compare, kScreenSize.height/2+50*_compare, 160*_compare)];
            
            
            
            
        }

            break;

        default:
            break;
    }
    
}


@end
