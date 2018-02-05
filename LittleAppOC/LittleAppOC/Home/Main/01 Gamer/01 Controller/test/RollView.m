//
//  RollView.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/5.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "RollView.h"
#import "RollLabelInfo.h"

@interface RollView ()  {
    
    CGFloat width;      // 宽高
    CGFloat height;
}

@end

@implementation RollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self creatSubviewsAction];
        
    }
    return self;
    
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self creatSubviewsAction];
    
}


-(void)dealloc {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

#pragma mark - UI模块
- (void)creatSubviewsAction {
    
    width = self.frame.size.width;
    height = self.frame.size.height;
    _index = 0;
    self.clipsToBounds = YES;
    
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    // 设置初始显示
    RollLabelInfo *model = _dataArray.firstObject;
    self.labelA.text = model.fullhead;
    
    // 点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
}

- (UILabel *)labelA {
    
    if (!_labelA) {
        _labelA = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _labelA.textAlignment = NSTextAlignmentLeft;
        _labelA.textColor = [UIColor blackColor];
        [self addSubview:_labelA];
    }
    return _labelA;
    
}

#pragma mark - 定时器刷新
- (void)timerAction:(NSTimer *)timer {
    
    // 思路：
    // 两个label向上滚，滚完只留下当前显示的label，用labelA保存、显示即可
    
    
    // 临时显示
    __block UILabel *_labelB = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, height)];
    _labelB.textAlignment = NSTextAlignmentLeft;
    _labelB.textColor = [UIColor blackColor];
    [self addSubview:_labelB];
    
    
    _index ++;
    __block NSString *showText = @"";
    if (_index < _dataArray.count) {
        RollLabelInfo *model = _dataArray[_index];
        showText = model.fullhead;
    } else {
        _index = 0;
        RollLabelInfo *model = _dataArray[_index];
        showText = model.fullhead;
    }
    _labelB.text = showText;
    
    
    [UIView animateWithDuration:0.35 animations:^{
        
        _labelA.transform = CGAffineTransformMakeTranslation(0, -height);
        _labelB.transform = CGAffineTransformMakeTranslation(0, -height);
        
    } completion:^(BOOL finished) {
        
        [_labelB removeFromSuperview];
        _labelB = nil;
        _labelA.text = showText;
        _labelA.transform = CGAffineTransformMakeTranslation(0, 0);
        
    }];
    
}


#pragma mark - 设置数据源
- (void)setDataArray:(NSArray *)dataArray {
    
    if (dataArray.count > 0) {
        _dataArray = dataArray;
        
    }
    
    
}

#pragma mark - 点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        
        // 实行代理方法
        [_delegate didSelectRollLabel:_index];
        
    }
    
}































@end
