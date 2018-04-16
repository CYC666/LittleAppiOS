//
//  WeChatPayViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "WeChatPayViewController.h"
#import "WeChatView.h"
#import "MMDrawerController.h"
#import "WeChatPayFinishViewController.h"

@interface WeChatPayViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, WeChatPayFinishViewControllerDlegate> {
    
    WeChatView *mainView;
    UIImage *iconImage;
    
}

@end

@implementation WeChatPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微信支付";
    self.view.backgroundColor = CTHEME.themeColor;
    
    mainView = [WeChatView viewFromXIB];
    mainView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:mainView];
    [mainView.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [mainView.iconButton addTarget:self action:@selector(iconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(kScreenWidth - 100, 0, 100, 100);
    [button1 addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

//（1）、视图将要出现的时候,禁用MMDrawCtrls
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //获取根视图控制器
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}
//（2）、视图将要消失的时候,还原一下
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

#pragma mark - 返回
- (void)backAction {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark - 收起键盘
- (void)hideAction {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

#pragma mark - 点击确定按钮
- (void)sureAction:(UIButton *)button {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if (mainView.imageDOWN.image == nil) {
        
        // 选择图片
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        // 跳转到支付成功页面
        WeChatPayFinishViewController *ctrl = [[WeChatPayFinishViewController alloc] init];
        ctrl.mainImage = mainView.imageDOWN.image;
        ctrl.payMoney = mainView.inputField.text;
        ctrl.iconImage = iconImage;
        ctrl.name = mainView.nameField.text;
        ctrl.delegate = self;
        [self presentViewController:ctrl animated:YES completion:nil];
        
    }
    
}

#pragma mark - 设置头像
- (void)iconButtonAction:(UIButton *)button {
    
    // 选择图片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
    
}


#pragma mark - 选取图片的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    if (mainView.imageDOWN.image == nil) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        mainView.imageDOWN.image = image;
    } else {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        iconImage = image;
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 支付完成
- (void)payFinish {
    
    
    [self dismissViewControllerAnimated:NO   completion:nil];
    
}































@end
