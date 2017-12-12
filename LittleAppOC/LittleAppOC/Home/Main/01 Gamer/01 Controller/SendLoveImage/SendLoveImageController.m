//
//  SendLoveImageController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2017/12/13. 双十二刚过
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "SendLoveImageController.h"

@interface SendLoveImageController ()

@end

@implementation SendLoveImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 30, self.view.bounds.size.height - 60, 60, 60);
    [button setImage:[UIImage imageNamed:@"吐舌"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

#pragma mark - 点击弹出点赞动画
- (void)showAction:(UIButton *)button {
    
    // 从哪个视图飞往哪个视图
    [self showMoreLoveAnimateFromView:button addToView:self.view];
    
}



- (void)showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    CGPoint position = CGPointMake(fromView.layer.position.x, fromView.layer.position.y - 30);
    imageView.layer.position = position;
    NSArray *imgArr = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_1"];
    NSInteger img = arc4random()%6;
    imageView.image = [UIImage imageNamed:imgArr[img]];
    [addToView addSubview:imageView];
    
    // -----------出场-----------
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    // -----------表演-----------
    CGFloat duration = 3 + arc4random()%5;
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;
    positionAnimate.duration = duration;
    positionAnimate.fillMode = kCAFillModeForwards;
    positionAnimate.removedOnCompletion = NO;
    
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%50 + arc4random()%100) * sign;
    // 三次贝塞尔曲线，详解看底部注释
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300)
             controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150)
             controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimate.path = sPath.CGPath;
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    // -----------退场-----------
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}


















@end




/*
 
 三次贝塞尔曲线
 左右两个点分别从上下拉出钢笔曲线，就成了这样子的一条贝塞尔曲线
 
 --------------------------------------
 
 x
 ·
 ·
 ·
 ·
 ·
 ·
 ·
 ·
 ·
 x         ·            x
 ·
 ·
 ·
 ·
 ·
 ·
 ·
 ·
 ·
 x
 
 --------------------------------------
 
 
 */



