//
//  CScrollView.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/29.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CScrollView.h"

@implementation CScrollView

// 允许其他试图滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
    
}

@end
