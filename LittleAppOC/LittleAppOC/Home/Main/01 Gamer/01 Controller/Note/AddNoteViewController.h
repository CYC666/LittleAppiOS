//
//  AddNoteViewController.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/17.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoteViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIView *inputView;


@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;


@end
