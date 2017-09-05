//
//  DailyController.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/18.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "DailyController.h"
#import "ThemeManager.h"

@interface DailyController ()

@end

@implementation DailyController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backItemAction:)];
    [backItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.view.backgroundColor = CTHEME.themeColor;
    self.textView.textColor = CTHEME.themeType == CDayTheme ? C_MAIN_TEXTCOLOR : [UIColor whiteColor];
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
}

#pragma mark - 返回按钮响应
- (void)backItemAction:(UIBarButtonItem *)item {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    self.textView.textColor = CTHEME.themeType == CDayTheme ? C_MAIN_TEXTCOLOR : [UIColor whiteColor];
    
}

#pragma mark - 移除观察者
- (void)dealloc {
    
    [CNOTIFY removeObserver:self name:CThemeChangeNotification object:nil];
    
}







/*
 
 - (void)<#name#>Action:(UIButton *)button {
 
 
 
 }

 
 
 // 表视图
 _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)
 style:UITableViewStylePlain ];
 _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
 _listTableView.backgroundColor = [UIColor clearColor];
 _listTableView.rowHeight = 60;
 _listTableView.delegate = self;
 _listTableView.dataSource = self;
 [_listTableView registerNib:[UINib nibWithNibName:@"ZGBankCardSelectTableViewCell" bundle:[NSBundle mainBundle]]
 forCellReuseIdentifier:UITableViewCellID];
 [self.view addSubview:_listTableView];
 
 #pragma mark - 表视图代理方法
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
 return <#expression#>;
 
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
 return <#expression#>;
 
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
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID
 forIndexPath:indexPath];
 
 return cell;
 
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
 }
 
 //简单封装了创建xib的方法
 + (instancetype)viewFromXIB {
 
 NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PersonalCenterView" owner:nil options:nil];
 return views[0];
 
 }
 
 FadeAlertView *showMessage = [[FadeAlertView alloc] init];
 [showMessage showAlertWith:@"<##>"];
 
 // 弹框提示是否执行
 UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
 message:@"<##>"
 preferredStyle:UIAlertControllerStyleAlert];
 
 [alert addAction:[UIAlertAction actionWithTitle:@"取消"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * _Nonnull action) {
 
 }]];
 [alert addAction:[UIAlertAction actionWithTitle:@"确定"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * _Nonnull action) {
 
 
 
 }]];
 
 [self presentViewController:alert animated:YES completion:nil];
 
 
 [self.navigationController popViewControllerAnimated:YES];
 
 
 
 */



























@end
