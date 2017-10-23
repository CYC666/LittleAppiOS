//
//  DiscoverController.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/15.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "DiscoverController.h"
#import "ThemeManager.h"
#import "NewsListCell.h"
#import "CNetWorking.h"
#import "NewsListModel.h"
#import "UIImageView+WebCache.h"
#import "CWebViewController.h"
#import "XLsn0wPopupMenu.h"

@interface DiscoverController () <UITableViewDelegate, UITableViewDataSource> {

    UITableView *_listTableView;
    NSMutableArray *newsArray;
    BOOL isRefresh;                 // 正在刷新
}

@end

@implementation DiscoverController



#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = @"新闻(体育)";
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    self.view.backgroundColor = CTHEME.themeColor;
    
    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setImage:[UIImage imageNamed:@"菜单"]  forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 40, 22);
    [rightItem addTarget:self action:@selector(showMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    newsArray = [NSMutableArray array];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    [self creatSubViewAction];
    
}

#pragma mark ========================================私有方法=============================================

#pragma mark - 子视图
- (void)creatSubViewAction {
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)
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
    [self loadNewsListAction:@"tiyu"];
    
}




#pragma mark ========================================动作响应=============================================

#pragma mark - 获取新闻列表
- (void)loadNewsListAction:(NSString *)type {
    
    isRefresh = YES;
    [CNetWorking loadNewsWithType:type
                          success:^(id response) {
                              
                              if (newsArray.count != 0) {
                                  [newsArray removeAllObjects];
                              }
                              
                              NSArray *list = response[@"result"][@"data"];
                              for (NSDictionary *dic in list) {
                                  
                                  NewsListModel *model = [[NewsListModel alloc] init];
                                  model.title = [NSString stringWithFormat:@"%@", dic[@"title"]];
                                  model.author_name = [NSString stringWithFormat:@"%@", dic[@"author_name"]];
                                  model.category = [NSString stringWithFormat:@"%@", dic[@"category"]];
                                  model.date = [NSString stringWithFormat:@"%@", dic[@"date"]];
                                  model.thumbnail_pic_s = [NSString stringWithFormat:@"%@", dic[@"thumbnail_pic_s"]];
                                  model.thumbnail_pic_s02 = [NSString stringWithFormat:@"%@", dic[@"thumbnail_pic_s02"]];
                                  model.thumbnail_pic_s03 = [NSString stringWithFormat:@"%@", dic[@"thumbnail_pic_s03"]];
                                  model.uniquekey = [NSString stringWithFormat:@"%@", dic[@"tiuniquekeytle"]];
                                  model.url = [NSString stringWithFormat:@"%@", dic[@"url"]];
                                  
                                  [newsArray addObject:model];
                              }
                              
                              //主线程更新视图
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  [_listTableView reloadData];
                                  isRefresh = NO;
                                  
                              });
                              
                              
                          } failure:^(NSError *err) {
                              isRefresh = NO;
                          }];
    
}

#pragma mark - +下拉列表
- (void)showMenuAction:(UIButton *)button {
    
    // top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
    __block NSArray *typeArray = @[@"top",
                           @"sheihui",
                           @"guonei",
                           @"guoji",
                           @"yule",
                           @"tiyu",
                           @"junshi",
                           @"keji",
                           @"caijing",
                           @"shishang"];
    __block NSArray *titleArray = @[@"头条",
                            @"社会",
                            @"国内",
                            @"国际",
                            @"娱乐",
                            @"体育",
                            @"军事",
                            @"科技",
                            @"财经",
                            @"时尚"];
    
    
    NSMutableArray *actionArray = [NSMutableArray array];
    for (NSInteger i = 0; i < typeArray.count; i++) {
        XLsn0wPopupAction *action = [XLsn0wPopupAction actionWithImage:[UIImage imageNamed:@""]
                                                                 title:titleArray[i]
                                                               handler:^(XLsn0wPopupAction *action) {
            
                                                                   if (!isRefresh) {
                                                                       
                                                                       [self loadNewsListAction:typeArray[i]];
                                                                       
                                                                       // 标题
                                                                       UILabel *title = (UILabel *)self.navigationItem.titleView;
                                                                       title.text = [NSString stringWithFormat:@"新闻(%@)", titleArray[i]];
                                                                   } else {
                                                                   
                                                                   }
            
        }];
        [actionArray addObject:action];
    }
    
    
    
    XLsn0wPopupMenu *popupMenu = [[XLsn0wPopupMenu alloc] init];
    popupMenu.style = XLsn0wPopupMenuStyleBlack;
    popupMenu.showShade = YES;
    [popupMenu showToView:button withActions:actionArray];
    
}


#pragma mark ========================================网络请求=============================================

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


#pragma mark ========================================代理方法=============================================


#pragma mark ========================================通知================================================



#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}

































@end
