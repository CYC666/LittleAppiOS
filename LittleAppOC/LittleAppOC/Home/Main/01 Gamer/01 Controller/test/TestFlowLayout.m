//
//  TestFlowLayout.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/4/3.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "TestFlowLayout.h"

@implementation TestFlowLayout

- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    
    return self;
    
    
}

#pragma mark - 1、当collectionView布局item时 第一个执行的方法
- (void)prepareLayout {
    
    [super prepareLayout];
    

    
    
    
    for (NSInteger i = 0; i < self.collectionView.numberOfSections; i++) {
        
        for (NSInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            NSString *name = [_layoutDelegate TestFlowLayoutItemForIndex:indexPath];
            attributes.frame = CGRectMake((10 + 100) * i,(10 + 100) * j, 100, 100 + name.length*10);
            [self.attributesArray addObject:attributes];
            
        }
        
    }
    
    NSLog(@"ssadasfaf");
    
}



- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}





- (NSMutableArray *)attributesArray {
    
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
        
    }
    return _attributesArray;
    
}





























@end
