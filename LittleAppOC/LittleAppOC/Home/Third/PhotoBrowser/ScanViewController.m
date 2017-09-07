//
//  ScanViewController.m
//  WXMovie
//
//  Created by mR yang on 16/7/20.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanCollectionView.h"
@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//  创建集合视图用于左右滑动
  ScanCollectionView *scanCV=[[ScanCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
  
  [self.view addSubview:scanCV];
  
  scanCV.imageURLArr=_imageURLArr;
  
//  滚动到对应的界面
  
  [scanCV scrollToItemAtIndexPath:_currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}



@end
