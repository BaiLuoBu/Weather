//
//  DetailViewController.m
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/11/5.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "DetailViewController.h"
#import "AboutViewController.h"
#import "CityViewController.h"
#import "RootViewController.h"
#import "FangModel.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CoreData+MagicalRecord.h"

@interface DetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DetailViewController
{
    UITableView *_tableView;
    CGFloat _copmpre;
    BOOL _isEditing;

}
- (void)showDataWithFutureArr:(NSArray *)arr{
    
}

- (void)showDataWithWeatherArr:(NSArray *)arr{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _copmpre = [GSHelper testSelfWidth:kScreenSize.width heigh:kScreenSize.height];
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"detailBackGroundImage"];
    [view addSubview:imageView];
    [self.view addSubview:view];
    [self createTableView];
    _isEditing = YES;
    //UISwipeGestureRecognizer *swipe = [ForDictAndArr createUISwipeGestureRecognizerTarget:self sel:@selector(swipeGestureClick:) withNumber:2];
    //[self.view addGestureRecognizer:swipe];
    UIButton *button = [ForDictAndArr createButtonFrame:CGRectMake(8, 15, 38*_copmpre, 38*_copmpre) Tag:20 title:nil backgroundImage:@"iconfont-fanhuianniu" target:self sel:@selector(onClick:)];
    [self.view addSubview:button];
    
    UIButton *button1 = [ForDictAndArr createButtonFrame:CGRectMake(kScreenSize.width - 38*_copmpre - 8, 15, 38*_copmpre, 38*_copmpre) Tag:30 title:@"编辑" backgroundImage:nil target:self sel:@selector(onClick1:)];
    button1.titleLabel.font = [UIFont systemFontOfSize:18];
    //[self.view addSubview:button1];

    
    // Do any additional setup after loading the view.
}

- (void)onClick1:(UIButton *)button{
    if (self.dataArr.count > 2) {
        if (_isEditing) {
            _tableView.editing  = YES;
            _isEditing = NO;
            UIButton *button1 = (UIButton *)[self.view viewWithTag:30];
            button1.titleLabel.text = @"完成";
            
        }else{
            _tableView.editing = NO;
            _isEditing = YES;
            UIButton *button1 = (UIButton *)[self.view viewWithTag:30];
            button1.titleLabel.text = @"编辑";
            
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isEditing) {
        if (indexPath.row > 2) {
            return UITableViewCellEditingStyleDelete;
        }else{
            return UITableViewCellEditingStyleNone;
        }
    }else{
        return UITableViewCellEditingStyleInsert;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 2) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            FangModel *model = self.dataArr[indexPath.row];
            //[_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.dataArr removeObject:self.dataArr[indexPath.row]];

            NSArray *arr = [FangModel MR_findByAttribute:@"cityId" withValue:model.cityId];
            for (FangModel *model in arr) {
                [model MR_deleteEntity];//删除
            }
            //最后 同步保存到本地数据库
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [_tableView reloadData];
            //删除当前的数据

            //[[CoreDataManager sharedManager] deleteDataWithName:nameArr];
        }

    }
    _tableView.editing = NO;
    _isEditing = YES;
}


- (void)onClick:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataArr removeAllObjects];
    [self createDataArr];

    NSArray *arr = [FangModel MR_findAll];//查询所有
    for (NSInteger a = 0; a < arr.count ; a++) {
        [self.dataArr addObject:arr[a]];
    }
    [_tableView reloadData];
}

- (void)createDataArr{
    self.dataArr = [[NSMutableArray alloc] init];
    [self.dataArr addObject:@"关于作者"];
    [self.dataArr addObject:@"清除缓存"];
    [self.dataArr addObject:@"添加城市"];
}

// 创建tableView
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenSize.width, kScreenSize.height - 60 - 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 50*_copmpre;
    _tableView.backgroundColor = [UIColor clearColor];
    // cell 分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
}
// 添加手势
- (void)swipeGestureClick:(UISwipeGestureRecognizer *)gester{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row > 2) {
        FangModel *model = self.dataArr[indexPath.row];
        cell.textLabel.text = model.cityName;
        cell.imageView.image = [UIImage imageNamed:@"iconfont-icon"];
    }else{
    cell.textLabel.text = self.dataArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-guanyu"];
    }
    if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-qingchuhuancun"];
    }
    if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-tripchengshi"];
    }
}
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AboutViewController *about = [[AboutViewController alloc] init];
        [self presentViewController:about animated:YES completion:^{
            
        }];
    }
    if (indexPath.row == 1) {
        [self clearCaches];
    }
    if (indexPath.row == 2) {
        CityViewController *city = [[CityViewController alloc] init];
        [self presentViewController:city animated:YES completion:^{
        }];
    }
    if (indexPath.row > 2) {

        FangModel *model = self.dataArr[indexPath.row];
        NSLog(@"%@",model.cityName);
        if(self.myBlock){
            self.myBlock(model.cityId);
        };
        [self.navigationController popViewControllerAnimated:YES];
        
    }

}

- (void)clearCaches{
    NSString *clear = [NSString stringWithFormat:@"共清除%.2fM内存",[self getCacheSize]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:clear delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    //删除
    [[NSFileManager defaultManager] removeItemAtPath:myPath error:nil];
}
//获取所有缓存大小
- (CGFloat)getCacheSize {
    //缓存 有两类 sdwebimage 还有 每个界面保存的缓存
    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    //获取文件夹中的所有的文件
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:myPath error:nil];
    unsigned long long size = 0;
    for (NSString *fileName in arr) {
        NSString *filePath = [myPath stringByAppendingPathComponent:fileName];
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += dict.fileSize;
    }
    //1M = 1024 K = 1024*1024字节
    CGFloat totalSize = (sdSize+size)/1024.0/1024.0;
    NSLog(@"%@",myPath);
    return totalSize;
    
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
