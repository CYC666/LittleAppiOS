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

#pragma mark - 点击了跑马灯
- (void)didSelectRollLabel:(NSInteger)index {
    
    FadeAlertView *showMessage = [[FadeAlertView alloc] init];
    [showMessage showAlertWith:[NSString stringWithFormat:@"点击了跑马灯，序号为:%ld", index]];
    
    
}

@end
