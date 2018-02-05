//
//  RollView.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/5.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RollViewDlegate
// 点击事件
-(void)didSelectRollLabel:(NSInteger)index;
@end

@interface RollView : UIView

@property (strong, nonatomic) NSTimer *timer;       // 定时器
@property (strong, nonatomic) UILabel *labelA;      // 用于显示的文本
@property (assign, nonatomic) NSInteger index;      // 序号

// 必须设置
@property (copy, nonatomic) NSArray *dataArray;     // 数据
@property (weak, nonatomic) id<RollViewDlegate> delegate;


@end
