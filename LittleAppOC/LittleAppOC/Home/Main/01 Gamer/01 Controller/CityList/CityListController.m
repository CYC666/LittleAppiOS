//
//  CityListController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/14.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CityListController.h"

@interface CityListController () <UITableViewDelegate, UITableViewDataSource> {

    UITableView *_listTableView;
    
    NSArray *supArray;
    NSArray *subArray;
    

}

@end

@implementation CityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"城市列表";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = CTHEME.themeColor;
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCities" ofType:@"plist"];
    supArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)
                                                  style:UITableViewStylePlain ];
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
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
    
    return supArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dic = supArray[section];
    subArray = dic[@"Cities"];
    return subArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60.0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSDictionary *dic = supArray[section];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    label.backgroundColor = CRGB(37, 37, 37, 1);
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"  %@", dic[@"State"]];
    
    return label;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCellID"];
    
    NSDictionary *supDic = supArray[indexPath.section];
    subArray = supDic[@"Cities"];
    NSDictionary *subDic = subArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@(经度:%@ 纬度:%@)", subDic[@"city"], subDic[@"lon"], subDic[@"lat"]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // 返回城市的字典
    if ([_delegate respondsToSelector:@selector(didSelectCity:)]) {
        
        NSDictionary *supDic = supArray[indexPath.section];
        subArray = supDic[@"Cities"];
        NSDictionary *subDic = subArray[indexPath.row];
        
        [_delegate didSelectCity:subDic];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
    
}




































@end
