//
//  CRankCell.h
//  XiaoHuiBang
//
//  Created by CaoYicheng on 2017/1/13.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CGameRankModel;

@interface CRankCell : UITableViewCell

@property (strong, nonatomic) CGameRankModel *rankModel;

@property (strong, nonatomic) UIImageView *rankNumImageView;
@property (strong, nonatomic) UILabel *rankNumLabel;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nickNameLabel;
@property (strong, nonatomic) UILabel *scoreLabel;

@end
