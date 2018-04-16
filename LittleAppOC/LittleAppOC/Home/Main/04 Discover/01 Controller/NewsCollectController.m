//
//  NewsCollectController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/23.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "NewsCollectController.h"
#import "NewsListCell.h"
#import "NewsListModel.h"
#import "CWebViewController.h"
#import "UIImageView+WebCache.h"
#import "MMDrawerController.h"

@interface NewsCollectController ()<UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_listTableView;
    NSMutableArray *newsArray;
}

@end

@implementation NewsCollectController

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = @"收藏列表";
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    self.view.backgroundColor = CTHEME.themeColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    newsArray = [NSMutableArray array];
    
    [self creatSubViewAction];
    
}

//（1）、视图将要出现的时候,禁用MMDrawCtrls
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //获取根视图控制器
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
//（2）、视图将要消失的时候,还原一下
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}


#pragma mark ========================================私有方法=============================================

#pragma mark - 子视图
- (void)creatSubViewAction {
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)
                                                  style:UITableViewStylePlain ];
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 60;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"NewsListCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"NewsListCell"];
    [self.view addSubview:_listTableView];
    
    // 加载新闻数据
    [self loadNewsListAction];
    
}

#pragma mark - 加载新闻列表
- (void)loadNewsListAction {
    
    //获取沙盒路径，
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:Documents_NewsCollect];
    //获取plist
    NSArray *list = [NSArray arrayWithContentsOfFile:newPath];
    
    if (newsArray.count != 0) {
        [newsArray removeAllObjects];
    }
    if (list != nil) {
        for (NSDictionary *dic in list) {
            
            NewsListModel *model = [[NewsListModel alloc] init];
            model.author_name = dic[@"author_name"];
            model.category = dic[@"category"];
            model.date = dic[@"date"];
            model.thumbnail_pic_s = dic[@"thumbnail_pic_s"];
            model.thumbnail_pic_s02 = dic[@"thumbnail_pic_s02"];
            model.thumbnail_pic_s03 = dic[@"thumbnail_pic_s03"];
            model.title = dic[@"title"];
            model.uniquekey = dic[@"uniquekey"];
            model.url = dic[@"url"];
            
            [newsArray addObject:model];
        }
    }
    
    [_listTableView reloadData];
    
}

#pragma mark ========================================动作响应=============================================

#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return newsArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90.0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (newsArray.count == 0) {
        NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell"
                                                             forIndexPath:indexPath];
        return cell;
    } else {
        NewsListModel *model = newsArray[indexPath.row];
        NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell"
                                                             forIndexPath:indexPath];
        // 图片
        NSString *path = [NSString stringWithFormat:@"%@", model.thumbnail_pic_s];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:path]
                              placeholderImage:[UIImage imageNamed:@""]
                                       options:SDWebImageRetryFailed];
        // 内容
        cell.contentLabel.text = model.title;
        // 时间
        cell.dateLabel.text = model.date;
        // 按钮隐藏
        cell.moreImageView.hidden = YES;
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 查看新闻H5页面
    if (newsArray.count == 0) {
        return;
    } else {
        NewsListModel *model = newsArray[indexPath.row];
        CWebViewController *ctrl = [[CWebViewController alloc] initWithTitle:@"新闻详情" URL:model.url];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
}

#pragma mark - 允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除收藏";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取沙盒路径，
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:Documents_NewsCollect];
    //获取plist
    NSMutableArray *list = [[NSArray arrayWithContentsOfFile:newPath] mutableCopy];
    // 删除元素
    [list removeObjectAtIndex:indexPath.row];
    [list writeToFile:newPath atomically:YES];
    
    // 删除元素
    NewsListModel *model = newsArray[indexPath.row];
    [newsArray removeObject:model];
    
    // 刷新表视图
    [_listTableView reloadData];
    
}

#pragma mark ========================================通知================================================

@end
