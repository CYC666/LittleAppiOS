//
//  TestCollectionView.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/4/3.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "TestCollectionView.h"
#import "TestFlowLayout.h"
#import "TestCollectionViewCell.h"

@interface TestCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, TestFlowLayoutDlegate>  {
    
    
}

@end

@implementation TestCollectionView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 集合视图
    TestFlowLayout *layout = [[TestFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth * 0.25, kScreenWidth * 0.25);
    layout.layoutDelegate = self;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionViewLayout = layout;
    [self registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"TestCollectionViewCell"];
    self.delegate = self;
    self.dataSource = self;
    
    
    
    
}

#pragma mark -
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionViewCell" forIndexPath:indexPath];
    
    
    return cell;
    
}

-(NSString *)TestFlowLayoutItemForIndex:(NSIndexPath *)indexPath {
    
    return [NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.item];
    
    
}


@end
