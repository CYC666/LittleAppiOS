//
//  TestViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/5.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "TestViewController.h"
#import "TestCell.h"
#import "RollView.h"
#import "RollLabelInfo.h"

@interface TestViewController () <UICollectionViewDelegate, UICollectionViewDataSource, RollViewDlegate> {
    
    
    // 集合视图
    UICollectionView *_listCollectionView;
    
    
    
    
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(15, 200);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, 200)
                                             collectionViewLayout:layout];
    _listCollectionView.backgroundColor = [UIColor clearColor];
    [_listCollectionView registerNib:[UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"TestCell"];
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    [self.view addSubview:_listCollectionView];
    
#ifdef __IPHONE_11_0
    if(@available(iOS 11.0, *)){
        _listCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#else
    
#endif
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 滚动文本
    RollView *rollView = [[RollView alloc] initWithFrame:CGRectMake(20, Nav_Height + 200 + 20, kScreenWidth - 40, 40)];
    rollView.delegate = self;
    [self.view addSubview:rollView];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        RollLabelInfo *model = [[RollLabelInfo alloc] init];
        model.fullhead = [NSString stringWithFormat:@"这里是第%d个元素", i];
        [dataArray addObject:model];
    }
    
    rollView.dataArray = dataArray;
    
}

#pragma mark ========================================生命周期========================================

#pragma mark ========================================私有方法=============================================



#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
    
    
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 商品列表
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCell" forIndexPath:indexPath];
    
    NSDate *currentDate = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = kCFCalendarUnitYear|
                           kCFCalendarUnitMonth|
                           kCFCalendarUnitDay|
                           kCFCalendarUnitHour|
                           kCFCalendarUnitMinute|
                           kCFCalendarUnitSecond;
    NSDateComponents * conponent = [cal components:unitFlags fromDate:currentDate];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld", conponent.year, conponent.month, conponent.day, conponent.hour, conponent.minute, conponent.second];

    
    return cell;
    
    
    
    
    
}


#pragma mark - 点击了跑马灯
- (void)didSelectRollLabel:(NSInteger)index {
    
    FadeAlertView *showMessage = [[FadeAlertView alloc] init];
    [showMessage showAlertWith:[NSString stringWithFormat:@"点击了跑马灯，序号为:%ld", index]];
    
    
}


#pragma mark ========================================通知================================================
























@end
