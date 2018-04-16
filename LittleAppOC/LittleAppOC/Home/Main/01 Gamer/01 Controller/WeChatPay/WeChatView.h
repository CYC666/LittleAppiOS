//
//  WeChatView.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *imageUP;
@property (weak, nonatomic) IBOutlet UIImageView *imageDOWN;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;


+ (instancetype)viewFromXIB;




@end
