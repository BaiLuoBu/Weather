//
//  GSHelper.m
//  MyMapDemo
//
//  Created by qianfeng01 on 15/10/29.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "GSHelper.h"

@implementation GSHelper

+(UIColor *)createColorWithRed:(NSInteger)red green:(NSInteger)green bule:(NSInteger)bule{
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:bule/255.0 alpha:1];
    return color;
}

+ (UIButton *)createButtonFrame:(CGRect)frame Title:(NSString *)title withTag:(NSInteger)num{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = num;;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (UILabel *)createLabelFrame:(CGRect)frame withTag:(NSInteger)tag{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 0;
    label.tag = tag;
    label.font = [UIFont systemFontOfSize:18];
    
    return label;
}

+ (CGFloat)testSelfWidth:(CGFloat)width heigh:(CGFloat)height{
    
    if (width == 320) {
        if ( height == 480) {
            return 0.8;
        }else{
            return 0.9;
        }
    }
    if (width == 375) {
        return 1;
    }else{
        return 1.2;
    }
    
}


@end
