//
//  AnimationController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/13.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "AnimationController.h"
#import <YYImage.h>



@interface AnimationController () <UIPickerViewDelegate, UIPickerViewDataSource> {

    NSArray *_animationArray;
    
    NSString *_animationString;

}

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
    
    _animationArray = @[@"push",
                        @"reveal",
                        @"cube",
                        @"oglFlip",
                        @"suckEffect",
                        @"pageCurl",
                        @"cameraIrisHollowOpen",
                        @"cameraIrisHollowClose"];
    
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    
    [_startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _animationPicker.delegate = self;
    _animationPicker.dataSource = self;
    _animationPicker.tintColor = [UIColor whiteColor];
    
    
    
    // 播放gif图
//    YYImage *image = [YYImage imageNamed:@"guaiqiao.gif"];
//    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(0, 0, 150, 120);
//    [_gifView addSubview:imageView];
    _gifView.hidden = YES;
    
    
}



#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}



#pragma mark ========================================控制器生命周期========================================

#pragma mark ========================================私有方法=============================================

#pragma mark ========================================动作响应=============================================

#pragma mark - 执行动画
- (void)startAction:(UIButton *)button {
    
    _isAnimation = !_isAnimation;
    
    if (_isAnimation) {
        //1 创建动画对象
        CATransition *trans = [CATransition animation];
        //2 设置动画属性
        trans.duration = 3;
        trans.repeatCount = HUGE_VAL;
        //3 设置动画效果（立方体效果）
        trans.type = _animationString;
        trans.subtype = @"fromLeft";
        //4 开始动画
        [_testView.layer addAnimation:trans forKey:nil];
        
        [button setTitle:@"停  止" forState:UIControlStateNormal];
    } else {
        [_testView.layer removeAllAnimations];
        
        [button setTitle:@"开  始" forState:UIControlStateNormal];
    }
    
//    //1 创建动画对象，参数决定动画效果，不能随便设置
//    CAKeyframeAnimation *key = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    //2设置动画属性
//    key.duration = 2;
//    key.repeatCount = 2;
//    [key setRemovedOnCompletion:NO];
//    //3 设置动画路径
//    //1 创建路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path,NULL,50.0,120.0);
//    // 制作曲线，类似于钢笔工具
//    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,150.0,120.0);
//    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,250.0,120.0);
//    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,350.0,120.0);
//    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,450.0,120.0);
//    //4设置曲线路径
//    key.path = path;
//    //4 添加动画
//    [_testView.layer addAnimation:key forKey:nil];
    
    
    
    
    
    
    
}


#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;

}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return _animationArray.count;

}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return _animationArray[row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    _animationString = _animationArray[row];

}

#pragma mark ========================================通知================================================



































@end
