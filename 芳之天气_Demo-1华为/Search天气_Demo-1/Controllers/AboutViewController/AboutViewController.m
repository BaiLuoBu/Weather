//
//  AboutViewController.m
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/6.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "AboutViewController.h"
#import "DetailViewController.h"

@interface AboutViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    CGFloat _compare;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _compare = [GSHelper testSelfWidth:kScreenSize.width heigh:kScreenSize.height];
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:240/255.0 alpha:1];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"aboutBackImage"];
    [view addSubview:imageView];

    [self.view addSubview:view];
    [self dataInit];
    [self createTableView];
    UIButton *button = [ForDictAndArr createButtonFrame:CGRectMake(8, 15, 38*_compare, 38*_compare) Tag:20 title:nil backgroundImage:@"iconfont-fanhuianniu" target:self sel:@selector(onClick:)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)onClick:(UIButton *)button{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50*_compare, kScreenSize.width, kScreenSize.height ) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor clearColor];
    // cell 分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)dataInit{
    _dataArr = [[NSMutableArray alloc] init];
    //NSArray *arr1 = @[@"推送设置",@"开启推送通知",@"开启关注通知"];
    //[_dataArr addObject:arr1];
    
    NSArray *arr2 = @[@"名称:芳之天气",@"开发者:Ma.GS",@"联系方式:757136771@qq.com"];
    [_dataArr addObject:arr2];
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    //取消 选中 效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
