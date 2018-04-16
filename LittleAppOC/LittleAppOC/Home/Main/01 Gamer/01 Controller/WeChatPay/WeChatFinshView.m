//
//  WeChatFinshView.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "WeChatFinshView.h"

@implementation WeChatFinshView

//简单封装了创建xib的方法
+ (instancetype)viewFromXIB {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WeChatFinshView" owner:nil options:nil] firstObject];
    
}

@end
