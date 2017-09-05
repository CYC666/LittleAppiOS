//
//  GamerController.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/15.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "GamerController.h"
#import "ThemeManager.h"
#import "GamerCell.h"
#import "CThemeLabel.h"
#import "BoomController.h"
#import "SelectColorController.h"
#import "CSalesTargetViewController.h"
#import "brokenLineController.h"
#import "FlowSliderController.h"
#import "CWebViewController.h"
#import "TranslateController.h"
#import "CityListController.h"
#import "FontViewController.h"
#import "AppListViewController.h"
#import "OverColorViewController.h"
#import "CodeViewController.h"
#import "CalendarViewController.h"
#import "InputViewController.h"





#define GamerCellID @"GamerCellID"  

@interface GamerController () <UICollectionViewDelegate, UICollectionViewDataSource> {

    NSArray *images;
    NSArray *titles;
    

}

@end

@implementation GamerController


- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = @"小玩意儿";
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    self.view.backgroundColor = CTHEME.themeColor;
    
    // 导航栏返回按钮
    UIBarButtonItem *selfBackItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:nil];
    self.navigationItem.backBarButtonItem = selfBackItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    // 创建UI
    [self creatSubviews];
    
    
}

#pragma mark - 创建UI
- (void)creatSubviews {
    
    images = @[@"icon_gamer_2048",
               @"icon_gamer_target",
               @"icon_gamer_boom",
               @"icon_gamer_color",
               @"icon_gamer_line",
               @"icon_gamer_flowSlider",
               @"icon_gamer_subway",
               @"icon_gamer_bankCard",
               @"icon_gamer_translate",
               @"icon_gamer_home",
               @"icon_gamer_die",
               @"icon_gamer_city",
               @"icon_gamer_font",
               @"icon_gamer_app",
               @"icon_gamer_overColor",
               @"icon_gamer_code",
               @"icon_gamer_calendar",
               @"icon_gamer_input"];
    
    titles = @[@"2048",
               @"目标",
               @"扫雷",
               @"取色板",
               @"折线图",
               @"标尺",
               @"深圳地铁",
               @"识别银行卡",
               @"翻译",
               @"桌面",
               @"退出",
               @"城市",
               @"字幕",
               @"应用",
               @"渐变",
               @"二维码",
               @"日历",
               @"输入法"];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *gamesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, kScreenHeight - 49)
                                                               collectionViewLayout:flowLayout];
    gamesCollectionView.backgroundColor = [UIColor clearColor];
    gamesCollectionView.showsVerticalScrollIndicator = NO;
    gamesCollectionView.alwaysBounceVertical = YES;
    flowLayout.itemSize = CGSizeMake(100, 115);
    flowLayout.headerReferenceSize = CGSizeMake(0, 20);
    gamesCollectionView.delegate = self;
    gamesCollectionView.dataSource = self;
    [gamesCollectionView registerNib:[UINib nibWithNibName:@"GamerCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:GamerCellID];
    [self.view addSubview:gamesCollectionView];

}

#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}

#pragma mark - 集合视图代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return images.count;

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GamerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GamerCellID
                                                                forIndexPath:indexPath];
    
    
    cell.gameImageView.image = [UIImage imageNamed:images[indexPath.item]];
    cell.gameNameLabel.text = titles[indexPath.item];
    
    cell.gameNameLabel.textColor = CTHEME.themeTextColor;
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    GamerCell *cell = (GamerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.gameNameLabel.text isEqualToString:@"2048"]) {
        
        // 2048
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"目标"]) {
    
        // 目标
        CSalesTargetViewController *controller = [[CSalesTargetViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    
    } else if ([cell.gameNameLabel.text isEqualToString:@"扫雷"]) {
    
        // 寻找炸弹(超大滑动视图)
        BoomController *controller = [[BoomController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    
    } else if ([cell.gameNameLabel.text isEqualToString:@"取色板"]) {
        
        // 区色板
        SelectColorController *controller = [[SelectColorController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"折线图"]) {
        
        // 折线图
        brokenLineController *controller = [[brokenLineController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"标尺"]) {
        
        FlowSliderController *controller = [[FlowSliderController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"深圳地铁"]) {
    
        CWebViewController *controller = [[CWebViewController alloc] initWithTitle:@"深圳地铁"
                                                                               URL:@"http://map.baidu.com/mobile/webapp/subway/show//city=shenzhen?third_party=webapp-aladdin"];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    
    } else if ([cell.gameNameLabel.text isEqualToString:@"识别银行卡"]) {
        
        // 识别银行卡
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"翻译"]) {
    
        TranslateController *ctrl = [[TranslateController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    
    } else if ([cell.gameNameLabel.text isEqualToString:@"桌面"]) {
        
        // 回到手机桌面
        [[UIApplication sharedApplication] performSelector:@selector(suspend)];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"退出"]) {
        
        // 退出程序
        [self exitApplication];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"城市"]) {
        
        // 城市列表
        CityListController *ctrl = [[CityListController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"字幕"]) {
        
        // 字幕
        FontViewController *ctrl = [[FontViewController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"应用"]) {
        
        // 所有应用
        AppListViewController *ctrl = [[AppListViewController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"渐变"]) {
        
        // 颜色渐变
        OverColorViewController *ctrl = [[OverColorViewController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"二维码"]) {
        
        // 二维码
        CodeViewController *ctrl = [[CodeViewController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"日历"]) {
        
        // 日历
        CalendarViewController *ctrl = [[CalendarViewController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    } else if ([cell.gameNameLabel.text isEqualToString:@"输入法"]) {
        
        // 输入法
        InputViewController *ctrl = [[InputViewController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    }

    
    
}


#pragma mark - 退出程序
- (void)exitApplication {
    
    [UIView animateWithDuration:0.35f animations:^{
        [UIApplication sharedApplication].delegate.window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}


































@end
