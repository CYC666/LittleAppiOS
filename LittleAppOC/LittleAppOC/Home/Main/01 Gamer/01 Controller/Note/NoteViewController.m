//
//  NoteViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/17.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteListCell.h"
#import "NoteModel.h"
#import "AddNoteViewController.h"
#import "ShowNoteViewController.h"
#import "NoteSearchViewController.h"

@interface NoteViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_listTableView;    // 列表
    NSMutableArray *dataArray;   // 数据列表
    
}

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 笔记
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"笔记";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = [UIColor whiteColor];
    dataArray = [NSMutableArray array];

    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setImage:[UIImage imageNamed:@"白色添加"]  forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 30, 22);
    [rightItem addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    UIButton *rightItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem1 setImage:[UIImage imageNamed:@"白色放大镜"]  forState:UIControlStateNormal];
    [rightItem1 setTintColor:[UIColor whiteColor]];
    rightItem1.frame = CGRectMake(0, 0, 30, 22);
    [rightItem1 addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem1 = [[UIBarButtonItem alloc] initWithCustomView:rightItem1];
    self.navigationItem.rightBarButtonItems = @[rightBarItem, rightBarItem1];
    
    
    
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)
                                                  style:UITableViewStylePlain ];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 80;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"NoteListCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"NoteListCell"];
    [self.view addSubview:_listTableView];
    
    
//    NSDictionary *dic = @{@"title" : @"这是一个笑话",
//                          @"content" : @"本次与世界500强公司5个亿的项目圆满完成，经过多天的合作，共获利2.28元，期待下一年的合作。"
//                          };
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    dataArray = [self loadListAction];
    [_listTableView reloadData];
    
    
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

#pragma mark - 添加
- (void)addButtonAction:(UIButton *)button {
    
    AddNoteViewController *ctrl = [[AddNoteViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

#pragma mark - 搜索
- (void)searchButtonAction:(UIButton *)button {
    
    NoteSearchViewController *ctrl = [[NoteSearchViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}




#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10.0;
    
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
