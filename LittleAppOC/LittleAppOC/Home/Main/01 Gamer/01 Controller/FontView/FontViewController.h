//
//  FontViewController.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/14.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;


// 字体颜色预览
@property (weak, nonatomic) IBOutlet UIView *textPreView;

// 背景颜色预览
@property (weak, nonatomic) IBOutlet UIView *showGroundPreView;


@end
