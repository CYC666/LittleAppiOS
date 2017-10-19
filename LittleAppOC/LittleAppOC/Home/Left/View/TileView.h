//
//  TileView.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/19.
//  Copyright © 2017年 CYC. All rights reserved.
//

// 方块

#import <UIKit/UIKit.h>

@interface TileView : UIView

/**  方块视图  */
@property (nonatomic, weak) UIImageView *boxView;

@property (nonatomic, weak) UIImageView *boxViewOther;

@property (nonatomic, weak) UIImageView *boxView3;
@property (nonatomic, weak) UIImageView *boxView4;
@property (nonatomic, weak) UIImageView *boxView5;

/**  仿真者  */
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIPushBehavior *push;



@end
