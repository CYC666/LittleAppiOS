//
//  TestFlowLayout.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/4/3.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestFlowLayoutDlegate
-(NSString *)TestFlowLayoutItemForIndex:(NSIndexPath *)indexPath;

@end



@interface TestFlowLayout : UICollectionViewFlowLayout

@property (strong, nonatomic) NSMutableArray *attributesArray;

// 代理
@property (weak, nonatomic) id<TestFlowLayoutDlegate> layoutDelegate;



@end
