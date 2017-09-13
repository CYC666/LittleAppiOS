//
//  CYCBestScoreView.h
//  XiaoHuiBang
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYCBestScoreView : UIView

@property (nonatomic) NSInteger score;

+ (instancetype)bestScoreViewWithCornerRadius:(CGFloat)radius
                              backgroundColor:(UIColor *)color
                                    textColor:(UIColor *)textColor
                                     textFont:(UIFont *)textFont
                                    bestScore:(NSInteger)score
                                        frame:(CGRect)frame;


@end
