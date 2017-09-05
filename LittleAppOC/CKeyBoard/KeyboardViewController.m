//
//  KeyboardViewController.m
//  CKeyBoard
//
//  Created by 曹奕程 on 2017/8/23.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // Perform custom UI setup here
//    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    [self.nextKeyboardButton setTitle:@"切换" forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
//    
//    [self.view addSubview:self.nextKeyboardButton];
//    
//    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
//    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    // 切换输入法按钮
    _nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextKeyboardButton.frame = CGRectMake(0, 0, 40, 40);
    _nextKeyboardButton.backgroundColor = [UIColor grayColor];
    [_nextKeyboardButton setImage:[UIImage imageNamed:@"input_globe"] forState:UIControlStateNormal];
    [_nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
    [self.view addSubview:_nextKeyboardButton];
    
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonA.frame = CGRectMake(0, 60, 40, 40);
    buttonA.backgroundColor = [UIColor grayColor];
    [buttonA addTarget:self action:@selector(buttonA) forControlEvents:UIControlEventAllTouchEvents];
    [self.view addSubview:buttonA];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
    
    
}


- (void)buttonA {

    

}



































@end
