//
//  ScanCell.h
//  WXMovie
//
//  Created by mR yang on 16/7/20.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoScrollView.h"
@interface ScanCell : UICollectionViewCell


@property(nonatomic,strong)PhotoScrollView *scrollView;


@property(nonatomic,copy)NSString *imageURL;
@end
