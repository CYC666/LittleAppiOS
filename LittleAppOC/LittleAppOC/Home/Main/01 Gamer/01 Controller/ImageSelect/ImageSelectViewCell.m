//
//  ImageSelectViewCell.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/6.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "ImageSelectViewCell.h"

@implementation ImageSelectViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _iconImageView.clipsToBounds = YES;
    
}

@end
