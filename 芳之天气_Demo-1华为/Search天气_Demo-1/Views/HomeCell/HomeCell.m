//
//  HomeCell.m
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/2.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell
{
    CGFloat _compare;
}
- (void)awakeFromNib {
    _compare = [GSHelper testSelfWidth:kScreenSize.width heigh:kScreenSize.height];
}
/*
 @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
 @property (weak, nonatomic) IBOutlet UILabel *cityLabel;
 @property (weak, nonatomic) IBOutlet UILabel *dayLabel;
 @property (weak, nonatomic) IBOutlet UILabel *dayWeatherLabel;
 @property (weak, nonatomic) IBOutlet UILabel *windLabel;
 @property (weak, nonatomic) IBOutlet UILabel *nowWeatherLabel;
 @property (weak, nonatomic) IBOutlet UILabel *qualityLabel;
 
 */
- (void)showDataWithDetailModel:(MeiZuModel *)model {
    
}
- (void)showDataWithPMModel:(MeiZuModel *)model {
    
    //self.qualityLabel.backgroundColor = [UIColor orangeColor];
    NSString *windStr = [@" " stringByAppendingString:model.aqi];
    NSString *quilityStr = [windStr stringByAppendingString:@" "];
    
    self.qualityLabel.text = [quilityStr stringByAppendingString:model.quality] ;
    
}
- (void)showDataWithRealTimeModel:(MeiZuModel *)model{
    self.windLabel.frame = CGRectMake(kScreenSize.width - 105, 69, 100, 20);
    self.windLabel.text = [model.wD stringByAppendingString:model.wS];
    self.dayLabel.frame = CGRectMake(kScreenSize.width - 105, 29, 100, 20);
    NSString *timeStr = [model.time substringWithRange:NSMakeRange(0, 10)];
    self.dayLabel.text = timeStr;
    NSString *sendibleTemp = [@" " stringByAppendingString:model.sendibleTemp];

    self.nowWeatherLabel.text = [sendibleTemp stringByAppendingString:@"°"];
}

- (void)showDataWithModel:(MeiZuModel *)model{
    self.meiZuModel = model;
    self.cityLabel.frame = CGRectMake(kScreenSize.width/2 - 50, 0, 100, 20);
    self.cityLabel.text = model.city;
    NSLog(@"%@",model.city);
}

- (void)showDataWithSectionModel:(SectionModel *)model{
    self.sectionModel = model;
    
    
}

- (void)showDataWithFutureModel:(FutureModel *)model{
    self.futureModel = model;
    self.dayWeatherLabel.frame = CGRectMake(kScreenSize.width - 105, 49, 100, 20);
    self.dayWeatherLabel.text = [ForDictAndArr addStringWithStr1:model.temp_night_c str2:@"~" str3:model.temp_day_c str4:@"°" str5:model.weather];
}

/*
 @property (weak, nonatomic) IBOutlet UILabel *firstDayLabel;
 @property (weak, nonatomic) IBOutlet UILabel *firstDayWeatherLabel;
 @property (weak, nonatomic) IBOutlet UILabel *secondDayLabel;
 @property (weak, nonatomic) IBOutlet UILabel *secondDayWeatherLabel;
 @property (weak, nonatomic) IBOutlet UILabel *thirdDayLabel;
 @property (weak, nonatomic) IBOutlet UILabel *thirdDayWeatherLabel;
 @property (weak, nonatomic) IBOutlet UILabel *fourthDayLabel;
 @property (weak, nonatomic) IBOutlet UILabel *fourthDayWeatherLabel;
 @property (weak, nonatomic) IBOutlet UILabel *fifthDayLabel;
 @property (weak, nonatomic) IBOutlet UILabel *fifthDayWeatherLabel;
 
 */
- (void)showFutureWeatherWithFutureArr:(NSArray *)arr{
    
    for (NSInteger weatherLabels = 0; weatherLabels < 5; weatherLabels ++) {
        FutureModel *model = arr[weatherLabels];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake( kScreenSize.width / 5 * weatherLabels, kScreenSize.height - 100*_compare, kScreenSize.width / 5, 30*_compare)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake( kScreenSize.width / 5 * weatherLabels, kScreenSize.height - 60*_compare , kScreenSize.width / 5, 30*_compare)];
        label1.text = model.week;
        label2.text = model.weather;
        label1.textColor = [UIColor whiteColor];
        label2.textColor = [UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        if (weatherLabels == 0) {
            label1.text = @"今天";
        }
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
