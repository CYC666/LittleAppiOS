//
//  OverColorViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/17.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "OverColorViewController.h"

@interface OverColorViewController () {

    CAGradientLayer *gradientColorLayer;

}

@end

@implementation OverColorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"颜色渐变";
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
    
    
    
    [self setOverColor];
    [self setSliderAction];
    
    
    
    
    
}



#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}


#pragma mark - 设置颜色渐变
- (void)setOverColor {

    /**< 初始化colorsView */
    UIView *colorsView = [[UIView alloc] init];
    colorsView.frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth);
    [self.view addSubview:colorsView];
    
    /**< 初始化渐变层 */
    gradientColorLayer = [CAGradientLayer layer];
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
    gradientColorLayer.endPoint   = CGPointMake(1, 0);
    

    

}


#pragma mark - 滑动条
- (void)setSliderAction {
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 64 + kScreenWidth, kScreenWidth - 40, 30)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    slider.value = 0.5;
    [slider addTarget:self action:@selector(didChangeSliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    
}

- (void)didChangeSliderValue:(UISlider *)slider {

    gradientColorLayer.locations  = @[@(slider.value)];

}
































@end
