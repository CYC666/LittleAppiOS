//
//  F3HTileAppearanceProvider.h
//  NumberTileGame
//
//  Created by Austin Zheng on 3/22/14.
//
//

// 当小方块出现的时候，根据数值设置小方块的标题颜色跟背景颜色

#import <Foundation/Foundation.h>

@protocol F3HTileAppearanceProviderProtocol <NSObject>

- (UIColor *)tileColorForValue:(NSUInteger)value;
- (UIColor *)numberColorForValue:(NSUInteger)value;
- (UIFont *)fontForNumbers;

@end

@interface F3HTileAppearanceProvider : NSObject <F3HTileAppearanceProviderProtocol>

@end
