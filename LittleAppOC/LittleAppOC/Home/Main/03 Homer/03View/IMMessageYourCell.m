//
//  IMMessageYourCell.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/19.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "IMMessageYourCell.h"

@implementation IMMessageYourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
