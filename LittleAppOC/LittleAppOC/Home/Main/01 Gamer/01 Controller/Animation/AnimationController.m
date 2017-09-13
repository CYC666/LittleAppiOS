//
//  AnimationController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/13.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "AnimationController.h"

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
