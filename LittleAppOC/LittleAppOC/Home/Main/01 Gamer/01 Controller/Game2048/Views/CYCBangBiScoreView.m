//
//  CYCBangBiScoreView.m
//  XiaoHuiBang
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import "CYCBangBiScoreView.h"



@interface CYCBangBiScoreView ()
@property (nonatomic, strong) UILabel *scoreLabel;
@end



@implementation CYCBangBiScoreView



+ (instancetype)bangBiScoreViewWithCornerRadius:(CGFloat)radius
                                backgroundColor:(UIColor *)color
                                      textColor:(UIColor *)textColor
                                       textFont:(UIFont *)textFont
                                          frame:(CGRect)frame{
    CYCBangBiScoreView *view = [[[self class] alloc] initWithFrame:frame];
    view.score = 0;
    view.layer.cornerRadius = radius;
    view.backgroundColor = color ?: [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    if (textColor) {
        view.scoreLabel.textColor = textColor;
    }
    if (textFont) {
        view.scoreLabel.font = textFont;
    }
    return view;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    UILabel *bangbiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2.0)];
    bangbiLabel.text = @"邦币";
    bangbiLabel.textColor = [UIColor whiteColor];
    bangbiLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40];
    bangbiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:bangbiLabel];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2.0, self.bounds.size.width, self.bounds.size.height/2.0)];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.adjustsFontSizeToFitWidth = YES;
    scoreLabel.textColor = [UIColor whiteColor];
    [self addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    return self;
}

- (void)setScore:(NSInteger)score {
    _score = score;
    self.scoreLabel.text = @"绿包";
    // self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)score];
}









































@end
