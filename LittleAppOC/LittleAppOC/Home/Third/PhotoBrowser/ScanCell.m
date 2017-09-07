//
//  ScanCell.m
//  WXMovie
//
//  Created by mR yang on 16/7/20.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import "ScanCell.h"

@implementation ScanCell

//注册class 覆写此方法
-(instancetype)initWithFrame:(CGRect)frame{
  
  if (self=[super initWithFrame:frame]) {
   
//   创建用于缩放的滑动视图
    [self creatScrollView];
    
    
    
  }
  return self;
}

-(void)creatScrollView{
  
  _scrollView=[[PhotoScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-50, self.bounds.size.height)];
//  没有设置ContentSize 默认跟scrollView一样大
  
  [self.contentView addSubview:_scrollView];
}

-(void)setImageURL:(NSString *)imageURL{
  
  _imageURL=imageURL;
  
  _scrollView.imageURL=_imageURL;
}

@end
