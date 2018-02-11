//
//  tableViewA.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/8.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "tableViewA.h"


@interface tableViewA () <UITableViewDelegate, UITableViewDataSource>  {
    
    
}

@end

@implementation tableViewA



- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 表视图

    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundColor = [UIColor clearColor];
    self.rowHeight = 40;
    self.delegate = self;
    self.dataSource = self;
    
}


#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ksksksjjdjjdd"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row * 100];
    
    return cell;
    
}

#pragma mark - 可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

// 允许多个按钮
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *actionA = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"订制" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"点击了订制"];
        
    }];
    
    UIContextualAction *actionB = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"点击了删除"];
        
    }];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[actionA, actionB]];
    return config;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}






































@end
