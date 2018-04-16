//
//  CBaseViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/21.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CBaseViewController.h"
#import "MMDrawerController.h"

@interface CBaseViewController ()

@end

@implementation CBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = _navTitle;
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


//（1）、视图将要出现的时候,禁用MMDrawCtrls
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //获取根视图控制器
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    
}
//（2）、视图将要消失的时候,还原一下
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    
}




































@end
