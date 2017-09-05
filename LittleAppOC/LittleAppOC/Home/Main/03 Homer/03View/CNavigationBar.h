//
//  CNavigationBar.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/21.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNavigationBar : UIView


//定位文本
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

//定位按钮
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

//向下的箭头
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;

//搜索框背景视图
@property (weak, nonatomic) IBOutlet UIView *searchView;

//放大镜
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;

//搜索输入框
@property (weak, nonatomic) IBOutlet UITextField *searchField;

//扫码图标
@property (weak, nonatomic) IBOutlet UIImageView *sweepImageView;

//扫码文本
@property (weak, nonatomic) IBOutlet UILabel *sweepLabel;

//扫码按钮
@property (weak, nonatomic) IBOutlet UIButton *sweepButton;







+ (instancetype)viewFromXIB;


@end
