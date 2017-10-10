//
//  DailyController.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/18.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "DailyController.h"
#import "ThemeManager.h"

@interface DailyController ()

@end

@implementation DailyController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backItemAction:)];
    [backItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.view.backgroundColor = CTHEME.themeColor;
    self.textView.textColor = CTHEME.themeType == CDayTheme ? C_MAIN_TEXTCOLOR : [UIColor whiteColor];
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
}

#pragma mark - 返回按钮响应
- (void)backItemAction:(UIBarButtonItem *)item {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    self.textView.textColor = CTHEME.themeType == CDayTheme ? C_MAIN_TEXTCOLOR : [UIColor whiteColor];
    
}

#pragma mark - 移除观察者
- (void)dealloc {
    
    [CNOTIFY removeObserver:self name:CThemeChangeNotification object:nil];
    
}







/*
 
 - (void)<#name#>Action:(UIButton *)button {
 
 
 
 }

 
 
 // 表视图
 _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)
 style:UITableViewStylePlain ];
 _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
 _listTableView.backgroundColor = [UIColor clearColor];
 _listTableView.rowHeight = 60;
 _listTableView.delegate = self;
 _listTableView.dataSource = self;
 [_listTableView registerNib:[UINib nibWithNibName:@"ZGBankCardSelectTableViewCell" bundle:[NSBundle mainBundle]]
 forCellReuseIdentifier:UITableViewCellID];
 [self.view addSubview:_listTableView];
 
 #pragma mark - 表视图代理方法
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
 return <#expression#>;
 
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
 return <#expression#>;
 
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 return 60.0;
 
 
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 
 return 0.01;
 
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 
 return 10.0;
 
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID
 forIndexPath:indexPath];
 
 return cell;
 
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
 }
 
 //简单封装了创建xib的方法
 + (instancetype)viewFromXIB {
 
 NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PersonalCenterView" owner:nil options:nil];
 return views[0];
 
 }
 
 FadeAlertView *showMessage = [[FadeAlertView alloc] init];
 [showMessage showAlertWith:@"<##>"];
 
 // 弹框提示是否执行
 UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
 message:@"<##>"
 preferredStyle:UIAlertControllerStyleAlert];
 
 [alert addAction:[UIAlertAction actionWithTitle:@"取消"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * _Nonnull action) {
 
 }]];
 [alert addAction:[UIAlertAction actionWithTitle:@"确定"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * _Nonnull action) {
 
 
 
 }]];
 
 [self presentViewController:alert animated:YES completion:nil];
 
 
 [self.navigationController popViewControllerAnimated:YES];
 
 
 
 */










//- (void)<#name#>Action:(UIButton *)button {
//    
//    
//    
//}
//
//
//
//
//// 表视图
//_listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)
//                                              style:UITableViewStylePlain ];
//_listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//_listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//_listTableView.backgroundColor = [UIColor clearColor];
//_listTableView.rowHeight = 60;
//_listTableView.delegate = self;
//_listTableView.dataSource = self;
//[_listTableView registerNib:[UINib nibWithNibName:@"ZGBankCardSelectTableViewCell" bundle:[NSBundle mainBundle]]
//     forCellReuseIdentifier:UITableViewCellID];
//[self.view addSubview:_listTableView];
//
//
//
//
//
//#pragma mark - 表视图代理方法
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return <#expression#>;
//    
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return <#expression#>;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 60.0;
//    
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.01;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 10.0;
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID
//                                                            forIndexPath:indexPath];
//    
//    return cell;
//    
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}
//
//
//
//
//
////简单封装了创建xib的方法
//+ (instancetype)viewFromXIB {
//    
//    return [[[NSBundle mainBundle] loadNibNamed:@"MainNavigationBar" owner:nil options:nil] firstObject];
//    
//}
//
//
//
//
//
//FadeAlertView *showMessage = [[FadeAlertView alloc] init];
//[showMessage showAlertWith:@"<##>"];
//
//
//
//
//
//// 弹框提示是否执行
//UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
//                                                               message:@"<##>"
//                                                        preferredStyle:UIAlertControllerStyleAlert];
//
//[alert addAction:[UIAlertAction actionWithTitle:@"取消"
//                                          style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * _Nonnull action) {
//                                            
//                                        }]];
//[alert addAction:[UIAlertAction actionWithTitle:@"确定"
//                                          style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * _Nonnull action) {
//                                            
//                                            
//                                            
//                                        }]];
//
//[self presentViewController:alert animated:YES completion:nil];
//
//
//
//[self.navigationController popViewControllerAnimated:YES];
//
//
//
//
//self.navigationItem.title = @"<##>";
//
//
//
//
//// 导航栏右边的添加按钮
//UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
//[rightItem setImage:[UIImage imageNamed:@"ZG添加"]  forState:UIControlStateNormal];
//[rightItem setTintColor:[UIColor whiteColor]];
//rightItem.frame = CGRectMake(0, 0, 40, 22);
//[rightItem addTarget:self action:@selector(searchGoodsList:) forControlEvents:UIControlEventTouchUpInside];
//UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
//self.navigationItem.rightBarButtonItem = rightBarItem;
//
//
//
//dispatch_group_t group = dispatch_group_create();
//dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
//    // 并行执行的线程一
//});
//dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
//    // 并行执行的线程二
//});
//dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
//    // 上面的线程走完成后，最后通知走次block，保证这部分代码最后执行
//});
//
//
//
//
//// 发送通知
//[[NSNotificationCenter defaultCenter] postNotificationName:<#通知名#> object:nil];
//
//
//
//[[[UIAlertView alloc] initWithTitle:@"<#title#>" message:@"<#message#>" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil] show];
//
//
//
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    
//    if (scrollView.contentOffset.x <= 60) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    
//}
//
//
//
//
//// 集合视图
//UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//layout.itemSize = CGSizeMake(kScreenWidth * 0.25, kScreenWidth * 0.25);
//layout.minimumLineSpacing = 0;
//layout.minimumInteritemSpacing = 0;
//
//_listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)
//                                         collectionViewLayout:layout];
//_listCollectionView.backgroundColor = [UIColor clearColor];
//[_listCollectionView registerNib:[UINib nibWithNibName:@"ImageSelectViewCell" bundle:[NSBundle mainBundle]]
//      forCellWithReuseIdentifier:@"ImageSelectViewCell"];
//_listCollectionView.delegate = self;
//_listCollectionView.dataSource = self;
//[self.view addSubview:_listCollectionView];
//
//
//
//
//
//#pragma mark - 集合视图代理方法
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    
//    return 1;
//    
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    
//    return _images.count;
//    
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return CGSizeMake(kScreenWidth, 130);
//    
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    ImageSelectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageSelectViewCell" forIndexPath:indexPath];
//    
//    
//    return cell;
//    
//}
//
//
//
//
//
//
//
//- (void)setValue:(id)value forKey:(NSString *)key {
//    
//    if ([key isEqualToString:@"id"]) {
//        self.backMoneyID = value;
//    }<##>
//    
//}
//
//
//
//
//
//#warning <#警告#>
//
//
//
//
//
//NSMutableArray *list = [NSMutableArray array];
//
//
//
//
//
////主线程更新视图
//dispatch_async(dispatch_get_main_queue(), ^{
//    
//    //去掉无数据时的视图
//    if (noDataView) {
//        [noDataView removeFromSuperview];
//        noDataView = nil;
//    }
//    
//    if (showRecordArray.count == 0) {
//        
//        noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        noDataView.backgroundColor = Background_Color;
//        
//        //图标
//        UIImageView *noDataImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无收益数据"]];
//        noDataImage.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 - 150);
//        [noDataView addSubview:noDataImage];
//        [self.tableView addSubview:noDataView];
//        
//    } else {
//        
//        [self.tableView reloadData];
//        
//    }
//    
//});
//
//
//
//
//
//
//#pragma mark ========================================<#模块#>=============================================
//
//
//
//
//
//[NSString stringWithFormat:@"%@", ];
//
//
//
//
////请求豌豆Java
//NSString *method = @"goods/getHotGoodsList";
//NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:
//                           userInfo.loginToken,@"token",
//                           nil];
//
//
//
//[SOAPUrlSession AFHTTPSessionManager:method parameter:parameter success:^(id responseObject) {
//    
//    //更新本地数据
//    if ([responseObject[@"msgCode"] isEqualToString:@"200"]) {
//        NSLog(@"---%@",responseObject[@"msg"]);
//    }else{
//        //后台连接直接不成功，弹出“连接服务器失败”
//        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
//        [showMessage showAlertWith:responseObject[@"msg"]];
//    }
//    
//    
//} failure:^(NSError *error) {
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //跳转到登录页面
//        LFNavigationController *loginNaviView = (LFNavigationController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
//        //导航视图的根视图就是登录视图
//        LoginViewController *loginView = (LoginViewController *)loginNaviView.topViewController;
//        
//        //设置返回按钮点击后返回的界面的类名，（返回首页传“MainPage”）
//        loginView.backToClassName = @"MainPage";
//        //设置登录成功时返回的界面的类名，（如果遍历self.navigationController.viewControllers没有对应的类，跳到指定页面）
//        loginView.goToClassName = @"MainPage";
//        
//        
//        loginNaviView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        [self presentViewController:loginNaviView animated:YES completion:nil];
//    });
//}];
//
//
//
//__weak typeof(self) weakSelf = self;
//
//
//
//
//
//MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//    
//    [self getOrderData:NO];
//    
//    //关闭刷新
//    [_myTableView.mj_header endRefreshing];
//}];
//header.stateLabel.font = [UIFont systemFontOfSize:12];
//header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
//_myTableView.mj_header = header;
//
//MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//    
//    [self getOrderData:YES];
//    
//    //关闭刷新
//    [_myTableView.mj_footer endRefreshing];
//}];
//footer.automaticallyHidden = YES;//自动根据有无数据来显示和隐藏
//footer.stateLabel.font = [UIFont systemFontOfSize:12];
//_myTableView.mj_footer = footer;
//
//
//
//
//
//
//// 图片
//NSString *path = [NSString stringWithFormat:@"%@%@", Image_Base_URL, model.FilePath];
//[cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:path]
//                      placeholderImage:[UIImage imageNamed:@"loadfail-0"]
//                               options:SDWebImageRetryFailed];
//
//
//
//
//
//
//#pragma mark - 生成二维码
//- (void)creatCodeImage {
//    
//    NSString *urlString = [NSString stringWithFormat:@"http://120.132.13.209:8083/webuser/Registered?EnCode=%@",userInfo.EnCode];
//    /*使用插件生成二维码图片*/
//    UIImageView *image2DCode = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    image2DCode.image = [self create2DBarcodeByURL:urlString withSize:200];
//    [_codeView addSubview:image2DCode];
//    
//}
//
//#pragma mark - 根据url生成二维码方法
//- (UIImage *)create2DBarcodeByURL:(NSString *)urlStr withSize:(CGFloat)size {
//    
//    // 1.创建过滤器
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    // 2.恢复默认
//    [filter setDefaults];
//    // 3.给过滤器添加数据
//    NSString *dataString = urlStr;
//    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//    // 4.通过KVO设置滤镜inputMessage数据
//    [filter setValue:data forKeyPath:@"inputMessage"];
//    // 4.获取输出的二维码
//    CIImage *outputImage = [filter outputImage];
//    //    // 5.将CIImage转换成UIImage，并放大显示
//    //    self.imageView.image = [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
//    
//    // 6.将图片转化的清晰一些
//    UIImage *moreClearImage = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
//    
//    return moreClearImage;
//}
///**
// *  根据CIImage生成指定大小的UIImage
// *
// *  @param image CIImage
// *  @param size  图片宽度
// */
//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
//{
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//    
//    // 1.创建bitmap;
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    
//    // 2.保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    return [UIImage imageWithCGImage:scaledImage];
//}
//
//
//
//
//
//
//- (void)viewWillDisappear:(BOOL)animated {
//    
//    [super viewWillDisappear:animated];
//    
//    //停止风火轮
//    [smallFunc stopActivityIndicator:@"<##>"];
//    
//    
//}
//
//
//
//
//[[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//
//
//#pragma mark - 收起键盘
//- (void)hideKeyBoardAction {
//    
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//    
//}
//
//
//
//
//// 弹框提示是否执行
//UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
//                                                               message:@"支付订单"
//                                                        preferredStyle:UIAlertControllerStyleAlert];
//
//[alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
//    textField.placeholder = @"请输入您的支付密码";
//    textField.secureTextEntry = YES;
//    textField.keyboardType = UIKeyboardTypeNumberPad;
//    textField.textAlignment = NSTextAlignmentCenter;
//}];
//
//[alert addAction:[UIAlertAction actionWithTitle:@"取消"
//                                          style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * _Nonnull action) {
//                                            
//                                        }]];
//[alert addAction:[UIAlertAction actionWithTitle:@"确定支付"
//                                          style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * _Nonnull action) {
//                                            
//                                            NSString *password = alert.textFields.firstObject.text;
//                                            
//                                        }]];
//
//[self presentViewController:alert animated:YES completion:nil];
//
//
//
//
//
//
//
//UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(<#selector#>)];
//[self.view addGestureRecognizer:tap];
//
//
//
//
//
//- (void)<#方法名#>Action {
//    
//    
//    
//}
//
//
//
//UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveCodeImageAction:)];
//longPress.minimumPressDuration = 1.5;
//[image2DCode addGestureRecognizer:longPress];
//
//
//
//
//
//// 添加监听刷新的通知
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(<#selector#>) name:<#通知名#> object:nil];
//
//
//
//
//NSString *method = [NSString stringWithFormat:@"LookOverShopcart"];
//NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                     userInfo.UserId,@"UserId",             //用户编号
//                     nil];
//
////发送soap请求
//[SOAPUrlSession SOAPDataWithMethod:method parameter:dic success:^(id responseObject) {
//    
//    //返回的Code字段：200-成功，300-失败，400-无数据，500-内部服务异常
//    NSString *responseCode = [NSString stringWithFormat:@"%@",responseObject[@"Code"]];
//    
//    if ([responseCode isEqualToString:@"200"]) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            
//            
//        });
//        
//        
//    } else {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            FadeAlertView *showMessage = [[FadeAlertView alloc] init];
//            [showMessage showAlertWith:responseObject[@"Message"]];
//            
//        });
//        
//    }
//} failure:^(NSError *error) {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        //后台连接直接不成功，弹出“连接服务器失败”
//        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
//        [showMessage showAlertWith:@"网络异常：连接服务器失败"];
//    });
//    
//}];
//
//
//
//
//
//[<#target#> addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
//
//
//
//
//
//
//// ==========<#title#>==========
//// <#描述#>
//
//
//
//
////显示风火轮
//[smallFunc createActivityIndicator:self.view AndKey:@"<##>"];
//
//
//
//#pragma mark ========================================控制器生命周期========================================
//
//#pragma mark ========================================私有方法=============================================
//
//#pragma mark ========================================动作响应=============================================
//
//#pragma mark ========================================网络请求=============================================
//
//#pragma mark ========================================代理方法=============================================
//
//#pragma mark ========================================通知================================================
//
//
//
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
//    title.text = @"字幕";
//    title.font = [UIFont boldSystemFontOfSize:17];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = title;
//    
//    self.view.backgroundColor = CTHEME.themeColor;
//    
//    
//    // 监听主题改变
//    [CNOTIFY addObserver:self
//                selector:@selector(changeBackgroundColor:)
//                    name:CThemeChangeNotification
//                  object:nil];
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//}
//
//
//
//#pragma mark - 主题改变，修改背景颜色
//- (void)changeBackgroundColor:(NSNotification *)notification {
//    
//    self.view.backgroundColor = CTHEME.themeColor;
//    
//}
//
//
//
//
//
//
//
//
//
//[[NSNotificationCenter defaultCenter] removeObserver:self name:<#通知名#> object:nil];
//
//
//
//
//
////停止风火轮
//[smallFunc stopActivityIndicator:@"<##>"];
//
//
//
//UserInformation *userInfo;              // 用户信息单例
//
//SmallFunctionTool *smallFunc;           // 工具方法单例
//
//
//
//
////初始化
//userInfo = [UserInformation sharedInstance];
//smallFunc = [SmallFunctionTool sharedInstance];
//
//
//
//
////主线程更新视图
//dispatch_async(dispatch_get_main_queue(), ^{
//    
//    <#操作#>
//    
//});
//
//
//
//
//
//
//#pragma mark -
//
//
///**
// <#Description#>
// 
// @param weak <#weak description#>
// @param nonatomic <#nonatomic description#>
// @return <#return value description#>
// */
//
//
////------------------------<#title#>-------------------------
//
//
//
//
//@property (copy, nonatomic) NSString *<##>;
//
//
//baseView = [AddJingYingXuKeView viewFromXIB];
//baseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, AddJingYingXuKeViewHeight);
//CGRect originalFrame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
//[self addScrollViewForXib:baseView withFrame:originalFrame];
//
//
//
//<#button#> = [UIButton buttonWithType:UIButtonTypeCustom];
//<#button#>.frame = CGRectMake(<#X#>, <#Y#>, <#width#>, <#height#>);
//[<#button#> setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//[<#button#> addTarget:self action:@selector(<#方法名#>) forControlEvents:UIControlEventTouchUpInside];
//[_navView addSubview:<#button#>];
//
//
//<#imageview#> = [[UIImageView alloc] initWithFrame:CGRectMake(<#X#>, <#Y#>, <#width#>, <#height#>)];
//<#imageview#>.image = [UIImage imageNamed:@"<#图片名字#>"];
//<#imageview#>.contentMode = UIViewContentModeCenter;
//[_tabView addSubview:<#imageview#>];
//
//
//
//
////请求Java
//NSDictionary *dic = @{@"phone" : userInfo.phone};
//[SOAPUrlSession AFHTTPSessionManager:@"getRecom" parameter:dic success:^(id responseObject) {
//    
//    
//    NSArray *list = responseObject[@"list"];
//    for (NSDictionary *dic in list) {
//        
//        ZGFriendModel *mdoel = [[ZGFriendModel alloc] init];
//        mdoel.nickname = [NSString stringWithFormat:@"%@", dic[@"nickname"]];
//        mdoel.headURL = [NSString stringWithFormat:@"%@", dic[@"headURL"]];
//        mdoel.phone = [NSString stringWithFormat:@"%@", dic[@"phone"]];
//        
//        [dataList addObject:mdoel];
//        
//    }
//    
//    //主线程更新视图
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        [_groupTableView reloadData];
//        
//    });
//    
//    
//} failure:^(NSError *error) {
//    //后台连接直接不成功，弹出“连接服务器失败”
//    FadeAlertView *showMessage = [[FadeAlertView alloc] init];
//    [showMessage showAlertWith:@"网络异常：连接服务器失败"];
//}];
//
//
//
//
//
//<#label#> = [[UILabel alloc] initWithFrame:CGRectMake(<#X#>, <#Y#>, <#width#>, <#height#>)];
//<#label#>.textAlignment = NSTextAlignmentCenter;
//<#label#>.adjustsFontSizeToFitWidth = YES;
//<#label#>.textColor = [UIColor whiteColor];
//<#label#>.font = [UIFont systemFontOfSize:17];
//[_navView addSubview:<#label#>];
//
//
//
//
//UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
//                                                               message:@"<#标题#>"
//                                                        preferredStyle:UIAlertControllerStyleAlert];
//
//[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//    
//}]];
//
//[self presentViewController:alert animated:YES completion:nil];
//
//
//
//
//<#controller#> *ctrl = [[<#controller#> alloc] init];
//[self.navigationController pushViewController:ctrl animated:YES];
//
//
//
//listTableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: UITableViewStyle.plain)
//listTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//listTableView.separatorStyle = UITableViewCellSeparatorStyle.none
//listTableView.backgroundColor = UIColor.white
//listTableView.register(UINib(nibName: "CityListCell", bundle: Bundle.main), forCellReuseIdentifier: "CityListCell")
//listTableView.delegate = self
//listTableView.dataSource = self
//view.addSubview(listTableView)
//
//
//
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 10
//}
//
//func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//}
//
//func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 40.0
//}
//
//func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 25.0
//}
//
//func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return 0.01
//}
//
//func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    
//}
//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    
//    let cell : CityListCell = tableView.dequeueReusableCell(withIdentifier: "CityListCell", for: indexPath) as! CityListCell
//    
//    
//    
//    
//    return cell
//    
//}
//
//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    
//    tableView.deselectRow(at: indexPath, animated: true)
//    
//}
//
//
//
//
//
//
//
//
//
//// MARK:======================================代理方法========================================
//public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return titleArray.count
//}
//
//public func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return 1
//}
//
//public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    
//    let cell : LittlePlayerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LittlePlayerCell", for: indexPath) as! LittlePlayerCell
//    
//    // 图片
//    cell.iconImageView.image = UIImage(named: titleArray[indexPath.row])
//    
//    // 标题
//    cell.nameLabel.text = titleArray[indexPath.row]
//    
//    return cell
//    
//}
//
//public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    
//    let cell : LittlePlayerCell = collectionView.cellForItem(at: indexPath) as! LittlePlayerCell
//    
//    UIView.animate(withDuration: 0.15, animations: {
//        cell.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
//    }) { (true) in
//        UIView.animate(withDuration: 0.2, animations: {
//            cell.transform = CGAffineTransform.init(scaleX: 1, y: 1)
//        })
//    }
//    
//    if cell.nameLabel.text == "取色板" {
//        let ctrl = SelectColorViewController()
//        ctrl.delegate = self
//        navigationController?.pushViewController(ctrl, animated: true)
//        
//    } else if cell.nameLabel.text == "城市列表" {
//        let ctrl = CityListViewController()
//        navigationController?.pushViewController(ctrl, animated: true)
//        
//    }
//    
//    
//}
//
//
//
//
//
//t = UICollectionViewFlowLayout()
//flowLayout.minimumInteritemSpacing = 0
//flowLayout.minimumLineSpacing = 0
//flowLayout.itemSize = CGSize(width: kScreenWidth * 0.25, height: kScreenWidth * 0.25 + 15)
//mainCollectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight) , collectionViewLayout: flowLayout)
//mainCollectionView?.backgroundColor = UIColor.white
//mainCollectionView?.alwaysBounceVertical = true
//mainCollectionView?.register(UINib(nibName: "LittlePlayerCell", bundle:Bundle.main), forCellWithReuseIdentifier: "LittlePlayerCell")
//mainCollectionView?.delegate = self
//mainCollectionView?.dataSource = self
//view.addSubview(mainCollectionView!)
//
//
//
//
//let sheetView = UIAlertController(title: nil, message: "<#title#>", preferredStyle: UIAlertControllerStyle.actionSheet)
//let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
//let sureAction = UIAlertAction(title: "<#action#>", style: UIAlertActionStyle.default, handler: {
//    action in
//    
//})
//
//
//sheetView.addAction(sureAction)
//sheetView.addAction(cancelAction)
//
//self.present(sheetView, animated: true, completion: nil)
//
//
//
//let rightItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneAction))
//navigationItem.rightBarButtonItem = rightItem
//
//
//
//
//
//
//
//// MARK:======================================<#title#>========================================
//
//
//
//
//
//// MARK:<#title#>
//
//
//
//
//
//<#View#> = [[UIView alloc] initWithFrame:CGRectMake(<#X#>, <#Y#>, <#width#>, <#height#>)];
//<#View#>.backgroundColor = Public_Color;
//[self.view addSubview:<#View#>];
//




























@end
