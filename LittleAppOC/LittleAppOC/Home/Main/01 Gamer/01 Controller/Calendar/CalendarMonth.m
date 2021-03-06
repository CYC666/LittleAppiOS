//
//  CalendarMonth.m
//  WZYCalendarDemo
//
//  Created by 曹奕程 on 2017/8/22.
//  Copyright © 2017年 cyc. All rights reserved.
//

#import "CalendarMonth.h"
#import "NSDate+Calendar.h"

@implementation CalendarMonth


- (instancetype)initWithDate:(NSDate *)date {
    
    if (self = [super init]) {
        
        _monthDate = date;
        
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
        _day = [self setupDay];
        
    }
    
    return self;
    
}


/** 返回传入日期是 当月的哪一天（第几天） */
- (NSInteger)setupTotalDays {
    return [_monthDate totalDaysInMonth];
}

/** 返回传入日期所在月份的第一天是周几 */
- (NSInteger)setupFirstWeekday {
    return [_monthDate firstWeekDayInMonth];
}

/** 返回传入日期的 所在年 */
- (NSInteger)setupYear {
    return [_monthDate dateYear];
}

/** 返回传入日期的 所在月 */
- (NSInteger)setupMonth {
    return [_monthDate dateMonth];
}

/** 返回传入日期的 所在日 */
- (NSInteger)setupDay {
    return [_monthDate dateDay];
}


































@end
