//
//  FontViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/14.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "FontViewController.h"
#import "FontFlowShowViewController.h"
#import "SelectColorController.h"
#import "SelectFontSizeViewController.h"

@interface FontViewController () <SelectFontSizeViewControllerDelegate, UITextViewDelegate> {

    UIFont *_textFont;
    UIColor *_textColor;
    UIColor *_showGroundColor;

}

@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"字幕";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = CTHEME.themeColor;
    
    _textPreView.backgroundColor = [UIColor clearColor];
    _showGroundPreView.backgroundColor = [UIColor clearColor];
    
    
    _inputTextView.delegate = self;
    
    // 点击手势返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:tap];
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    

    
    
    
    
    
    
    
}

#pragma mark - 输入框代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    return YES;

}

#pragma mark - 隐藏键盘
- (void)hide {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}


#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}



#pragma mark - 修改字体颜色
- (IBAction)changeTextColor:(UIButton *)sender {
    
    SelectColorController *ctrl = [[SelectColorController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    
    // 选择了颜色
    ctrl.colorBlock = ^(UIColor *color) {
        
        _textColor = color;
        [_textPreView setBackgroundColor:color];
        
    };
    
}

#pragma mark - 修改背景颜色
- (IBAction)changeShowGroundColor:(UIButton *)sender {
    
    SelectColorController *ctrl = [[SelectColorController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    
    // 选择了颜色
    ctrl.colorBlock = ^(UIColor *color) {
        
        _showGroundColor = color;
        [_showGroundPreView setBackgroundColor:color];
        
    };
    
}

#pragma mark - 修改字体
- (IBAction)changeFont:(id)sender {

    SelectFontSizeViewController *ctrl = [[SelectFontSizeViewController alloc] init];
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];

}

// 选择了字体
- (void)didSelectFont:(UIFont *)font {

    _textFont = font;

}


#pragma mark - 开始
- (IBAction)srartAction:(id)sender {
    
    
    FontFlowShowViewController *ctrl = [[FontFlowShowViewController alloc] init];
    ctrl.showText = _inputTextView.text;
    
    if (_textColor) {
        ctrl.textColor = _textColor;
    } else {
        ctrl.textColor = [UIColor blackColor];
    }
    
    if (_showGroundColor) {
        ctrl.showGroundColor = _showGroundColor;
    } else {
        ctrl.showGroundColor = [UIColor whiteColor];
    }
    
    if (_textFont) {
        ctrl.textFont = _textFont;
    } else {
        ctrl.textFont = [UIFont systemFontOfSize:kScreenWidth];
    }

    [self presentViewController:ctrl animated:YES completion:nil];
    
    
    
    
    
    
    
    
    
    
}

































@end
