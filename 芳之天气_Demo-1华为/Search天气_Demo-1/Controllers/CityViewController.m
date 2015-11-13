//
//  CityViewController.m
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/6.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "CityViewController.h"
#import "DetailViewController.h"
#import "FangModel.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CoreData+MagicalRecord.h"

@interface CityViewController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    CGFloat _compare;
    UITextField *_textField;
    UISearchBar *_searchBar;
    NSString *_changeStr;
}
//下载管理
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _compare = [GSHelper testSelfWidth:kScreenSize.width heigh:kScreenSize.height];
    self.view.backgroundColor = [UIColor whiteColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"CityBackGround"];
    [self.view addSubview:imageView];
    UIButton *button = [ForDictAndArr createButtonFrame:CGRectMake(8, 15, 38*_compare, 38*_compare) Tag:20 title:nil backgroundImage:@"iconfont-fanhuianniu" target:self sel:@selector(onClick:)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:button];
    [self createAF];
    [self createTableView];
    [self createSearchItem];
    
}

- (void)onClick:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
// 创建searchBar
- (void)createSearchItem{
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 50)];
    _searchBar.placeholder = @"请输入城市名..";
    _searchBar.delegate = self;
    _tableView.tableHeaderView = _searchBar;
    //[self.view addSubview:self.searchBar];
    
    UIView *outView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 50)];
    [outView setBackgroundColor:[UIColor colorWithRed:50/255.0 green:183/255.0 blue:223/255.0 alpha:1]];
    [_searchBar insertSubview:outView atIndex:1];
    
}

#pragma mark - 实现searchBar协议方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    //显示cancel 按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    //将要结束编辑时
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //点击cancel 按钮
    searchBar.text = @"";
    [searchBar resignFirstResponder];   //辞去第一响应者
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //点击search
    [searchBar resignFirstResponder];
    NSString *url = [NSString stringWithFormat:kBaiDuAdress,searchBar.text];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self addTaskWithUrl: url];
    
}

- (void)createAF{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

- (void)addTaskWithUrl:(NSString *)url{

    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            [_dataArr removeAllObjects];
            NSDictionary *baseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dict = baseDict[@"retData"];

            if (!dict.count) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"小贴士提醒" message:@"搜索无结果" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:@"关闭", nil];
                [alert show];
                [_tableView reloadData];
                [_tableView headerEndRefreshingWithResult:JHRefreshResultNone];
                return ;
            }

            NSString *cityCode = dict[@"cityCode"];
            NSString *cityName = dict[@"cityName"];
            NSString *provinceName = dict[@"provinceName"];
            NSString *zipCode = dict[@"zipCode"];
            
            [_dataArr addObject:cityName];
            [_dataArr addObject:provinceName];
            [_dataArr addObject:zipCode];
            [_dataArr addObject:cityCode];
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        [_tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }];
}


// 创建tableView
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60*_compare, kScreenSize.width, kScreenSize.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataArr = [[NSMutableArray alloc] init];
    _tableView.bounces = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    // cell 分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count > 1) {
        cell.textLabel.text = [ForDictAndArr addStringWithStr1:@"城市:" str2:_dataArr[0] str3:@" - " str4:_dataArr[1] str5:@""];
        cell.detailTextLabel.text = [ForDictAndArr addStringWithStr1:@" 邮编:" str2:_dataArr[2] str3:@"" str4:@"" str5:@""];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = [FangModel MR_findByAttribute:@"cityId" withValue:_dataArr.lastObject];
    if (arr.count) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"城市已经添加" message:@"无在再次添加" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:@"关闭", nil];
        [alert show];
        [_tableView reloadData];
        return ;
    }
    //调用增加
    FangModel *model = [FangModel MR_createEntity];
    model.cityId = _dataArr.lastObject;
    model.cityName = _dataArr[0];
    model.province = _dataArr[1];
    
    //最后 同步保存到本地数据库
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
