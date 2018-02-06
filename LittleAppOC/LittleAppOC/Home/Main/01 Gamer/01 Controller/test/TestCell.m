//
//  TestCell.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/5.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "TestCell.h"
#import "RollView.h"
#import "RollLabelInfo.h"
#import "PageView.h"

@interface TestCell () <RollViewDlegate> {
    
    
}

@end

@implementation TestCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 滚动文本
    _rollView.delegate = self;
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        RollLabelInfo *model = [[RollLabelInfo alloc] init];
        model.fullhead = [NSString stringWithFormat:@"这里是第%d个元素", i];
        [dataArray addObject:model];
    }
    
    _rollView.dataArray = dataArray;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    
    // 这里获取到_pageFrameView的frame，是在xib中的frame，并不是适配后的最终的frame
    __block PageView *pageFrameView = [[PageView alloc] initWithFrame:_pageFrameView.bounds pageCount:10];
    [_pageFrameView addSubview:pageFrameView];
    
    __block NSInteger count = 0;
    __block NSInteger frameCount = 0;
    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        self.pageView.currentPage = count++;
        if (count >= 3) {
            count = 0;
        }
        
        pageFrameView.currentPage = frameCount++;
        if (frameCount >= 10) {
            frameCount = 0;
        }
        
    }];
    
    
}

#pragma mark - 点击了跑马灯
- (void)didSelectRollLabel:(NSInteger)index {
    
    FadeAlertView *showMessage = [[FadeAlertView alloc] init];
    [showMessage showAlertWith:[NSString stringWithFormat:@"点击了跑马灯，序号为:%ld", index]];
    
    
}

@end
