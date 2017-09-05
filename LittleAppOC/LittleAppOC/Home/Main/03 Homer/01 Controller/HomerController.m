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

@interface HomerController () <CityListControllerDelegate, UIScrollViewDelegate> {

    // 虚拟导航栏
    CNavigationBar *navView;
    
    // 滑动视图
    UIScrollView *mainScrollView;
    
    // 地址标签
    UILabel *locationLabel;
    NSDictionary *locationDic;

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
    //    mainScrollView.delegate = self;
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
    
    
    
    
}




#pragma mark ========================================动作响应=============================================

#pragma mark - 搜索框点击了return
- (void)searchReturnAction:(UITextField *)field {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:field.text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
    
    // 计算导航栏的alpha值
    CGFloat navAlpha = 0;
    if (scrollView.contentOffset.y <= 0) {
        navAlpha = 0;
    } else if (scrollView.contentOffset.y <= 500) {
        navAlpha = scrollView.contentOffset.y * 0.002;
    } else {
        navAlpha = 1;
    }
    
    // 设置颜色
    navView.backgroundColor = [UIColor colorWithWhite:0 alpha:navAlpha];
    
}




#pragma mark ========================================通知================================================
#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    mainScrollView.backgroundColor = CTHEME.themeColor;
    
}























@end
