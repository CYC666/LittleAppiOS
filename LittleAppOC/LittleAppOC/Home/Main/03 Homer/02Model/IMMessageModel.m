//
//  IMMessageModel.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/20.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "IMMessageModel.h"
#import <YYKit.h>

@implementation IMMessageModel


- (void)setContent:(NSString *)Content {

    _Content = Content;
    
    // 计算高度
    
    CGRect rect = [Content boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 9999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0]}
                                        context:nil];
    
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    

        
    // 机器人（必须先设置身份）
    if ([_Flag isEqualToString:@"robot"]) {
        
        _imageRect = CGRectMake(10, 10, width + 30, height + 25);
        _contentRect = CGRectMake(25, 20, width, height);
        _cellHeight = 20 + height + 25;
        _simpleLine = YES;
        
    } else {
        
        _imageRect = CGRectMake(kScreenWidth - (width + 30) - 10, 10, width + 30, height + 25);
        _contentRect = CGRectMake(kScreenWidth - width - 25, 20, width, height);
        _cellHeight = 20 + height + 25;
        _simpleLine = YES;
    }
    
    if (width < kScreenWidth - 55) {
        _simpleLine = YES;
    } else {
        _simpleLine = NO;
    }
        
        

    
    

}


@end
