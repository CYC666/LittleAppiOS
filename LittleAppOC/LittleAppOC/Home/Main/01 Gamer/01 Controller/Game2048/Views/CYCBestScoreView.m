//
//  CYCBestScoreView.m
//  XiaoHuiBang
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import "CYCBestScoreView.h"


@interface CYCBestScoreView ()
@property (nonatomic, strong) UILabel *scoreLabel;
@end

@implementation CYCBestScoreView


+ (instancetype)bestScoreViewWithCornerRadius:(CGFloat)radius
                              backgroundColor:(UIColor *)color
                                    textColor:(UIColor *)textColor
                                     textFont:(UIFont *)textFont
                                    bestScore:(NSInteger)score
                                        frame:(CGRect)frame{
    CYCBestScoreView *view = [[[self class] alloc] initWithFrame:frame];
    view.score = score;
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
    UILabel *fenshuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*0.4)];
    fenshuLabel.text = @"最高分";
    fenshuLabel.textColor = [UIColor colorWithRed:119/255.0 green:110/255.0 blue:102/255.0 alpha:1];
    fenshuLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:19];
    fenshuLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:fenshuLabel];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 95, 64)];
//    imageView.image = [UIImage imageNamed:@"icon_best_score"];
//    [self addSubview:imageView];
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height*0.4, self.bounds.size.width, self.bounds.size.height*0.6)];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    return self;
}

- (void)setScore:(NSInteger)score {
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)score];
}


@end
