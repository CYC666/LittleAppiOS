//
//  WCViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/3.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "WCViewController.h"
#import "WCLineCell.h"

@interface WCViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_listTableView;             // 左边
    UIScrollView *scrollView;
    UIImageView *imageview;
    NSInteger currentLine;
}

@end

@implementation WCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentLine = 0;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = @"深圳地铁厕所位置";
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth * 0.2, kScreenHeight - Nav_Height)
                                                  style:UITableViewStylePlain ];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 60;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"WCLineCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"WCLineCell"];
    [self.view addSubview:_listTableView];
    
    
    // 滑动视图
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.2, Nav_Height, kScreenWidth * 0.8, kScreenHeight - Nav_Height)];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    
    UIImage *image = [UIImage imageNamed:@"1号线"];
    imageview = [[UIImageView alloc] init];
    imageview.image = image;
    CGFloat height = image.size.height * (kScreenWidth * 0.8 / image.size.width);
    [scrollView addSubview:imageview];
    
    imageview.frame = CGRectMake(0, 0, kScreenWidth * 0.8, height);
    scrollView.contentSize = CGSizeMake(kScreenWidth * 0.8, height);
    
#ifdef __IPHONE_11_0
    if(@available(iOS 11.0, *)){
        _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#else
    
#endif
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WCLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WCLineCell"
                                                            forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"1号线";
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = @"2号线";
    } else if (indexPath.row == 2) {
        cell.nameLabel.text = @"3号线";
    } else if (indexPath.row == 3) {
        cell.nameLabel.text = @"4号线";
    } else if (indexPath.row == 4) {
        cell.nameLabel.text = @"5号线";
    } else if (indexPath.row == 5) {
        cell.nameLabel.text = @"7号线";
    } else if (indexPath.row == 6) {
        cell.nameLabel.text = @"9号线";
    } else if (indexPath.row == 7) {
        cell.nameLabel.text = @"11号线";
    }
    
    if (indexPath.row == currentLine) {
        cell.backgroundColor = CRGB(238, 238, 238, 1);
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIImage *image;

    if (indexPath.row == 0) {
        image = [UIImage imageNamed:@"1号线"];
    } else if (indexPath.row == 1) {
        image = [UIImage imageNamed:@"2号线"];
    } else if (indexPath.row == 2) {
        image = [UIImage imageNamed:@"3号线"];
    } else if (indexPath.row == 3) {
        image = [UIImage imageNamed:@"4号线"];
    } else if (indexPath.row == 4) {
        image = [UIImage imageNamed:@"5号线"];
    } else if (indexPath.row == 5) {
        image = [UIImage imageNamed:@"7号线"];
    } else if (indexPath.row == 6) {
        image = [UIImage imageNamed:@"9号线"];
    } else if (indexPath.row == 7) {
        image = [UIImage imageNamed:@"11号线"];
    }
    
    CGFloat height = image.size.height * (kScreenWidth * 0.8 / image.size.width);
    imageview.frame = CGRectMake(0, 0, kScreenWidth * 0.8, height);
    imageview.image = image;
    scrollView.contentSize = CGSizeMake(kScreenWidth * 0.8, height);
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [_listTableView reloadData];
    currentLine = indexPath.row;
    
}































#pragma mark - 数据
- (void)dataList {
    
    
}






































@end
