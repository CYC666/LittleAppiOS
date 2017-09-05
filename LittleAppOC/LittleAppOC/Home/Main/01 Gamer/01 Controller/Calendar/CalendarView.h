//
//  CalendarView.h
//  WZYCalendarDemo
//
//  Created by 曹奕程 on 2017/8/22.
//  Copyright © 2017年 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>

// 回调 block
typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);

@interface CalendarView : UIView


/**
 *  构造方法
 *
 *  @param origin calendar 的位置
 *  @param width  calendar 的宽度（高度会根据给定的宽度自动计算）
 *
 *  @return bannerView对象
 */
- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width;


/**
 *  calendar 的高度（只读属性）
 */
@property (nonatomic, assign, readonly) CGFloat calendarHeight;


/**
 *  日期点击回调
 *  block 的参数表示当前日期的 NSDate 对象
 */
@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler;

@end
