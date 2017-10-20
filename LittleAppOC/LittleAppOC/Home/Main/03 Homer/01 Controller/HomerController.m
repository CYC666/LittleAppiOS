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
#import "IMMessageModel.h"
#import "IMInputBar.h"
#import "CNetWorking.h"

@interface HomerController () <CityListControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {

    
    // 地址标签
    UILabel *locationLabel;
    NSDictionary *locationDic;
    
    // 聊天列表
    UITableView *_listTableView;
    
    // 聊天记录
    NSMutableArray *messageArray;
    
    // 输入框
    UIView *inputView;

}

@end

@implementation HomerController



#pragma mark ========================================控制器生命周期========================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    messageArray = [NSMutableArray array];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = @"嗨~曹老师";
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    self.view.backgroundColor = CTHEME.themeColor;
    
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
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight - 64 - 49 - 50)
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
    
    
    inputView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49 - 50, kScreenWidth, 50)];
    inputView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:inputView];
    // 输入框
    IMInputBar *inputBar = [IMInputBar viewFromXIB];
    inputBar.frame = CGRectMake(0, 0, kScreenWidth, 50);
    [inputBar.inputView addTarget:self action:@selector(sendMessageAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [inputView addSubview:inputBar];
    
    // 加载聊天数据
    [self loadMessageArrayAction];
    
    // 添加监听刷新的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}



#pragma mark - 存储聊天，并刷新数据以及表视图
- (void)saveIMMessage:(NSDictionary *)dic {

    //获取沙盒路径，
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:Documents_IMMessage];
    //获取plist
    NSMutableArray *list = [[NSArray arrayWithContentsOfFile:newPath] mutableCopy];
    
    if (list == nil) {
        list = [NSMutableArray array];
    }
    
    [list addObject:dic];
    [list writeToFile:newPath atomically:YES];
    
    [self loadMessageArrayAction];

}



#pragma mark ========================================动作响应=============================================

#pragma mark - 发送信息
- (void)sendMessageAction:(UITextField *)textField {
    
    if ([textField.text isEqualToString:@""]) {
        // 弹框提示是否执行
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"请输入要跟傻逼机器人讲的话"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {

                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    } else {
        
        // 存储我说的话
        NSDictionary *item = @{@"Flag" : @"Me",
                               @"CreatDate" : @"2017-10-20 16:50:00",
                               @"Content" : textField.text};
        [self saveIMMessage:item];
        textField.text = @"";
    
        [CNetWorking intelligentRobotWithQuestion:textField.text success:^(id response) {
            
            NSDictionary *result = response[@"result"];
            
            // 储存机器人的回答
            NSString *content = [NSString stringWithFormat:@"%@", result[@"content"]];
            NSDictionary *itemResponse = @{@"Flag" : @"robot",
                                           @"CreatDate" : @"2017-10-20 16:50:00",
                                           @"Content" : content};
            [self saveIMMessage:itemResponse];
            
            
        } failure:^(NSError *err) {
            
        }];
    
    }
    
    
    
}







#pragma mark ========================================网络请求=============================================

#pragma mark - 加载聊天列表
- (void)loadMessageArrayAction {
    
    //获取沙盒路径，
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:Documents_IMMessage];
    //获取plist
    NSArray *list = [NSArray arrayWithContentsOfFile:newPath];
    
    if (messageArray.count != 0) {
        [messageArray removeAllObjects];
    }
    if (list != nil) {
        for (NSDictionary *dic in list) {
            IMMessageModel *model = [[IMMessageModel alloc] init];
            model.Flag = dic[@"Flag"];
            model.Content = dic[@"Content"];
            model.CreatDate = dic[@"CreatDate"];
            [messageArray addObject:model];
        }
    }
    
    
    
    
    
    //主线程更新视图
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_listTableView reloadData];
        [_listTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messageArray.count - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
        
    });
    
}


#pragma mark ========================================代理方法=============================================






#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return messageArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMMessageModel *model = messageArray[indexPath.row];
    
    return model.cellHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    IMMessageModel *model = messageArray[indexPath.row];
    if ([model.Flag isEqualToString:@"robot"]) {
        
        
        IMMessageYourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMMessageYourCell" forIndexPath:indexPath];
        
        cell.dataModel = model;
        
        return cell;
    } else {
    
        
        IMMessageMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMMessageMineCell" forIndexPath:indexPath];
        
        cell.dataModel = model;
        
        
        return cell;
    
    }
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}


#pragma mark ========================================通知================================================
#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}


#pragma mark - 键盘弹出
- (void)keyboardWillShow:(NSNotification *)notification {

    //取出键盘的frame
    CGRect frame = [notification.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取高度
    CGFloat height = frame.size.height;
    
    inputView.transform = CGAffineTransformMakeTranslation(0, 50-height);

}

#pragma mark - 键盘收起
- (void)keyboardWillHide:(NSNotification *)notification {
    
    inputView.transform = CGAffineTransformMakeTranslation(0, 0);

}














@end
