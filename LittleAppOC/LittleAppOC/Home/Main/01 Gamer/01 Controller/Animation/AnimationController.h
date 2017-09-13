//
//  AnimationController.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/13.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationController : UIViewController

// 测试动画用的视图
@property (weak, nonatomic) IBOutlet UIView *testView;

// 动画类型
@property (weak, nonatomic) IBOutlet UIPickerView *animationPicker;

// 开始动画按钮
@property (weak, nonatomic) IBOutlet UIButton *startButton;



@end
