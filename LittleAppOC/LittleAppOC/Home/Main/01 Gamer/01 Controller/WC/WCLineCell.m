//
//  WCLineCell.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/5.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "WCLineCell.h"

@implementation WCLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
