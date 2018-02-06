//
//  PageView.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/6.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageViewDlegate
-(void)PageViewSelectIndex:(NSInteger)index;
@end

@interface PageView : UIView


- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger )pageCount;

@property (assign, nonatomic) NSInteger currentPage;    // 当前页

// 代理
@property (weak, nonatomic) id<PageViewDlegate> delegate;

@end
