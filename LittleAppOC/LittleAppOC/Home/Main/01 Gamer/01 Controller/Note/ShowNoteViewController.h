//
//  ShowNoteViewController.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/17.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoteModel;

@interface ShowNoteViewController : UIViewController

@property (strong, nonatomic) NoteModel *model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidthConstraint;






@end
