//
//  IMInputBar.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/20.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMInputBar : UIView


@property (weak, nonatomic) IBOutlet UITextField *inputView;

+ (instancetype)viewFromXIB;

@end
