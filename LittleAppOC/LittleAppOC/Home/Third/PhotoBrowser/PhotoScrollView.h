//
//  PhotoScrollView.h
//  WXMovie
//
//  Created by mR yang on 16/7/20.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoScrollViewDeletage <NSObject>

@required
// 单击执行
- (void)singleTagAction;

@end

@interface PhotoScrollView : UIScrollView

@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,copy)NSString *imageURL;

@property (strong, nonatomic) UIImage *imageObj;

@property (weak, nonatomic) id<PhotoScrollViewDeletage> photoDelegate;

@end
