//
//  GamerCell.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/24.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "GamerCell.h"
#import "ThemeManager.h"
#import "CThemeLabel.h"

@implementation GamerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _gameImageView.layer.cornerRadius = 10;

    _gameImageView.clipsToBounds = YES;
    
    [CNOTIFY addObserver:self
                selector:@selector(themeChangeNotification:)
                    name:CThemeChangeNotification
                  object:nil];
    
    
}

- (void)themeChangeNotification:(NSNotification *)notification {

    // 更改描边颜色
    _gameImageView.layer.borderColor = CTHEME.themeType == CDayTheme ? [UIColor blackColor].CGColor : [UIColor whiteColor].CGColor;

}

- (void)setResumeAnimation:(BOOL)resumeAnimation {

    _resumeAnimation = resumeAnimation;
    
    if (resumeAnimation) {
        //1 创建动画对象
        CATransition *trans = [CATransition animation];
        //2 设置动画属性
        trans.duration = 1;
        trans.repeatCount = 1;
        //3 设置动画效果（立方体效果）
        trans.type = @"oglFlip";
        trans.subtype = @"center";
        //4 开始动画
        [self.layer addAnimation:trans forKey:nil];
    }

}


@end
