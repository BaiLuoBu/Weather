//
//  HomeCell.h
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/2.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MeiZuModel.h"
#import "SectionModel.h"
#import "FutureModel.h"

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *qualityLabel;

@property (nonatomic,strong) MeiZuModel *meiZuModel;
@property (nonatomic,strong) SectionModel *sectionModel;
@property (nonatomic,strong) FutureModel *futureModel;

- (void)showDataWithDetailModel:(MeiZuModel *)model;
- (void)showDataWithPMModel:(MeiZuModel *)model;
- (void)showDataWithRealTimeModel:(MeiZuModel *)model;
- (void)showDataWithModel:(MeiZuModel *)model;

- (void)showDataWithSectionModel:(SectionModel *)model;

- (void)showDataWithFutureModel:(FutureModel *)model;
- (void)showFutureWeatherWithFutureArr:(NSArray *)arr;

@end
