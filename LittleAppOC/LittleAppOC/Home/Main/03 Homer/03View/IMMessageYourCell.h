//
//  IMMessageYourCell.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/19.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMMessageModel;

@interface IMMessageYourCell : UITableViewCell

// 背景图
@property (weak, nonatomic) IBOutlet UIImageView *groundImageView;

// 内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


// 数据
@property (strong, nonatomic) IMMessageModel *dataModel;


@end
