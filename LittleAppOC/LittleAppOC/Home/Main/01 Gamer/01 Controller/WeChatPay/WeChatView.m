//
//  WeChatView.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "WeChatView.h"

@implementation WeChatView

//简单封装了创建xib的方法
+ (instancetype)viewFromXIB {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WeChatView" owner:nil options:nil] firstObject];
    
}

@end
