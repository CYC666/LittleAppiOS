//
//  F3HTileView.m
//  NumberTileGame
//
//  Created by Austin Zheng on 3/22/14.
//
//

#import "F3HTileView.h"

#import <QuartzCore/QuartzCore.h>
#import "F3HTileAppearanceProvider.h"

@interface F3HTileView ()

@property (nonatomic, readonly) UIColor *defaultBackgroundColor;
@property (nonatomic, readonly) UIColor *defaultNumberColor;

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic) NSUInteger value;
@end

@implementation F3HTileView

+ (instancetype)tileForPosition:(CGPoint)position
                     sideLength:(CGFloat)side
                          value:(NSUInteger)value
                   cornerRadius:(CGFloat)cornerRadius {
    F3HTileView *tile = [[[self class] alloc] initWithFrame:CGRectMake(position.x,
                                                                       position.y,
                                                                       side,
                                                                       side)];
    tile.tileValue = value;
    tile.backgroundColor = tile.defaultBackgroundColor;
    tile.numberLabel.textColor = tile.defaultNumberColor;
    tile.value = value;
    tile.layer.cornerRadius = cornerRadius;
    return tile;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               frame.size.width,
                                                               frame.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.minimumScaleFactor = 0.5;
    [self addSubview:label];
    self.numberLabel = label;
    return self;
}

- (void)setDelegate:(id<F3HTileAppearanceProviderProtocol>)delegate {
    _delegate = delegate;
    if (delegate) {
        self.backgroundColor = [delegate tileColorForValue:self.tileValue];
        self.numberLabel.textColor = [delegate numberColorForValue:self.tileValue];
        self.numberLabel.font = [delegate fontForNumbers];
    }
}

#pragma mark - 修改小方块的标题
// 根据数值设置小方块的标题颜色跟背景颜色
- (void)setTileValue:(NSInteger)tileValue {
    _tileValue = tileValue;
    self.numberLabel.text = [@(tileValue) stringValue];
    if (self.delegate) {
        self.backgroundColor = [self.delegate tileColorForValue:tileValue];
        self.numberLabel.textColor = [self.delegate numberColorForValue:tileValue];
    }
    self.value = tileValue;
//    if (tileValue == 2) {
//        self.numberLabel.text = @"消费";
//    } else if (tileValue == 4) {
//        self.numberLabel.text = @"消客";
//    } else if (tileValue == 8) {
//        self.numberLabel.text = @"赚钱";
//    } else if (tileValue == 16) {
//        self.numberLabel.text = @"消商";
//    } else if (tileValue == 32) {
//        self.numberLabel.text = @"股东";
//    }
    // self.numberLabel.text = @"消汇邦";
    
}

- (UIColor *)defaultBackgroundColor {
    return [UIColor lightGrayColor];
}

- (UIColor *)defaultNumberColor {
    return [UIColor blackColor];
}

@end
