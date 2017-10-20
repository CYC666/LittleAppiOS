//
//  IMInputBar.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/20.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "IMInputBar.h"

@implementation IMInputBar

//简单封装了创建xib的方法
+ (instancetype)viewFromXIB {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"IMInputBar" owner:nil options:nil] firstObject];
    
}

@end
