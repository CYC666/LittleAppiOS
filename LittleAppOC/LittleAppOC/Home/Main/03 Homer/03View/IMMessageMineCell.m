//
//  IMMessageMineCell.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/10/19.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "IMMessageMineCell.h"
#import "IMMessageModel.h"

@implementation IMMessageMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



- (void)setDataModel:(IMMessageModel *)dataModel {

    _dataModel = dataModel;

    _contentLabel.text = dataModel.Content;

    if (dataModel.simpleLine && [dataModel.Flag isEqualToString:@"Me"]) {
        _contentLabel.textAlignment = NSTextAlignmentRight;
    } else {
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }

    
    UIImage *oldImage = [UIImage imageNamed:@"mineImage"];
    UIImage *newImage = [oldImage stretchableImageWithLeftCapWidth:oldImage.size.width * 0.5 topCapHeight:oldImage.size.height * 0.5];
    _groundImageView.image = newImage;
    
    _contentLabel.frame = dataModel.contentRect;
    _groundImageView.frame = dataModel.imageRect;
}










@end
