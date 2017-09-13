//
//  GameCollectionViewFlowLayout.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/13.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "GameCollectionViewFlowLayout.h"

@implementation GameCollectionViewFlowLayout


#pragma mark - 当当前布局bounds发生改变时，让其他布局不发生改变
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
#pragma mark -
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    // 调用父类方法获取当前rect中这些item的布局信息
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *safeAtteibutes = [[NSArray alloc] initWithArray:attributes copyItems:YES];
    for (UICollectionViewLayoutAttributes *attribue in safeAtteibutes) {
        
        attribue.transform3D = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
        
    }
    return safeAtteibutes;  //返回放大后的效果图
}




@end
