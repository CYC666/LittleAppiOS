//
//  ScanViewController.h
//  WXMovie
//
//  Created by mR yang on 16/7/20.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : UIViewController

@property(nonatomic,strong)NSIndexPath *currentIndexPath;//之前页面点击的单元格的indexPath

@property(nonatomic,strong)NSArray *imageURLArr;//存放图片URL地址的数组

@end
