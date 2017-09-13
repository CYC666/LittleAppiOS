//
//  CRankCell.m
//  XiaoHuiBang
//
//  Created by CaoYicheng on 2017/1/13.
//  Copyright © 2017年 消汇邦. All rights reserved.
//

#import "CRankCell.h"
#import "CGameRankModel.h"
#import "UIImageView+WebCache.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height                          // 屏高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width                            // 屏宽


@implementation CRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)rankNumImageView {

    if (_rankNumImageView == nil) {
        _rankNumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 56)];
        _rankNumImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_rankNumImageView];
    }
    return _rankNumImageView;

}


- (UILabel *)rankNumLabel {

    if (_rankNumLabel == nil) {
        _rankNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _rankNumLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
        _rankNumLabel.textColor = [UIColor whiteColor];
        _rankNumLabel.textAlignment = NSTextAlignmentCenter;
        [_rankNumImageView addSubview:_rankNumLabel];
    }
    return _rankNumLabel;

}


- (UIImageView *)headImageView {

    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + 40 + 10, 20, 50, 50)];
        _headImageView.layer.cornerRadius = 5;
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headImageView.clipsToBounds = YES;
        [self.contentView addSubview:_headImageView];
    }
    return _headImageView;

}


- (UILabel *)nickNameLabel {

    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + 40 + 10 + 50 + 5, 20, 200, 20)];
        _nickNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        _nickNameLabel.textColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nickNameLabel];
    }
    return _nickNameLabel;

}


- (UILabel *)scoreLabel {

    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        if ([UIScreen mainScreen].bounds.size.width == 320) {
            _scoreLabel.frame = CGRectMake(320 -20*2 - 20 - 100, 80 - 20 - 10, 100, 20);
        } else {
            _scoreLabel.frame = CGRectMake(self.bounds.size.width - 20 - 100, 80 - 20 - 10, 100, 20);
        }
        _scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        _scoreLabel.textColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
        _scoreLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_scoreLabel];
    }
    return _scoreLabel;

}


- (void)setRankModel:(CGameRankModel *)rankModel {
    
    self.backgroundColor = [UIColor clearColor];

    _rankModel = rankModel;
    
    if (rankModel.rankNum == 1) {
        self.rankNumImageView.image = [UIImage imageNamed:@"icon_gameRank_gold"];
    } else if (rankModel.rankNum == 2) {
        self.rankNumImageView.image = [UIImage imageNamed:@"icon_gameRank_silver"];
    } else if (rankModel.rankNum == 3) {
        self.rankNumImageView.image = [UIImage imageNamed:@"icon_gameRank_copper"];
    } else {
        self.rankNumImageView.image = [UIImage imageNamed:@"icon_gameRank_other"];
    }
    
    self.rankNumLabel.text = [NSString stringWithFormat:@"%ld", (long)rankModel.rankNum];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:rankModel.thumb]];
    
    self.nickNameLabel.text = rankModel.nickname;
    
    self.scoreLabel.text = rankModel.score;
    

}



































@end
