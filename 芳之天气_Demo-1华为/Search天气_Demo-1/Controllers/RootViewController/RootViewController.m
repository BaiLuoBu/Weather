//
//  RootViewController.m
//  Search天气_Demo-1
//
//  Created by qianfeng01 on 15/10/30.
//  Copyright (c) 2015年 MaGS. All rights reserved.
//

#import "RootViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"
#import "UMSocial.h"
#import "SectionModel.h"
#import "FutureModel.h"
#import "MeiZuModel.h"

#import "GDataXMLNode.h"
#import "SixSecondModel.h"
#import "SixWeatherModel.h"

#import "HomeCell.h"

@interface RootViewController () <CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>

{
    CGFloat _compare;
    CGFloat _lat;
    CGFloat _log;
    BOOL _isClicked;
    NSArray *_futureDataArr;
    NSArray *_detailDataArr;
    NSArray *_hoursArr;
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *meiZuArr;
@property (nonatomic,strong) NSMutableArray *futureArr;
@property (nonatomic,strong) NSMutableArray *sectionArr;


@property (nonatomic,weak) UILabel *label;;
@property (nonatomic,strong) CLLocationManager *manager;    //定位管理器
// 县(区) 市 省
@property (nonatomic,copy) NSString *SubLocality;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *province;

@property (nonatomic,assign) BOOL isLocation;

//是否刷新
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isLoadMore;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *dataSecondArr;

//下载管理
@property (nonatomic,strong) AFHTTPRequestOperationManager *AFHTTPManager;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    _compare = [GSHelper testSelfWidth:kScreenSize.width heigh:kScreenSize.height];
    // 隐藏导航
    self.navigationController.navigationBar.hidden = YES;
    
    self.isLocation = YES;
    [self createAF];
    self.isRefreshing = NO;
    [self createTableView];
    [self crateNavigationItem];
    [self createSunAndCloud];
    [self createRefreshView];
    
    // 判断是否打开GPS
    if ([CLLocationManager locationServicesEnabled]) {
        [self manegerInit];
        self.isLocation = YES;
        [self.manager startUpdatingLocation];
        
    }else{
        NSLog(@"没打开GPS");
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self createRefreshView];
    //NSLog(@"——————————%@",self.cityID);
    
    [self createUrl];
}


- (void)createAF {
    // 初始化下载请求
    self.dataArr = [[NSMutableArray alloc] init];
    self.dataSecondArr = [[NSMutableArray alloc] init];
    self.AFHTTPManager = [AFHTTPRequestOperationManager manager];
    self.AFHTTPManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.sectionArr = [[NSMutableArray alloc] init];
    self.meiZuArr = [[NSMutableArray alloc] init];
    self.futureArr = [[NSMutableArray alloc] init];
    
}

- (void)manegerInit{
    // 初始化定位管理器
    self.manager = [[CLLocationManager alloc] init];
    //定位的精确度
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.delegate = self;
    //iOS8之后 要设置 用户授权定位
    /*
     1.通过代码 判断是否是iOS8之后的sdk 设置授权
     //使用期间 允许
     [self.manager requestWhenInUseAuthorization];
     或者
     //始终允许
     [self.manager requestAlwaysAuthorization];
     
     2.设置Info.plist 配置文件
     //上面的函数对应在plist 设置  key
     NSLocationWhenInUseUsageDescription
     或者
     NSLocationAlwaysUsageDescription
     
     //key 对应的值可以什么都不写 ，也可以写内容 会显示在 用户授权的警告框中
     
     */
    double v = [UIDevice currentDevice].systemVersion.doubleValue;
    if (v >= 8.0) {
        [self.manager requestWhenInUseAuthorization];
    }
}

#pragma mark - 定位
//当定位的位置 发生改变的时候会一直调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    // 定位的位置就在locations数组中
    // 数组中只有一个对象
    if (locations.count) {
        CLLocation *location = locations[0];
        // 获取经纬度
        CLLocationCoordinate2D coordinate = location.coordinate;
        NSLog(@"long:%f lat:%f",coordinate.longitude,coordinate.latitude);
        _lat = coordinate.latitude;
        _log = coordinate.longitude;
        /*
        //进行地理反编码 把经纬度转化为 真正的地址位置
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        // 反编码
        [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark *mark in placemarks) {
                NSLog(@"name:%@",mark.name);
                NSLog(@"country:%@",mark.country);
                //key:State 省  key:City市 key:SubLocality县/区
                NSLog(@"State:%@",mark.addressDictionary[@"State"]);
                NSLog(@"City:%@",mark.addressDictionary[@"City"]);
                NSLog(@"SubLocality:%@",mark.addressDictionary[@"SubLocality"]);
                self.province = mark.addressDictionary[@"State"];
                self.city = mark.addressDictionary[@"City"];
                self.SubLocality = mark.addressDictionary[@"SubLocality"];
                
            }
            NSMutableString *qie = [NSMutableString stringWithString:self.city];
            NSString *qieUrl = [qie substringWithRange:NSMakeRange(0, qie.length - 1)];
            NSString *url = [NSString stringWithFormat:kSixWeather,qieUrl,self.province];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self addTaskWithUrl:url];
            
//
//            NSString *appUrl = [NSString stringWithFormat:kXiaoMiAdress,self.city];
//            appUrl = [appUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"%@",appUrl);
//            [self addTaskWithUrl:appUrl];
        }];
    */
    }
    // 停止更新坐标
    [self.manager stopUpdatingLocation];
    //下载城市ID
    NSString *weatherUrl = [NSString stringWithFormat:HuaWeiWeather,_lat,_log];
    [self textWeatherWithUrl:weatherUrl];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}


#pragma mark - 获取城市ID
- (void)textWeatherWithUrl:(NSString *)url{
    // 如果有传值 就直接去下载数据
    if (self.cityID) {
        [self createUrl];
        return;
    }
    
    // 下载城市ID
    __weak typeof(self) weakSelf = self;
    [self.AFHTTPManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            // xml解析
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject encoding:NSUTF8StringEncoding error:nil];
            GDataXMLElement *element = [doc rootElement];
            //获取根节点下的节点（User）
            NSArray *users = [element elementsForName:@"currentconditions"];
            //NSLog(@"attributes %@",[element attributeForName:@"url"]);
            GDataXMLElement *urlElement = [[users[0] elementsForName:@"url"] objectAtIndex:0];
            NSString *url = [urlElement stringValue];
            
            
            self.cityID = [url substringFromIndex:url.length - 9];
            //NSLog(@"cityID name is:%@",self.cityID);
            
            //结束刷新
            [weakSelf endRefreshing];
            [self createUrl];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络异常");
        [weakSelf endRefreshing];
    }];
}

- (void)createUrl{
    
    NSString *addUrl = [NSString stringWithFormat: kMeiZuWeather,self.cityID];
    NSLog(@"createUrl%@",addUrl);
    [self addTaskWithUrl:addUrl];

}

#pragma mark - 刷新
//刷新视图
- (void)createRefreshView  {
    __weak typeof (self) weakSelf = self;//弱引用
    [self animateStart];
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //重新下载数据
        if (weakSelf.isRefreshing) {
            return ;
        }

        weakSelf.isRefreshing = YES;//标记正在刷新
        //下载的是全部还是其他分类的
        //如果是全部 没有cate_id
        //http://1000phone.net:8088/app/iAppFree/api/limited.php?page=1&number=20&cate_id=6014
        [weakSelf createUrl];
        
    }];
}


#pragma mark - 结束下载
- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        //关闭刷新特效
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
}


#pragma mark - 获取城市天气信息
- (void)addTaskWithUrl:(NSString *)url{
    //添加下载特效
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    //显示 特效 设置 标题
    [MMProgressHUD showWithTitle:@"更新中" status:@"正在更新天气,请稍后..."];
    
    //下载
    //先 判断当前网络的状态
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,//无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,//3g/4g/2g
     AFNetworkReachabilityStatusReachableViaWiFi = 2,wifi
     */
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusNotReachable) {
        //网络无连接 走缓存
        NSString *path = [LZXHelper getFullPathWithFile:url];
        //检测 有没有 缓存文件 还有检测 是否超时
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
        BOOL isTimeOut = [LZXHelper isTimeOutWithFile:url timeOut:30*24*60*60];//是否超时一个月
        if (isExist && isTimeOut == NO) {
            //文件存在 且 不超时
            //读本地
            NSData *data = [NSData dataWithContentsOfFile:path];
            
            //json 数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self saveData:dict];
            
            //刷新表格
            [self.tableView reloadData];
            //结束刷新
            [self endRefreshing];
            [MMProgressHUD dismissWithSuccess:@"更新天气成功" title:@"YES"];
            NSLog(@"本地数据加载");
        }
        
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.AFHTTPManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"网络下载成功");
        if (responseObject) {
            [self.meiZuArr removeAllObjects];
            //json 解析
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //下载完成之后 把数据 保存本地沙盒中(缓存)
            //直接把下载的二进制数据  responseObject写入本地文件
            NSString *path = [LZXHelper getFullPathWithFile:url];
            //写文件
            NSData *data = (NSData *)responseObject;
            //每一页 都做 缓存
            [data writeToFile:path atomically:YES];
            [self saveData:dict];
            //刷新表格
            [self.tableView reloadData];
        }
        //[MMProgressHUD dismissWithSuccess:@"更新天气成功" title:@"YES"];
        [weakSelf endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络异常");
        //下载完成 取消特效
        [MMProgressHUD dismissWithSuccess:@"更新天气失败" title:@"NO"];
        [weakSelf endRefreshing];
    }];
}

- (void)saveData:(NSDictionary *)dict{
    __weak typeof(self) weakSelf = self;

    NSDictionary *valueDict = dict[@"value"];
    // 获取城市 省  (weakSelf.meiZuArr[0])
    MeiZuModel *cityModel = [[MeiZuModel alloc] init];
    [cityModel setValuesForKeysWithDictionary:valueDict];
    [weakSelf.meiZuArr addObject:cityModel];
    
    // 天气详情 (weakSelf.meiZuArr[1])
    NSArray *indexesArr = valueDict[@"indexes"];
    NSMutableArray *indexArr = [[NSMutableArray alloc] init];
    for (NSInteger a = 0; a < indexesArr.count; a ++) {
        MeiZuModel *indexesModel = [[MeiZuModel alloc] init];
        [indexesModel setValuesForKeysWithDictionary:indexesArr[a]];
        [indexArr addObject:indexesModel];
    }
    [weakSelf.meiZuArr addObject:indexArr];
    
    // 空气好坏 (weakSelf.meiZuArr[2])
    NSDictionary *pm25Dict = valueDict[@"pm25"];
    MeiZuModel *pm25DictModel = [[MeiZuModel alloc] init];
    [pm25DictModel setValuesForKeysWithDictionary:pm25Dict];
    [weakSelf.meiZuArr addObject:pm25DictModel];
    
    // 风 情 (weakSelf.meiZuArr[3])
    NSDictionary *realtimeDict = valueDict[@"realtime"];
    MeiZuModel *realModel = [[MeiZuModel alloc] init];
    [realModel setValuesForKeysWithDictionary:realtimeDict];
    [weakSelf.meiZuArr addObject:realModel];
    //
    NSDictionary *weatherDetailsInfoDict = valueDict[@"weatherDetailsInfo"];
    
    // 区间段 天气 (weakSelf.meiZuArr[4])
    NSArray *weather3HoursDetailsInfosArr = weatherDetailsInfoDict[@"weather3HoursDetailsInfos"];
    NSMutableArray *weather3HoursArr = [[NSMutableArray alloc] init];
    for (NSInteger a = 0; a < weather3HoursDetailsInfosArr.count; a ++) {
        SectionModel *sectionModel = [[SectionModel alloc] init];
        [sectionModel setValuesForKeysWithDictionary:weather3HoursDetailsInfosArr[a]];
        [weather3HoursArr addObject:sectionModel];
    }
    [weakSelf.meiZuArr addObject:weather3HoursArr];
    
    // 未来几天天气 (weakSelf.meiZuArr[5])
    NSArray *weathersArr = valueDict[@"weathers"];
    NSMutableArray *weatherArr = [[NSMutableArray alloc] init];
    for (NSInteger a = 0; a < weathersArr.count; a ++) {
        FutureModel *futureModel = [[FutureModel alloc] init];
        [futureModel setValuesForKeysWithDictionary:weathersArr[a]];
        [weatherArr addObject:futureModel];
    }
    [weakSelf.meiZuArr addObject:weatherArr];
    
    //结束刷新
    //[weakSelf endRefreshing];
    [self.tableView reloadData];
    //下载完成 取消特效
    [MMProgressHUD dismissWithSuccess:@"更新天气成功" title:@"ok"];

    
}

#pragma mark - 创建tableView
- (void)createTableView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"daybackimage"];
    [self.view addSubview: imageView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, kScreenSize.height - 200)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 取消下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.rowHeight = kScreenSize.height-200;
    self.tableView.pagingEnabled = YES;
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 祖册Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    NSArray *imageName = @[@[@"iconfont-beiyusan",@"iconfont-quanzi",@"iconfont-fuwuxiche"],@[@"iconfont-fangshai",@"iconfont-lvyou",@"iconfont-caiyixiu092209"],@[@"iconfont-daqiwuran",@"iconfont-2pijiu",@"iconfont-jjshmeirongmeifa"],@[@"iconfont-liangshaizhishu",@"iconfont-lukuangjiance",@"iconfont-huachuan"],@[@"iconfont-ganmaozhishu2",@"iconfont-diaoyu",@"iconfont-chuanyizhishu"]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    if (self.meiZuArr.count) {
        MeiZuModel *firstModel = self.meiZuArr[0];      //城市
        NSArray *detailArr = self.meiZuArr[1];          //详情
        MeiZuModel *pmModel = self.meiZuArr[2];         //空气质量
        MeiZuModel *realtimeModel = self.meiZuArr[3];   //实时天气
        NSArray *weather3HoursArr = self.meiZuArr[4];   //区间段天气
        NSArray *futureArr = self.meiZuArr[5];          //未来几天天气
        
        NSMutableArray *imagesNameLabel = [[NSMutableArray alloc] init];
        for (NSInteger namesNum = 0; namesNum < detailArr.count; namesNum ++) {
            MeiZuModel *modelName = detailArr[namesNum];
            [imagesNameLabel addObject:modelName.level];
            //NSLog(@"%@",modelName.abbreviation);
        }
        
        NSArray *removeArr = @[@27,@26,@25,@24,@21,@20,@17,@13,@11,@6,@4,@2,@0];
        for (NSInteger removeNum = 0; removeNum < removeArr.count; removeNum ++) {
            NSInteger indexNum = [removeArr[removeNum] integerValue];
            [imagesNameLabel removeObjectAtIndex:indexNum];
            
        }
        
        NSInteger aa = 0;
        NSMutableArray *arrHigh = [[NSMutableArray alloc] init];
        for (NSInteger numNames = 0 ; numNames < 5; numNames++) {
            NSMutableArray *labelsArr = [[NSMutableArray alloc] init];
            for (NSInteger numName = 0; numName < 3; numName++) {
                [labelsArr addObject:imagesNameLabel[aa]];
                aa++;
            }
            [arrHigh addObject:labelsArr];
        }
        
        _detailDataArr = detailArr;
        _hoursArr = weather3HoursArr;
        
        FutureModel *todayWeatherModel = futureArr[0];
        [cell showDataWithFutureModel:todayWeatherModel];
        [cell showDataWithModel:firstModel];
        [cell showDataWithRealTimeModel:realtimeModel];
        [cell showDataWithPMModel:pmModel];
        
        if ([self.view viewWithTag:100]) {
            UIView *view = (UIView *)[self.view viewWithTag:100];
            [view removeFromSuperview];
        }
        
        [self createView];
        
        UIView *view = (UIView *)[self.view viewWithTag:100];
        // 创建下面Label
        for (NSInteger weatherLabels = 0; weatherLabels < 5; weatherLabels ++) {
            FutureModel *model = futureArr[weatherLabels];
            NSArray *endArr = arrHigh[weatherLabels];
            UILabel *label1 = [ForDictAndArr createlabelFrame:CGRectMake( kScreenSize.width / 5 * weatherLabels, 25*_compare, kScreenSize.width / 5, 30*_compare) title:model.week textColor:[UIColor whiteColor] textPlace:NSTextAlignmentCenter];
            
            UILabel *label2 = [ForDictAndArr createlabelFrame:CGRectMake( kScreenSize.width / 5 * weatherLabels + kScreenSize.width / 10 - 15*_compare, 65*_compare , 30*_compare, 30*_compare) title:nil textColor:[UIColor whiteColor] textPlace:NSTextAlignmentCenter];
            NSString *labelTitle = [ForDictAndArr addStringWithStr1:@" " str2:model.temp_night_c str3:@"~" str4:model.temp_day_c str5:@"°"];

            UILabel *labelFuture = [ForDictAndArr createlabelFrame:CGRectMake( kScreenSize.width / 5 * weatherLabels, 110*_compare, kScreenSize.width / 5, 30*_compare) title:labelTitle textColor:[UIColor whiteColor] textPlace:NSTextAlignmentCenter];
            NSArray *middleArr = imageName[weatherLabels];
            for (NSInteger index = 0; index < 3; index++) {
                
                UIImageView *imageView = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width / 5 * weatherLabels + kScreenSize.width / 10 - 35*_compare/2, kScreenSize.height/2+index*kScreenSize.height / 7, 35*_compare, 35*_compare) UIImage:middleArr[index]];
                
                UILabel *labelMiddle = [ForDictAndArr createlabelFrame:CGRectMake(kScreenSize.width / 5 * weatherLabels, kScreenSize.height/2+50*_compare+index*kScreenSize.height / 7, kScreenSize.width / 5, 30*_compare) title:endArr[index] textColor:[UIColor whiteColor] textPlace:NSTextAlignmentCenter];
                //NSLog(@"%@",endArr[index]);
                labelMiddle.adjustsFontSizeToFitWidth = YES;
                [view addSubview:labelMiddle];
                [view addSubview:imageView];
            }
            
            [view addSubview:labelFuture];
            [view addSubview:label2];
            
            NSString *imageName = [[NSString alloc] init];
            imageName = [ForDictAndArr imageNameWithWeather:model.weather];
            label2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
            if (weatherLabels == 0) {
                label1.text = @"今天";
            }
            [view addSubview:label1];
            }
    }
    return cell;
}

// 手势方向 左 右 上 下
- (void)swipeGestureClick:(UISwipeGestureRecognizer *)gester{
    
    if (gester.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"UISwipeGestureRecognizerDirectionLeft");
        [self downFrame];
    }
    if (gester.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"UISwipeGestureRecognizerDirectionRight");
        [self upFrame];
    }
    if (gester.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"UISwipeGestureRecognizerDirectionUp");
        [self upFrame];
    }
    if (gester.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"UISwipeGestureRecognizerDirectionDown");
        [self downFrame];
    }
}

- (void)createView{
    UIView *view = [ForDictAndArr createViewFrame:CGRectMake(0, kScreenSize.height - 100*_compare, kScreenSize.width, kScreenSize.height - 20) tag:100];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    // 活动手势
    for (NSInteger i = 1; i < 5; i++) {
        UISwipeGestureRecognizer *swipe = [ForDictAndArr createUISwipeGestureRecognizerTarget:self sel:@selector(swipeGestureClick:) withNumber:i];
        [view addGestureRecognizer:swipe];
    }

}

- (void)upFrame{
    //手势动画
    [UIView animateWithDuration:1 animations:^{
        UIImageView *imageView7 = (UIImageView *)[self.view viewWithTag:1007];
        imageView7.frame = CGRectMake(kScreenSize.width/2-30*_compare, kScreenSize.height, 50*_compare, 80*_compare);
        imageView7.transform = CGAffineTransformMakeRotation(M_PI);
        self.tableView.frame = CGRectMake(0, - kScreenSize.height, kScreenSize.width, kScreenSize.height);
        UIView *view = (UIView *)[self.view viewWithTag:100];
        view.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }];
    
}
- (void)downFrame{
    //手势动画
    [UIView animateWithDuration:1 animations:^{
        UIImageView *imageView7 = (UIImageView *)[self.view viewWithTag:1007];
        imageView7.transform = CGAffineTransformMakeRotation(M_PI*2);
        imageView7.frame = CGRectMake(kScreenSize.width/2-30*_compare, kScreenSize.height-170*_compare, 50*_compare, 80*_compare);
        
        self.tableView.frame = CGRectMake(0, 20, kScreenSize.width, kScreenSize.height - 200);
        UIView *view = (UIView *)[self.view viewWithTag:100];
        view.frame = CGRectMake(0, kScreenSize.height - 100*_compare, kScreenSize.width, kScreenSize.height - 20);
        view.backgroundColor = [UIColor clearColor];
    }];

}

#pragma mark - create
- (void)createSunAndCloud{
    //声明 imageView
    for (NSInteger viewNum = 1; viewNum < 9; viewNum++) {
        UIImageView *imageView1 = [ForDictAndArr createUIImageViewnum:viewNum compare:_compare];
        imageView1.tag = 1000+viewNum;
        [self.view addSubview:imageView1];
    }
}
- (void)animateStart {
    // 添加动画
    [ForDictAndArr animateWithUIImageViewNum:1 compare:_compare imageView:(UIImageView *)[self.view viewWithTag:1001]];
    [ForDictAndArr animateWithUIImageViewNum:2 compare:_compare imageView:(UIImageView *)[self.view viewWithTag:1002]];
    [ForDictAndArr animateWithUIImageViewNum:3 compare:_compare imageView:(UIImageView *)[self.view viewWithTag:1003]];
    [ForDictAndArr animateWithUIImageViewNum:4 compare:_compare imageView:(UIImageView *)[self.view viewWithTag:1004]];
    [ForDictAndArr animateWithUIImageViewNum:5 compare:_compare imageView:(UIImageView *)[self.view viewWithTag:1005]];
    [ForDictAndArr animateWithUIImageViewNum:6 compare:_compare imageView:(UIImageView *)[self.view viewWithTag:1006]];
    
}
// 创建 左上角 右上角button
- (void)crateNavigationItem{

    UIButton *leftButton = [ForDictAndArr createButtonFrame:CGRectMake(10, 5, 25, 25) Tag:20 title:nil backgroundImage:@"iconfont-caidan" target:self sel:@selector(onBarButton:)];
    [self.tableView addSubview:leftButton];
    
    UIButton *rightButton = [ForDictAndArr createButtonFrame:CGRectMake(kScreenSize.width-25-10, 5, 25, 25) Tag:30 title:nil backgroundImage:@"iconfont-tubiao" target:self sel:@selector(onBarButton:)];
    _isClicked = YES;
    [self.tableView addSubview:rightButton];
}
// 左上角 右上角button
- (void)onBarButton:(UIButton *)button{
    if (button.tag == 20) {
        NSLog(@"左上");
        DetailViewController *detail= [[DetailViewController alloc] init];
        detail.myBlock = ^ void (NSString *detailID){
            self.cityID = detailID;
        };
        /*
         界面1 要跳转到界面2 我们需要一个绚丽的跳转效果，这时我们可以使用转场动画
         1.创建转场动画对象
         2.转场动画 需要加在  视图的layer层(发生转场效果的view的父视图的layer)
         //导航的子视图控制器 都在导航的view上
         */
        
        //1.实例化一个动画对象
        CATransition *animation = [CATransition animation];
        //2.动画的类型
        /*
         kCATransitionFade 全局变量
         或者 字符串 @"fade"
         */
        animation.type = @"rippleEffect";//cube  suckEffect rippleEffect
        //3.动画的方向
        animation.subtype = @"fromRight";//或kCATransitionFromLeft
        //4.动画时间
        animation.duration = 2;
        //5.动画节奏
        //animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//匀速
        
        //6.把动画添加到导航的view的layer
        //[self.navigationController.view.layer addAnimation:animation forKey:nil];
                
        [self.navigationController pushViewController:detail animated:YES];//内部有+1但是不要我们管理

        
    } else {
        if (_isClicked) {
            _isClicked = NO;
            // 添加动画
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            UIImageView *imageView1 = [ForDictAndArr createUIImageViewFrame:CGRectMake(kScreenSize.width-25-10, 5, 25, 25) UIImage:@"iconfont-tubiao"];
            [self.tableView addSubview:imageView1];
            
            [UIView animateWithDuration:1.5 animations:^{
                imageView1.frame = CGRectMake(kScreenSize.width + 50, -70, 25, 25);
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:@"561092ea67e58e05840005f2"
                                                  shareText:@"芳之天气期待您的关注"  //分享的文字
                                                 shareImage:nil  //分享的图片
                                            shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToDouban,UMShareToRenren,UMShareToEmail,nil]  //分享的平台
                                                   delegate:self];

            } completion:^(BOOL finished) {
                [imageView1 removeFromSuperview];
                [button setBackgroundImage:[UIImage imageNamed:@"iconfont-tubiao"] forState:UIControlStateNormal];
                _isClicked = YES;
            }];
            
        }
    }
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
