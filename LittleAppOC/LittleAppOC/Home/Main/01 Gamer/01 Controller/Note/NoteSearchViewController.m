//
//  NoteSearchViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/26.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "NoteSearchViewController.h"
#import "NoteListCell.h"
#import "NoteModel.h"
#import "ShowNoteViewController.h"

@interface NoteSearchViewController () <UITextFieldDelegate> {
    
    NSMutableArray *dataArray;   // 数据列表
    
    
}

@end

@implementation NoteSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 笔记
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"查找日记";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    dataArray = [NSMutableArray array];
    
    _top.constant = Nav_Height + 20;
    [_sButton addTarget:self action:@selector(sbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _sField.delegate = self;
    
    [_mainTableView registerNib:[UINib nibWithNibName:@"NoteListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NoteListCell"];
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


#pragma mark - 搜索
- (void)searchAction {
    
    NSString *key = _sField.text;
    if ([key isEqualToString:@""]) {
        return;
    }
    
    NSMutableArray *list = [self loadListAction];
    if (list.count == 0) {
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"日记列表为空"];
        return;
    }
    [dataArray removeAllObjects];
    for (NoteModel *model in list) {
        
        NSRange sRange1 = [model.noteTitle rangeOfString:key];
        if (sRange1.location != NSNotFound) {
            
            [dataArray addObject:model];
            continue;
            
        }
        
        NSRange sRange2 = [model.noteContent rangeOfString:key];
        if (sRange2.location != NSNotFound) {
            
            [dataArray addObject:model];
            
        }
        
    }
    
    if (dataArray.count > 0) {
        [_mainTableView reloadData];
    }
    
}

- (void)sbuttonAction:(UIButton *)button {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self searchAction];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [self searchAction];
    
    return YES;
    
}




#pragma mark - 获取数据
- (NSMutableArray *)loadListAction {
    
    // 1、获取应用程序沙盒下的Documents目录（购物车列表）
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"NoteList.plist"];
    NSMutableArray *list = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    if (!list) {
        list = [NSMutableArray array];
    }
    
    NSMutableArray *tempArray = [NSMutableArray array];
    if (list.count > 0) {
        for (NSDictionary *dic in list) {
            
            NoteModel *model = [[NoteModel alloc] init];
            model.noteTitle = dic[@"title"];
            model.noteContent = dic[@"content"];
            [tempArray addObject:model];
        }
    }
    
    return tempArray;
}


#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoteListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteListCell"
                                                         forIndexPath:indexPath];
    
    if (indexPath.row < dataArray.count) {
        
        NoteModel *model = dataArray[indexPath.row];
        cell.nameLabel.text = model.noteTitle;
        cell.contentLabel.text = model.noteContent;
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < dataArray.count) {
        
        NoteModel *model = dataArray[indexPath.row];
        ShowNoteViewController *ctrl = [[ShowNoteViewController alloc] init];
        ctrl.model = model;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
    
    
}






























@end
