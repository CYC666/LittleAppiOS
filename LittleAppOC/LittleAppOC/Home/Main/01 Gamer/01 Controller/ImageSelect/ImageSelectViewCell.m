//
//  ImageSelectViewCell.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/6.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "ImageSelectViewCell.h"

@implementation ImageSelectViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _iconImageView.clipsToBounds = YES;
    
    _iconImageView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressImage:)];
    longPress.minimumPressDuration = 1.5;
    [_iconImageView addGestureRecognizer:longPress];
    
}


- (void)setAni:(BOOL)ani {

    _ani = ani;
    
    CABasicAnimation *animation = (CABasicAnimation *)[_iconImageView.layer animationForKey:@"rotation"];
    
    if (ani) {
        // 允许动画
        if (animation == nil) {
            [self shakeImage];
        }
    } else {
        // 停止动画
        if (animation) {
            [self resume];
        }
    
    }
    
}

#pragma mark - 动画
- (void)shakeImage {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性，周期时长
    [animation setDuration:0.1];
    
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    _iconImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [_iconImageView.layer addAnimation:animation forKey:@"rotation"];
}


- (void)pause {
    _iconImageView.layer.speed = 0.0;
}

- (void)resume {
    _iconImageView.layer.speed = 1.0;
}




#pragma mark - 长按图片响应
- (void)longPressImage:(UILongPressGestureRecognizer *)longPress {

    if ([_delegate respondsToSelector:@selector(longPressCellAction)]) {
        [_delegate longPressCellAction];
    }

}



























@end
