//
//  HomerController.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/15.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "HomerController.h"
#import "ThemeManager.h"
#import "CNavigationBar.h"
#import "CityListController.h"
#import <YYKit.h>
#import "CDoubleTableView.h"
#import "IMMessageYourCell.h"
#import "IMMessageMineCell.h"

@interface HomerController () <CityListControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {

    
    // 地址标签
    UILabel *locationLabel;
    NSDictionary *locationDic;
    
    // 聊天列表
    UITableView *_listTableView;

}

@end

@implementation HomerController



#pragma mark ========================================控制器生命周期========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"嗨~曹老师";
    
    self.view.backgroundColor = CTHEME.themeColor;
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self creatUIAction];
    
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    
    
}




#pragma mark ========================================私有方法=============================================
#pragma mark - 创建视图
- (void)creatUIAction {
    
    self.automaticallyAdjustsScrollViewInsets = NO; // 这样子滑动视图就不会自动偏移20个像素
    

    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight - 64 - 49)
                                                  style:UITableViewStylePlain ];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 90;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"IMMessageYourCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"IMMessageYourCell"];
    [_listTableView registerNib:[UINib nibWithNibName:@"IMMessageMineCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"IMMessageMineCell"];
    [self.view addSubview:_listTableView];
    
    
    

    
}




#pragma mark ========================================动作响应=============================================









#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================






#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row % 2 == 0) {
        
        IMMessageYourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMMessageYourCell" forIndexPath:indexPath];
        
        cell.contentLabel.text = @"问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题";
        
        return cell;
    } else {
    
        IMMessageMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMMessageMineCell" forIndexPath:indexPath];
        
        cell.contentLabel.text = @"回答问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题问题";
        
        return cell;
    
    }
        
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark ========================================通知================================================
#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}



















@end
