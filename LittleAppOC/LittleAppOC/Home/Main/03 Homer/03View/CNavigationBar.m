//
//  CNavigationBar.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/21.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CNavigationBar.h"

@implementation CNavigationBar

//简单封装了创建xib的方法
+ (instancetype)viewFromXIB {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"CNavigationBar" owner:nil options:nil] firstObject];
    
}


@end
