//
//  TranslateController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/11.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "TranslateController.h"
#import "CNetWorking.h"
#import "ThemeManager.h"

@interface TranslateController () <UITextViewDelegate>

@end

@implementation TranslateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"翻译";
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:tap];
    
    
    _chineseField.delegate = self;
    
}


#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}

#pragma mark - 开始翻译
- (IBAction)startTranslate:(id)sender {
    
    if (_chineseField.text == nil || [_chineseField.text isEqualToString:@""]) {
        return;
    }
    
    
    NSString *word = _chineseField.text;
    
    [CNetWorking translateWithChineseWord:word
                                  success:^(id response) {
                                      
                                      NSMutableString *result = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@", response[@"result"][@"result"]]];
                                      
                                      // 处理换行
                                      [result stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
                                      
                                      
                                      _englishField.text = result;
                                      
                                  } failure:^(NSError *err) {
                                      
                                  }];
    
    
}

#pragma mark - 输入框代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        if (_chineseField.text == nil || [_chineseField.text isEqualToString:@""]) {
            return NO;
        }
        
        
        NSString *word = _chineseField.text;
        
        [CNetWorking translateWithChineseWord:word
                                      success:^(id response) {
                                          
                                          NSString *result = [NSString stringWithFormat:@"%@", response[@"result"][@"result"]];
                                          
                                          // 处理换行
                                          NSString *newText = [result stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
                                          
                                          
                                          
                                          _englishField.text = newText;
                                          
                                      } failure:^(NSError *err) {
                                          
                                      }];
        
        return NO;
    } else {
    
        return YES;
        
    }
    
    
    
}

#pragma mark - 隐藏键盘
- (void)hide {

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}






























@end
