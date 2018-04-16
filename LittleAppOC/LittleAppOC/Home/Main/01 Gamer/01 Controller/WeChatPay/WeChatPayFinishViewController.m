//
//  WeChatPayFinishViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "WeChatPayFinishViewController.h"
#import "MMDrawerController.h"
#import "WeChatFinshView.h"

@interface WeChatPayFinishViewController ()

@end

@implementation WeChatPayFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CTHEME.themeColor;
    
    WeChatFinshView *mainView = [WeChatFinshView viewFromXIB];
    mainView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    mainView.field.text = _payMoney;
    mainView.iconImage.image = _iconImage;
    mainView.nameLabel.text = _name;
    [self.view addSubview:mainView];
    [mainView.finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

//（1）、视图将要出现的时候,禁用MMDrawCtrls
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //获取根视图控制器
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
//（2）、视图将要消失的时候,还原一下
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark - 完成
- (void)finishAction:(UIButton *)button {
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        // 支付完成
        [_delegate payFinish];
        
    }];
    
    
    
}




































@end
