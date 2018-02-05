//
//  RollLabelInfo.h
//  YiYanYunGou
//
//  Created by admin on 16/9/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RollLabelInfo : NSObject

@property (nonatomic) NSString *newsid;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *fullhead;

//图片
@property (copy, nonatomic) NSString *filepath;

//链接
@property (copy, nonatomic) NSString *tolink;

//时间
@property (nonatomic) NSString *times;






@end
