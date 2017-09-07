//
//  ScanCollectionView.m
//  WXMovie
//
//  Created by mR yang on 16/7/20.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import "ScanCollectionView.h"
#import "ScanCell.h"
@interface ScanCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ScanCollectionView

static NSString *identifer=@"Cell_ID";

-(instancetype)initWithFrame:(CGRect)frame{
  
//  创建布局对象
  UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
  
//  layout.itemSize
  
//  设置最小行间距
  layout.minimumLineSpacing=0;
  
//  设置滑动方向
  layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
  
//  不显示滑动条
  self.showsVerticalScrollIndicator=NO;
  self.showsHorizontalScrollIndicator=NO;
  
//  分页视图(分页依据：collectionView宽度来分)
  self.pagingEnabled=YES;
  
  if (self=[super initWithFrame:frame collectionViewLayout:layout]) {
    
//    设置代理
    self.dataSource=self;
    
    self.delegate=self;
    
//    注册单元格
    [self registerClass:[ScanCell class] forCellWithReuseIdentifier:identifer];
    
  }
  return self;
}

#pragma mark - UICollectionViewDatasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return _imageURLArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  ScanCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
  
//  取出当前单元格对应的图片URL地址交给Cell
  cell.imageURL=_imageURLArr[indexPath.item];
  
  return cell;
}

//计算单元格尺寸
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
  
}


//单元格将要消失的时候调用
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
  
//  单元格将要消失的时候，把放大倍数改为1倍
  
  ScanCell *photoCell=(ScanCell *)cell;
  
  photoCell.scrollView.zoomScale=1;
}

@end
