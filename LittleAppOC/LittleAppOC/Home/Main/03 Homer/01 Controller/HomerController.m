//
//  HomerController.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/15.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "HomerController.h"
#import "ThemeManager.h"
#import "CNavigationBar.h"
#import "CityListController.h"
#import <YYKit.h>
#import "CDoubleTableView.h"

@interface HomerController () <CityListControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {

    // 虚拟导航栏
    CNavigationBar *navView;
    
    // 滑动视图
    UIScrollView *mainScrollView;
    
    // 地址标签
    UILabel *locationLabel;
    NSDictionary *locationDic;
    
    CDoubleTableView *tableView;

}

@end

@implementation HomerController



#pragma mark ========================================控制器生命周期========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = CTHEME.themeColor;
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self creatUIAction];
    
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}


#pragma mark ========================================私有方法=============================================
#pragma mark - 创建视图
- (void)creatUIAction {
    
    // 滑动视图
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
    mainScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
    mainScrollView.backgroundColor = CTHEME.themeColor;
        mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO; // 这样子滑动视图就不会自动偏移20个像素
    

    
    
    
    // 假的导航栏
    navView = [CNavigationBar viewFromXIB];
    navView.frame = CGRectMake(0, 0, kScreenWidth,110);
    navView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    [self.view addSubview:navView];
    
    locationLabel = navView.locationLabel;
    
    [navView.searchField addTarget:self action:@selector(searchReturnAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [navView.locationButton addTarget:self action:@selector(locationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navView.sweepButton addTarget:self action:@selector(sweepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    /**< 初始化colorsView */
    UIView *colorsView = [[UIView alloc] init];
    colorsView.frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth);
    [mainScrollView addSubview:colorsView];
    
    /**< 初始化渐变层 */
    CAGradientLayer *gradientColorLayer = [CAGradientLayer layer];
    gradientColorLayer.frame = colorsView.bounds;
    [colorsView.layer addSublayer:gradientColorLayer];
    
    /**< 设置颜色组 */
    gradientColorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor blueColor].CGColor];
    
    /**< 设置颜色分割点 */
    gradientColorLayer.locations  = @[@(0.5)];
    
    
    /**< 设置渐变颜色方向 */
    // 1、起始位置
    gradientColorLayer.startPoint = CGPointMake(0, 0);
    // 2、结束位置
    gradientColorLayer.endPoint   = CGPointMake(0, 1);
    
    
    tableView = [[CDoubleTableView alloc] initWithFrame:CGRectMake(0, 400, kScreenWidth, 400) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [mainScrollView addSubview:tableView];
    
    
    // 添加监听刷新的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allowSubViewScrollAction) name:@"允许移动" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(banSubViewScrollAction) name:@"不允许移动" object:nil];
    
}




#pragma mark ========================================动作响应=============================================

#pragma mark - 搜索框点击了return
- (void)searchReturnAction:(UITextField *)field {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [[[UIAlertView alloc] initWithTitle:@"点击了搜索" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil] show];
    
    
    
}


#pragma mark - 定位按钮响应
- (void)locationButtonAction:(UIButton *)button {
    
    CityListController *ctrl = [[CityListController alloc] init];
    
    ctrl.delegate = self;
    
    [self.navigationController pushViewController:ctrl animated:YES];
    
}


#pragma mark - 扫码按钮响应
- (void)sweepButtonAction:(UIButton *)button {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"点击了扫一扫按钮"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}



#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================


#pragma mark - 选择城市代理方法
- (void)didSelectCity:(NSDictionary *)cityDic {
    
    locationDic = cityDic;
    NSString *locationStr = [NSString stringWithFormat:@"%@", cityDic[@"city"]];
    if (locationStr.length > 3) {
        NSString *newStr = [NSString stringWithFormat:@"%@%@", [locationStr substringWithRange:NSMakeRange(0, 3)], @".."];
        locationLabel.text = newStr;
    } else {
        locationLabel.text = locationStr;
    }
    
}



#pragma mark - 滑动视图代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%.2f", scrollView.contentOffset.y);
    
    
    if ([scrollView isEqual:mainScrollView]) {  // 父视图
        
        // 定义滑动多少距离之后不能再滑动
        CGFloat distance = 200;
        
        if (_allowSubViewScroll) {
            
            // 不允许移动
            scrollView.contentOffset = CGPointMake(0, distance);
            scrollView.showsVerticalScrollIndicator = NO;
        } else {

            // 当前滑动视图的偏移
            CGFloat offsetY = scrollView.contentOffset.y;
            
            if (offsetY >= distance) {
                scrollView.contentOffset = CGPointMake(0, distance);
                _allowSubViewScroll = YES;
                
            } else {
                _allowSubViewScroll = NO;
            }
            
            scrollView.showsVerticalScrollIndicator = YES;
            
        }
        
    } else if ([scrollView isEqual:tableView]) {    // 子视图
    
        if (_allowSubViewScroll) {
            // 允许移动
            
            // 当前滑动视图的偏移
            CGFloat offsetY = scrollView.contentOffset.y;
            if (offsetY <= 0) {
                scrollView.contentOffset = CGPointMake(0, 0);
                _allowSubViewScroll = NO;
            } else {
                _allowSubViewScroll = YES;
            }
            
            scrollView.showsVerticalScrollIndicator = YES;
            
        } else {
        
            // 不允许移动
            scrollView.contentOffset = CGPointMake(0, 0);
            _allowSubViewScroll = NO;
            
            scrollView.showsVerticalScrollIndicator = NO;
        }
    
    }
    
    

    
    
}

#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
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
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell"];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark ========================================通知================================================
#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    mainScrollView.backgroundColor = CTHEME.themeColor;
    
}


#pragma mark - 允许子视图移动
- (void)allowSubViewScrollAction {
    
    _allowSubViewScroll = YES;
    
}

#pragma mark - 不允许子视图移动
- (void)banSubViewScrollAction {
    
    _allowSubViewScroll = NO;
    
}



















@end
