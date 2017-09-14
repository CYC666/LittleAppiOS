//
//  ZonerController.h
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/15.
//  Copyright © 2017年 CYC. All rights reserved.
//


// 动态不要，改成音乐界面

#import <UIKit/UIKit.h>
@class MJRefreshAutoGifFooter;

@interface ZonerController : UIViewController

@property (strong, nonatomic) NSMutableArray *songArray;            // 储存所有歌曲的数组
@property (assign, nonatomic) NSInteger currentIndex;               // 当前播放的歌曲序号
@property (strong, nonatomic) UITableView *songListTableView;       // 歌曲列表表视图

@property (strong, nonatomic) MJRefreshAutoGifFooter *footer;       // 上拉加载控件

@end
