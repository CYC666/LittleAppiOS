//
//  ShowNoteViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/17.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "ShowNoteViewController.h"
#import "NoteModel.h"

@interface ShowNoteViewController ()

@end

@implementation ShowNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topConstraint.constant = Nav_Height + 20;
    _contentWidthConstraint.constant = kScreenWidth - 30;
    
    _titleLabel.text = _model.noteTitle;
    _contentLabel.text = _model.noteContent;
    
}










@end
