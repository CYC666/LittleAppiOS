//
//  TestCell.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/5.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RollView, PageView;

@interface TestCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet RollView *rollView;
@property (weak, nonatomic) IBOutlet PageView *pageView;
@property (weak, nonatomic) IBOutlet UIView *pageFrameView;



@end
