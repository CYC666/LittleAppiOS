//
//  BluetoothViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "BluetoothViewController.h"
#import "HMBlueToothManager.h"

@interface BluetoothViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray <CBPeripheral *>*tableArr;

@end

@implementation BluetoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = @"蓝牙";
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    self.view.backgroundColor = CTHEME.themeColor;
    
    // 表视图
    UITableView *_listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, kScreenHeight - Nav_Height - 50)
                                                  style:UITableViewStylePlain ];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 60;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"搜索设备" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(scanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}


- (void)scanButtonClick:(id)sender {
    
    [kHMBlueToothManager beginScanCBPeripheral:^(NSArray *peripheralArr) {
        self.tableArr = peripheralArr;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    CBPeripheral *peripheral = self.tableArr[indexPath.row];
    
    cell.textLabel.text = peripheral.name ;
    cell.detailTextLabel.text = [peripheral.identifier UUIDString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *peripheral = self.tableArr[indexPath.row];
    
    [kHMBlueToothManager connectPeripheral:peripheral Completion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"连接成功");
        }else{
            NSLog(@"连接失败");
        }
    }];
}



































@end
