//
//  CBeginEndButton.m
//  XiaoHuiBang
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import "CBeginEndButton.h"

@interface CBeginEndButton ()

@property (strong, nonatomic) UIImageView *mainImageView;
@property (copy, nonatomic) NSString *unTouchImageStr;
@property (copy, nonatomic) NSString *touchImageStr;

@end

@implementation CBeginEndButton


- (instancetype)initWithFrame:(CGRect)frame unTouchImage:(NSString *)imageA touchImage:(NSString *)imageB {

    _unTouchImageStr = imageA;
    _touchImageStr = imageB;
    
    if (self = [super initWithFrame:frame]) {
        _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mainImageView.image = [UIImage imageNamed:imageA];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_mainImageView];
        
    }
    return self;

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _mainImageView.image = [UIImage imageNamed:_touchImageStr];
    self.startBlock();

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _mainImageView.image = [UIImage imageNamed:_unTouchImageStr];
    self.endBlock();

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _mainImageView.image = [UIImage imageNamed:_unTouchImageStr];
    self.endBlock();

}

































@end
