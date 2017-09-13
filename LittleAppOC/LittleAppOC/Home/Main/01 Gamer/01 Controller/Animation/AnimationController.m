//
//  AnimationController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/13.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()

@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"动画";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = CTHEME.themeColor;
    
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    
    
    
    
    
    
    
    
    
}



#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}



#pragma mark ========================================控制器生命周期========================================

#pragma mark ========================================私有方法=============================================

#pragma mark ========================================动作响应=============================================

#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================

#pragma mark ========================================通知================================================



































@end
