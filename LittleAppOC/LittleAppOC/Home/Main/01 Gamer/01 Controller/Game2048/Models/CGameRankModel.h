//
//  CGameRankModel.h
//  XiaoHuiBang
//
//  Created by CaoYicheng on 2017/1/12.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

// 排行榜单条数据的model

#import <Foundation/Foundation.h>

@interface CGameRankModel : NSObject

@property (assign, nonatomic) NSInteger rankNum;
@property (copy, nonatomic) NSString *user_id;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *thumb;
@property (copy, nonatomic) NSString *score;
@property (copy, nonatomic) NSString *max_score;

@end
