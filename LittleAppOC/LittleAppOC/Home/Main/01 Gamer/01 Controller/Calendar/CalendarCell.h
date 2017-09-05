//
//  CalendarCell.h
//  WZYCalendarDemo
//
//  Created by 曹奕程 on 2017/8/22.
//  Copyright © 2017年 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UICollectionViewCell

@property (nonatomic, strong) UIView *todayCircle;      // 今天
@property (nonatomic, strong) UILabel *todayLabel;      // 几号

@end
