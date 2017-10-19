//
//  TileView.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/19.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "TileView.h"

@implementation TileView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];
        
        // 设置方块
        UIImageView *boxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog1"]];
        boxView.frame = CGRectMake(0, 0, 30, 30);
        boxView.center = CGPointMake(100, 50);
        [self addSubview:boxView];
        self.boxView = boxView;
        
        
        UIImageView *boxView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog1"]];
        boxView2.frame = CGRectMake(0, 0, 30, 30);
        boxView2.center = CGPointMake(150, 50);
        [self addSubview:boxView2];
        
        self.boxViewOther = boxView2;
        
        
        
        UIImageView *boxView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog1"]];
        boxView3.frame = CGRectMake(0, 0, 30, 30);
        boxView3.center = CGPointMake(190, 50);
        [self addSubview:boxView3];
        self.boxView3 = boxView3;
        
        
        UIImageView *boxView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog2"]];
        boxView4.frame = CGRectMake(0, 0, 30, 30);
        boxView4.center = CGPointMake(230, 50);
        [self addSubview:boxView4];
        self.boxView4 = boxView4;
        
        UIImageView *boxView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog1"]];
        boxView5.frame = CGRectMake(0, 0, 30, 30);
        boxView5.center = CGPointMake(270, 50);
        [self addSubview:boxView5];
        self.boxView5 = boxView5;
        
        
        //        self.boxView3 = boxView3;
        //        self.boxView4 = boxView4;
        //        self.boxView5 = boxView5;
        
        // 初始化仿真者
        UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        
        self.animator = animator;
    }
    
    return self;
    
}



@end
