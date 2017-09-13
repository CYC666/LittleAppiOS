//
//  F3HTileModel.h
//  NumberTileGame
//
//  Created by Austin Zheng on 3/24/14.
//
//

// 储存小格子数值的模型

#import <Foundation/Foundation.h>

@interface F3HTileModel : NSObject

@property (nonatomic) BOOL empty;
@property (nonatomic) NSUInteger value;
+ (instancetype)emptyTile;

@end
