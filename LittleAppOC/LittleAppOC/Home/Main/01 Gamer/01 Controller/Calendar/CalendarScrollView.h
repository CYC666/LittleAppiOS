//
//  CalendarScrollView.h
//  WZYCalendarDemo
//
//  Created by 曹奕程 on 2017/8/22.
//  Copyright © 2017年 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义回调Block
typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);

@interface CalendarScrollView : UIScrollView

@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler; // 日期点击回调

- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份

@end
