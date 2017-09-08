//
//  CDoubleTableView.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/8.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CDoubleTableView.h"

@implementation CDoubleTableView

// 允许本视图滑动的同时，父视图也允许滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        // 添加监听刷新的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(不允许移动) name:@"不允许移动" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(允许移动) name:@"允许移动" object:nil];
    }
    return self;

}


#pragma mark - 不允许移动
- (void)不允许移动 {

    _allowScroll = NO;
    self.contentOffset = CGPointMake(0, 0);
    self.showsVerticalScrollIndicator = NO;

}

#pragma mark - 允许移动
- (void)允许移动 {
    
    _allowScroll = YES;
    self.showsVerticalScrollIndicator = YES;
    
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"不允许移动" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"允许移动" object:nil];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_allowScroll == NO) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"允许移动" object:nil userInfo:nil];
    }
}



































@end
