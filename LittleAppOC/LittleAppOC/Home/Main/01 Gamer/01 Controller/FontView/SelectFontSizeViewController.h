//
//  SelectFontSizeViewController.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/16.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectFontSizeViewControllerDelegate <NSObject>

@optional
// 确定按钮，选择了字体
- (void)didSelectFont:(UIFont *)font;

@end


@interface SelectFontSizeViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UISlider *sizeSlider;

@property (weak, nonatomic) IBOutlet UIPickerView *fontPickerView;

@property (weak, nonatomic) id<SelectFontSizeViewControllerDelegate> delegate;


@end
