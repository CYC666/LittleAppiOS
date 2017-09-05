//
//  SelectFontSizeViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/16.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "SelectFontSizeViewController.h"

@interface SelectFontSizeViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {

    NSArray *_fontList;
    
    CGFloat _fontSize;
    
    NSString *_fontName;

}

@end

@implementation SelectFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"选择字体";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = CTHEME.themeColor;
    
    // 默认
    _fontName = @"Arial";
    _fontSize = kScreenWidth;
    
    
    // 字体列表
    _fontList = @[@"Arial",
                  @"AmericanTypewriter",
                  @"AppleGothic",
                  @"Courier",
                  @"CourierNewPSMT",
                  @"Georgia",
                  @"Helvetica",
                  @"HelveticaNeue",
                  @"HiraKakuProN-W3",
                  @"TimesNewRomanPSMT",
                  @"TrebuchetMS",
                  @"Verdana",
                  @"Zapfino",
                  @"迷你简胖娃",
                  @"DFPWAWAW7-B5"];

    // 设置滑动条
    _sizeSlider.maximumValue = kScreenWidth;
    _sizeSlider.minimumValue = 10.0f;
    _sizeSlider.value = kScreenWidth;
    
    // 设置字体选择器
    _fontPickerView.delegate = self;
    _fontPickerView.dataSource = self;
    
    
    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"确定" forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 60, 22);
    [rightItem addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    
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


#pragma mark - 修改大小
- (IBAction)changeSizeAction:(UISlider *)sender {
    
    _fontSize = sender.value;
    
    _tipLabel.font = [UIFont fontWithName:_fontName size:_fontSize];
    
    
}


#pragma mark - 确认
- (void)sureAction:(UIButton *)button {
    
    UIFont *font = [UIFont fontWithName:_fontName size:_fontSize];
    
    if ([_delegate respondsToSelector:@selector(didSelectFont:)]) {
        [_delegate didSelectFont:font];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 提示字体按钮，点击切换中英文
- (IBAction)changeChineseOrEnglish:(UIButton *)sender {
    
    if ([_tipLabel.text isEqualToString:@"思"]) {
        _tipLabel.text = @"S";
    } else {
        _tipLabel.text = @"思";
    }
    
}



#pragma mark - 字体选择器代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;

}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return _fontList.count;

}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    NSString *title = _fontList[row];
    return title;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    _fontName = _fontList[row];
    
    _tipLabel.font = [UIFont fontWithName:_fontName size:_fontSize];

}


























@end
