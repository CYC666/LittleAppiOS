//
//  CGameRankCell.h
//  XiaoHuiBang
//
//  Created by CaoYicheng on 2017/1/12.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

// 排行榜中表视图的单元格

#import <UIKit/UIKit.h>

@interface CGameRankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rankNum;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;




@end
