//
//  WeChatFinshView.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatFinshView : UIView

@property (weak, nonatomic) IBOutlet UILabel *field;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



+ (instancetype)viewFromXIB;



@end
