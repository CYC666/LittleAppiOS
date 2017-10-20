//
//  IMMessageModel.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/20.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMMessageModel : NSObject

//身份标识:机器人/我
@property (copy, nonatomic) NSString *Flag;

//时间
@property (copy, nonatomic) NSString *CreatDate;

//内容
@property (copy, nonatomic) NSString *Content;


// 单元格高度
@property (assign, nonatomic) CGFloat cellHeight;

// 背景图位置
@property (assign, nonatomic) CGRect imageRect;

// 文本位置
@property (assign, nonatomic) CGRect contentRect;

// 是否单行
@property (assign, nonatomic) BOOL simpleLine;


@end
