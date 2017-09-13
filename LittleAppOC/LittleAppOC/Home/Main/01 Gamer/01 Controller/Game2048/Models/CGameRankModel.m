//
//  CGameRankModel.m
//  XiaoHuiBang
//
//  Created by CaoYicheng on 2017/1/12.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import "CGameRankModel.h"

@implementation CGameRankModel

//消除关键字的错误提示
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        _user_id = value;
    }
    
}


@end
