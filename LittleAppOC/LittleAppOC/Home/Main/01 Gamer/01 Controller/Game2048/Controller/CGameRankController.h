//
//  CGameRankController.h
//  XiaoHuiBang
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

// 游戏排行榜

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GAME2048 = 1,       // 2048
    COLORGAME,      // 色差游戏
} CGAMETYPE;

@interface CGameRankController : UIViewController

- (instancetype)initWithGameType:(CGAMETYPE)type;

@end
