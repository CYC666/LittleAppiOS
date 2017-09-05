//
//  FontFlowShowViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/16.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "FontFlowShowViewController.h"

@interface FontFlowShowViewController () {

    UIScrollView *_mainScrollView;

}

@end

@implementation FontFlowShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 滑动视图
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth, _textFont.pointSize*(_showText.length) + kScreenHeight*2);
    _mainScrollView.backgroundColor = _showGroundColor;
    [self.view addSubview:_mainScrollView];
    
    // 文本+旋转
    CGFloat width = _textFont.pointSize * (_showText.length) + kScreenHeight*2;
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, kScreenWidth)];
    textLabel.text = _showText;
    textLabel.textColor = _textColor;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = _textFont;
    textLabel.layer.anchorPoint = CGPointMake(0, 0.5);
    textLabel.layer.position = CGPointMake(kScreenWidth*0.5, 0);
    textLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    [_mainScrollView addSubview:textLabel];
    
    // 点击手势返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:tap];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

}



- (void)hide {

    [self dismissViewControllerAnimated:YES completion:nil];

}



































@end
