//
//  ImageSelectViewCell.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/6.
//  Copyright © 2017年 CYC. All rights reserved.
//

// 图片的单元格

#import <UIKit/UIKit.h>

@protocol ImageSelectViewCellDelegate <NSObject>

@optional
// 长按响应
- (void)longPressCellAction;

@end

@interface ImageSelectViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (assign, nonatomic) BOOL ani;

@property (weak, nonatomic) id<ImageSelectViewCellDelegate> delegate;

@end
