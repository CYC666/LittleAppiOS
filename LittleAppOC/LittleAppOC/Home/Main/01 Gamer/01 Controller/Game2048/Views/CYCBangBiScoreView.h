//
//  CYCBangBiScoreView.h
//  XiaoHuiBang
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

// 获得邦币的视图

#import <UIKit/UIKit.h>

@interface CYCBangBiScoreView : UIView

@property (nonatomic) NSInteger score;

+ (instancetype)bangBiScoreViewWithCornerRadius:(CGFloat)radius
                                backgroundColor:(UIColor *)color
                                      textColor:(UIColor *)textColor
                                       textFont:(UIFont *)textFont
                                          frame:(CGRect)frame;

@end
