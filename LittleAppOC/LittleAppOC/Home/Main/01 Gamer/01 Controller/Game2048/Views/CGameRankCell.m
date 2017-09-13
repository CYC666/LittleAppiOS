//
//  CGameRankCell.m
//  XiaoHuiBang
//
//  Created by CaoYicheng on 2017/1/12.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import "CGameRankCell.h"

@implementation CGameRankCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    _score.adjustsFontSizeToFitWidth = YES;
    _rankNum.adjustsFontSizeToFitWidth = YES;
    _headImageView.layer.cornerRadius = 30;
    
    if ([_rankNum.text integerValue] >= 4) {
        _rankNum.textColor = [UIColor grayColor];
    }
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
