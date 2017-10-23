//
//  NewsListModel.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/23.
//  Copyright © 2017年 CYC. All rights reserved.
//


// 新闻列表中单个新闻的数据模型

#import <Foundation/Foundation.h>

@interface NewsListModel : NSObject


@property (copy, nonatomic) NSString *title;                // 标题
@property (copy, nonatomic) NSString *author_name;          // 作者
@property (copy, nonatomic) NSString *category;             // 类型
@property (copy, nonatomic) NSString *date;                 // 时间
@property (copy, nonatomic) NSString *thumbnail_pic_s;      // 图1
@property (copy, nonatomic) NSString *thumbnail_pic_s02;    // 图2
@property (copy, nonatomic) NSString *thumbnail_pic_s03;    // 图3
@property (copy, nonatomic) NSString *uniquekey;            // 唯一标识
@property (copy, nonatomic) NSString *url;                  // 新闻链接





@end
