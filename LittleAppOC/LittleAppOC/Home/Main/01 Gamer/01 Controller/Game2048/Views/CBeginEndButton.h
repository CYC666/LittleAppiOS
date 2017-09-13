//
//  CBeginEndButton.h
//  XiaoHuiBang
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

// 检测按下跟放开状态的按钮


#import <UIKit/UIKit.h>

typedef void(^CBeginEndButtonBlock)();

@interface CBeginEndButton : UIView

- (instancetype)initWithFrame:(CGRect)frame unTouchImage:(NSString *)imageA touchImage:(NSString *)imageB;

@property (copy, nonatomic) CBeginEndButtonBlock startBlock;    // 触摸开始响应的block
@property (copy, nonatomic) CBeginEndButtonBlock endBlock;      // 触摸结束响应的block


@end
