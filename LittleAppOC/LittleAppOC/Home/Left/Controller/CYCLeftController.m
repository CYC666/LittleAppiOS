//
//  CYCLeftController.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/15.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CYCLeftController.h"
#import "CNetWorking.h"
#import "WeatherModel.h"
#import "ThemeManager.h"
#import "CThemeLabel.h"
#import "CThemeButton.h"
#import "CLeftCtrlCell.h"
#import "WeatherController.h"
#import "DailyController.h"
#import "ThirdController.h"
#import "AFNetworking.h"
#import "AliWeatherController.h"
#import "CYCLoginController.h"
#import "PasswordController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "TileView.h"
#import "CollisionView.h"
#import "PSCC_enc_pwd.h"

#define CYCLeftControllerCellID @"CYCLeftControllerCellID"  // 单元格重用标识符


@interface CYCLeftController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

    NSTimeInterval updateInterval;

}

@property (strong, nonatomic) NSArray *tableViewTitles;     // 表视图的title
@property (strong, nonatomic) NSArray *tableViewIcons;      // 表视图的icon
@property (strong, nonatomic) CLLocationManager *manager;   // 定位管理员
@property (strong, nonatomic) CThemeLabel *locationLabel;   // 定位标签
@property (strong, nonatomic) UILabel *temperatureLabel;    // 温度标签
@property (strong, nonatomic) UIImageView *weatherImageView;// 显示天气的图
@property (assign, nonatomic) BOOL headImageFlag;           // 当前是否是编辑头像
@property (copy, nonatomic) NSString *location;             // 位置

// 碰撞
@property (nonatomic,strong) CMMotionManager *mManager;
@property (nonatomic,strong) TileView * baseView;

@end

@implementation CYCLeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatSubviews];
    
    self.view.backgroundColor = CTHEME.themeColor;
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
}

- (CMMotionManager *)mManager {
    
    if (!_mManager) {
        updateInterval = 1.0/10.0;
        _mManager = [[CMMotionManager alloc] init];
    }
    return _mManager;
}

// ------------------------------------------------------UI创建-------------------------------------------------------
#pragma mark - 创建子视图
- (void)creatSubviews {

    // 头部背景图片
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cLeftControllerWidth, cLeftControllerHeadImageHeight)];
    _headImageView.contentMode = UIViewContentModeScaleAspectFit;
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTapAction:)];
    [_headImageView addGestureRecognizer:headTap];
    [self.view addSubview:_headImageView];

    NSString *path_sandox = NSHomeDirectory();
    NSString *filePath = [path_sandox stringByAppendingString:LeftImage];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:filePath];
    if (image == nil) {
        _headImageView.image = [UIImage imageNamed:@"image_leftControllerHeadImage"];
    } else {
        _headImageView.image = image;
    }
    
    // 头像
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake((cLeftControllerWidth - 80)/2.0,
                                                                               (cLeftControllerHeadImageHeight - 80)/2.0
                                                                               , 80, 80)];
    _headImage.layer.cornerRadius = 40;
    _headImage.layer.borderWidth = 2;
    _headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImage.clipsToBounds = YES;
    [self.view addSubview:_headImage];
    
    // 查看本地头像
    NSString *imagePath = [path_sandox stringByAppendingString:HeadImage];
    UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:imagePath];
    if (imgFromUrl == nil) {
        _headImage.image = [UIImage imageNamed:@"icon_left_headImage"];
    } else {
        _headImage.image = imgFromUrl;
    }
    
    // 点击头像更换
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadImage:)];
    _headImage.userInteractionEnabled = YES;
    [_headImage addGestureRecognizer:tap];
    
    
    // 电话号码
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cLeftControllerHeadImageHeight - 40, cLeftControllerWidth, 30)];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.text = [CUSER objectForKey:CUserPhone];
    phoneLabel.font = C_MAIN_FONT(20);
    phoneLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:phoneLabel];
    
    // 退出登录
    UIButton *outButton = [UIButton buttonWithType:UIButtonTypeCustom];
    outButton.frame = CGRectMake(15, 30, 50, 30);
    [outButton setTitle:@"退出" forState:UIControlStateNormal];
    outButton.titleLabel.font = C_MAIN_FONT(17);
    [outButton setBackgroundColor:[UIColor grayColor]];
    outButton.layer.cornerRadius = 15;
    [outButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [outButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [outButton addTarget:self action:@selector(outButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outButton];
    
    // 表视图显示功能
    _tableViewTitles = @[@"曹老师",
                         @"第三方",
                         @"开发日记",
                         @"接口测试"];
    _tableViewIcons = @[@"icon_leftCtrl_user",
                        @"icon_leftCtrl_Third",
                        @"icon_leftCtrl_feedBack",
                        @"icon_leftCtrl_function"];
    _middleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, cLeftControllerHeadImageHeight + 15,
                                                                     cLeftControllerWidth, kScreenHeight - cLeftControllerHeadImageHeight - 49 - 15)
                                                    style:UITableViewStylePlain];
    _middleTableView.separatorColor = [UIColor clearColor];
    [_middleTableView registerClass:[CLeftCtrlCell class] forCellReuseIdentifier:CYCLeftControllerCellID];
    _middleTableView.backgroundColor = [UIColor clearColor];
    _middleTableView.delegate = self;
    _middleTableView.dataSource = self;
    [self.view addSubview:_middleTableView];
    
    // 创建碰撞模块
    [self creatTileViewAction];
    
    // 夜间模式开关
    _nightButton = [CThemeButton buttonWithType:UIButtonTypeCustom];
    _nightButton.frame = CGRectMake(10, kScreenHeight - 49, 70, 49);
    _nightButton.titleLabel.font = C_MAIN_FONT(15);
    [_nightButton addTarget:self action:@selector(nightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nightButton];
    

    if (CTHEME.themeType == CDayTheme) {
        [_nightButton setImage:[UIImage imageNamed:@"icon_leftController_day"] forState:UIControlStateNormal];
        [_nightButton setTitle:@" 白天" forState:UIControlStateNormal];
        [_nightButton setTitleColor:C_MAIN_TEXTCOLOR forState:UIControlStateNormal];
    } else  {
        [_nightButton setImage:[UIImage imageNamed:@"icon_leftController_night"] forState:UIControlStateNormal];
        [_nightButton setTitle:@" 夜间" forState:UIControlStateNormal];
        [_nightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    // 地点
    _locationLabel = [[CThemeLabel alloc] initWithFrame:CGRectMake(cLeftControllerWidth - 100, kScreenHeight - 49, 50, 49)];
    _locationLabel.textColor = CTHEME.themeType == CDayTheme ? C_MAIN_TEXTCOLOR : [UIColor whiteColor];
    _locationLabel.font = C_MAIN_FONT(15);
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.alpha = 0;
    [self.view addSubview:_locationLabel];
    
    // 温度
    _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cLeftControllerWidth - 50, kScreenHeight - 53, 50, 49)];
    _temperatureLabel.textColor = CRGB(27, 199, 246, 1);
    _temperatureLabel.font = C_MAIN_FONT(30);
    _temperatureLabel.textAlignment = NSTextAlignmentLeft;
    _temperatureLabel.alpha = 0;
    [self.view addSubview:_temperatureLabel];
    
    // 天气图
    _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cLeftControllerWidth - 80, kScreenHeight - 49 - 60, 60, 60)];
    _weatherImageView.contentMode = UIViewContentModeScaleAspectFit;
    _weatherImageView.alpha = 0;
    _weatherImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *weatherTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weatherTapAction:)];
    [_weatherImageView addGestureRecognizer:weatherTap];
    [self.view addSubview:_weatherImageView];

    
    
    // 定位 -- 天气 -- 设置天气UI
    [self loadLocation];

}

#pragma mark - 创建碰撞方块
- (void)creatTileViewAction {
    
    self.baseView = [[CollisionView alloc] init];
    self.baseView.userInteractionEnabled = NO;
    self.baseView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.baseView];
    
    
    if ([self.mManager isAccelerometerAvailable] == YES) {
        //回调会一直调用,建议获取到就调用下面的停止方法，需要再重新开始，当然如果需求是实时不间断的话可以等离开页面之后再stop
        [self.mManager setAccelerometerUpdateInterval:updateInterval];
        [self.mManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             double x = accelerometerData.acceleration.x;
             double y = accelerometerData.acceleration.y;
             if (fabs(y) >= fabs(x))
             {
                 if (y >= 0){
                     
//                     NSLog(@"Down");
                     //Down
                 }
                 else{
//                     NSLog(@"Portrait");
                     
                     //Portrait
                 }
             }
             else
             {
                 if (x >= 0){
//                     NSLog(@"Right");
                     
                     //Right
                 }
                 else{
//                     NSLog(@"Left");
                     
                     //Left
                 }
                 
             }
             
             
             // 1. 计算偏移量
             CGPoint offset = CGPointMake(accelerometerData.acceleration.x,-accelerometerData.acceleration.y);
             // 2. 计算角度
             CGFloat angle = atan2(offset.y, offset.x);
             // 3. 计算距离
             CGFloat distance = hypot(offset.y, offset.x);
             // 4. 设置推动的大小、角度
             self.baseView.push.magnitude = distance * 0.3;
             self.baseView.push.angle = angle;
             // 5. 使单次推行为有效
             self.baseView.push.active = YES;
             
             
             
         }];
    }

    
}

#pragma mark - 设置天气UI
- (void)setWeatherUI:(NSDictionary *)dic {

    WeatherModel *model = [[WeatherModel alloc] init];
    model.locationName = dic[@"location"][@"name"];
    model.weatherText = dic[@"now"][@"text"];
    model.weatherCode = dic[@"now"][@"code"];
    model.temperature = dic[@"now"][@"temperature"];
    
    // 保存一下当前位置
    _location = dic[@"location"][@"name"];
    
    _locationLabel.text = model.locationName;
    _temperatureLabel.text = [NSString stringWithFormat:@"%@º", model.temperature];
    _weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", model.weatherCode]];
    [UIView animateWithDuration:.35
                     animations:^{
                         _locationLabel.alpha = 1;
                         _temperatureLabel.alpha = 1;
                         _weatherImageView.alpha = 1;
                     }];
    
    
    // 设置某个瓦片的图片
    self.baseView.boxView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", model.weatherCode]];
    self.baseView.stepLabel.text = [NSString stringWithFormat:@"%@º", model.temperature];
    
}



// ------------------------------------------------------动作响应区----------------------------------------------------
#pragma mark - 点击了头部的背景图片,更换图片
- (void)headTapAction:(UITapGestureRecognizer *)tap {
    
    _headImageFlag = NO;

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];

}

#pragma mark - 更换头像
- (void)changeHeadImage:(UITapGestureRecognizer *)tap {
    
    _headImageFlag = YES;

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];

}

#pragma mark - 夜间模式按钮响应
- (void)nightButtonAction:(UIButton *)button {

    
    if (CTHEME.themeType == CDayTheme) {
        CTHEME.themeType = CNightTheme;
        [button setImage:[UIImage imageNamed:@"icon_leftController_night"] forState:UIControlStateNormal];
        [button setTitle:@" 夜间" forState:UIControlStateNormal];
    } else {
        CTHEME.themeType = CDayTheme;
        [button setImage:[UIImage imageNamed:@"icon_leftController_day"] forState:UIControlStateNormal];
        [button setTitle:@" 白天" forState:UIControlStateNormal];
    }

}

#pragma mark - 点击了天气的图片
- (void)weatherTapAction:(UITapGestureRecognizer *)tap {

    AliWeatherController *controller = [[AliWeatherController alloc] initWithCityName:_location];
    [self presentViewController:controller animated:YES completion:nil];

}

#pragma mark - 退出按钮
- (void)outButtonAction:(UIButton *)button {

    [UIApplication sharedApplication].delegate.window.rootViewController = [[CYCLoginController alloc] init];
    
    // 清除电话号码
    [CUSER removeObjectForKey:CUserPhone];
}

#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {

    self.view.backgroundColor = CTHEME.themeColor;

}





// -----------------------------------------------------代理协议方法-----------------------------------------------------
#pragma mark - 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CLeftCtrlCell *cell = [[CLeftCtrlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CYCLeftControllerCellID];
    cell.leftCellLabel.text = _tableViewTitles[indexPath.row];
    cell.leftCellImageView.image = [UIImage imageNamed:_tableViewIcons[indexPath.row]];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        ThirdController *controller = [[ThirdController alloc] initWithNibName:@"ThirdController"
                                                                        bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        nav.navigationBar.translucent = NO;
        nav.navigationBar.barTintColor = [UIColor blackColor];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        DailyController *controller = [[DailyController alloc] initWithNibName:@"DailyController"
                                                                        bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        nav.navigationBar.translucent = NO;
        nav.navigationBar.barTintColor = [UIColor blackColor];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.row == 3) {
        // 测试接口用
        [self testURL];
    }
    
    // 点击之后取消高亮状态
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    

}

#pragma mark - 定位
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    // 当前位置
    CLLocation *currentLocation = locations.firstObject;
    CLLocationCoordinate2D currentCoor2D = currentLocation.coordinate;
    // 停止更新地理位置
    [manager stopUpdatingLocation];
    
    // 获取天气
    [self loadWeather:currentCoor2D];
    
}

#pragma mark - 选择了照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    
    
    if (_headImageFlag) {
        // 修改头像
        UIImage *image = info[UIImagePickerControllerEditedImage];
        _headImage.image = image;
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:HeadImage];
        [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    } else {
        // 修改背景图
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        _headImageView.image = image;
        NSString *path_sandox = NSHomeDirectory();
        NSString *filePath = [path_sandox stringByAppendingString:LeftImage];
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:nil];

}

// -----------------------------------------------------其他方法-----------------------------------------------------
#pragma mark - 加载地理位置
- (void)loadLocation {

    _manager = [[CLLocationManager alloc] init];
    if([[[UIDevice currentDevice]systemVersion]floatValue] >= 8) {
        [_manager requestWhenInUseAuthorization];           // 请求定位服务
    }
    _manager.delegate = self;
    [_manager startUpdatingLocation];
    

}

#pragma mark - 加载天气状况
- (void)loadWeather:(CLLocationCoordinate2D)coordinate2D {

    NSString *location = [NSString stringWithFormat:@"%.2f:%.2f", coordinate2D.latitude, coordinate2D.longitude];
    [CNetWorking loadWeatherWithLocation:location
                                 success:^(id response) {
                                     // 设置UI
                                     if (response[@"results"] != nil) {
                                         NSDictionary *dic = [response[@"results"] firstObject];
                                         [self setWeatherUI:dic];
                                     }
                                 } failure:^(NSError *err) {
                                     
                                 }];

}



#pragma mark - 测试接口
- (void)testURL {
    
    NSString *password = @"key=dnpxa-vqis1-mcxez-2repg-kp8di-vhujq-pxccv&version=2";
    char *encData = NULL;
    const char *a = [password UTF8String];

    EncryptPassword(a, &encData, NULL);
    
    NSString *encPassword = [NSString stringWithUTF8String:encData];
    
    NSLog(@"%@", encPassword);
    
    NSDictionary *para = @{@"signature" : encPassword};
    
    NSString *urlPath = @"https://api.btctrade.com/api/balance";
    
    AFHTTPSessionManager *menager = [AFHTTPSessionManager manager];
    [menager POST:urlPath parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@", error);
        
    }];
    

}
















@end
