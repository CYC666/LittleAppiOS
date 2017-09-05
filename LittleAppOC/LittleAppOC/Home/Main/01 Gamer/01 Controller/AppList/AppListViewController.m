//
//  AppListViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/16.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "AppListViewController.h"

@interface AppListViewController () <UITableViewDelegate, UITableViewDataSource> {

    UITableView *_listTableView;
    
    NSMutableArray *_appList;

}

@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"应用列表";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = CTHEME.themeColor;
    _appList = [NSMutableArray array];
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    // 获取所有App
    Class c =NSClassFromString(@"LSApplicationWorkspace");
//    [[c new] performSelector:@selector(uninstallApplication:withOptions:) withObject:@"come.ihk.RCIM" withObject:nil];
    id s = [(id)c performSelector:NSSelectorFromString(@"defaultWorkspace")];
    NSArray *list = [s performSelector:NSSelectorFromString(@"allInstalledApplications")];
    
    for (id item in list) {
        NSString *str = [item performSelector:NSSelectorFromString(@"itemName")];
        if (str != nil && ![str isEqualToString:@""]) {
            [_appList addObject:item];
        }
        
    }
    
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)
                                                  style:UITableViewStylePlain ];
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 60;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    
    
    
    
}



#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}


#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _appList.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppListCellID"];
    
    id item = _appList[indexPath.row];
    
    cell.textLabel.text = [item performSelector:NSSelectorFromString(@"itemName")];
    cell.detailTextLabel.text = [item performSelector:NSSelectorFromString(@"bundleVersion")];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
