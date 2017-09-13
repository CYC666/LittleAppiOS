//
//  F3HGameboardView.m
//  NumberTileGame
//
//  Created by Austin Zheng on 3/22/14.
//
//

#import "F3HGameboardView.h"

#import <QuartzCore/QuartzCore.h>
#import "F3HTileView.h"
#import "F3HTileAppearanceProvider.h"

#define PER_SQUARE_SLIDE_DURATION 0.08  // 合并时间

#if DEBUG
#define F3HLOG(...) NSLog(__VA_ARGS__)
#else
#define F3HLOG(...)
#endif

// Animation parameters
#define TILE_POP_START_SCALE    0.1     // 刚开始出现小方块时缩放的大小
#define TILE_POP_MAX_SCALE      1.1     // 瓦片出现时放大的倍数
#define TILE_POP_DELAY          0.05    // 瓦片延时这么多时间之后开始出现
#define TILE_EXPAND_TIME        0.18    // 瓦片出现持续的时间
#define TILE_RETRACT_TIME       0.08    // 瓦片出现之后恢复持续的时间

#define TILE_MERGE_START_SCALE  1.0
#define TILE_MERGE_EXPAND_TIME  0.08
#define TILE_MERGE_RETRACT_TIME 0.08


@interface F3HGameboardView ()

@property (nonatomic, strong) NSMutableDictionary *boardTiles;  // 储存瓦片的字典

@property (nonatomic) NSUInteger dimension;                     // 尺寸4*4
@property (nonatomic) CGFloat tileSideLength;                   // 瓦片的大小

@property (nonatomic) CGFloat padding;                          // 瓦片间距
@property (nonatomic) CGFloat cornerRadius;                     // 瓦片的圆角

@property (nonatomic, strong) F3HTileAppearanceProvider *provider;  // 当小方块出现的时候，根据数值设置小方块的标题颜色跟背景颜色

@end

@implementation F3HGameboardView

+ (instancetype)gameboardWithDimension:(NSUInteger)dimension        // 尺寸4*4
                             cellWidth:(CGFloat)width               // 瓦片的大小
                           cellPadding:(CGFloat)padding             // 瓦片间距
                          cornerRadius:(CGFloat)cornerRadius        // 瓦片的圆角
                       backgroundColor:(UIColor *)backgroundColor   // 游戏主板的颜色
                       foregroundColor:(UIColor *)foregroundColor { // 瓦片的颜色
    
    CGFloat sideLength = padding + dimension*(width + padding);
    F3HGameboardView *view = [[[self class] alloc] initWithFrame:CGRectMake(20,
                                                                            0,
                                                                            sideLength,
                                                                            sideLength)];
    view.dimension = dimension;
    view.padding = padding;
    view.tileSideLength = width;
    view.layer.cornerRadius = cornerRadius;
    view.cornerRadius = cornerRadius;
    [view setupBackgroundWithBackgroundColor:backgroundColor
                             foregroundColor:foregroundColor];
    return view;
}

- (void)reset {
    for (NSString *key in self.boardTiles) {
        F3HTileView *tile = self.boardTiles[key];
        [tile removeFromSuperview];
    }
    [self.boardTiles removeAllObjects];
}

- (void)setupBackgroundWithBackgroundColor:(UIColor *)background
                           foregroundColor:(UIColor *)foreground {
    self.backgroundColor = background;
    CGFloat xCursor = self.padding;
    CGFloat yCursor;
    CGFloat cornerRadius = self.cornerRadius - 2;
    if (cornerRadius < 0) {
        cornerRadius = 0;
    }
    // 创建瓦片后面的背景颜色
    for (NSInteger i=0; i<self.dimension; i++) {
        yCursor = self.padding;
        for (NSInteger j=0; j<self.dimension; j++) {
            UIView *bkgndTile = [[UIView alloc] initWithFrame:CGRectMake(xCursor,
                                                                         yCursor,
                                                                         self.tileSideLength,
                                                                         self.tileSideLength)];
            bkgndTile.layer.cornerRadius = cornerRadius;
            bkgndTile.backgroundColor = foreground;
            [self addSubview:bkgndTile];
            yCursor += self.padding + self.tileSideLength;
        }
        xCursor += self.padding + self.tileSideLength;
    }
}

// Insert a tile, with the popping animation
- (void)insertTileAtIndexPath:(NSIndexPath *)path
                    withValue:(NSUInteger)value {
    // F3HLOG(@"Inserting tile at row %ld, column %ld", (long)path.row, (long)path.section);
    if (!path
        || path.row >= self.dimension
        || path.section >= self.dimension
        || self.boardTiles[path]) {
        // Index path out of bounds, or there already is a tile
        return;
    }
    
    CGFloat x = self.padding + path.section*(self.tileSideLength + self.padding);
    CGFloat y = self.padding + path.row*(self.tileSideLength + self.padding);
    CGPoint position = CGPointMake(x, y);
    CGFloat cornerRadius = self.cornerRadius - 2;
    if (cornerRadius < 0) {
        cornerRadius = 0;
    }
    // 创建小方块
    F3HTileView *tile = [F3HTileView tileForPosition:position
                                          sideLength:self.tileSideLength
                                               value:value
                                        cornerRadius:cornerRadius];
    tile.delegate = self.provider;
    tile.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_START_SCALE, TILE_POP_START_SCALE);
    [self addSubview:tile];
    self.boardTiles[path] = tile;

    // Add the new tile to the board, with a pop animation
    [UIView animateWithDuration:TILE_EXPAND_TIME
                          delay:TILE_POP_DELAY
                        options:0
                     animations:^{
                         tile.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_MAX_SCALE,
                                                                                 TILE_POP_MAX_SCALE);
    } completion:^(BOOL finished) {
        // Run the 'shrink' animation
        [UIView animateWithDuration:TILE_RETRACT_TIME animations:^{
            tile.layer.affineTransform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // Nothing right now
        }];
    }];
}

- (void)moveTileOne:(NSIndexPath *)startA
            tileTwo:(NSIndexPath *)startB
        toIndexPath:(NSIndexPath *)end
          withValue:(NSUInteger)value {
    F3HLOG(@"Moving tiles at row %ld, column %ld and row %ld, column %ld to destination row %ld, column %ld",
           (long)startA.row, (long)startA.section,
           (long)startB.row, (long)startB.section,
           (long)end.row, (long)end.section);
    if (!startA || !startB || !self.boardTiles[startA] || !self.boardTiles[startB]
        || end.row >= self.dimension
        || end.section >= self.dimension) {
        NSAssert(NO, @"Invalid two-tile move and merge");
        return;
    }
    F3HTileView *tileA = self.boardTiles[startA];
    F3HTileView *tileB = self.boardTiles[startB];
    
    CGFloat x = self.padding + end.section*(self.tileSideLength + self.padding);
    CGFloat y = self.padding + end.row*(self.tileSideLength + self.padding);
    CGRect finalFrame = tileA.frame;
    finalFrame.origin.x = x;
    finalFrame.origin.y = y;
    
    // Don't perform update after animation
    [self.boardTiles removeObjectForKey:startA];
    [self.boardTiles removeObjectForKey:startB];
    self.boardTiles[end] = tileA;

    [UIView animateWithDuration:(PER_SQUARE_SLIDE_DURATION*1)
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         tileA.frame = finalFrame;
                         tileB.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         tileA.tileValue = value;
                         if (!finished) {
                             [tileB removeFromSuperview];
                             return;
                         }
                         tileA.layer.affineTransform = CGAffineTransformMakeScale(TILE_MERGE_START_SCALE,
                                                                                  TILE_MERGE_START_SCALE);
                         [tileB removeFromSuperview];
                         [UIView animateWithDuration:TILE_MERGE_EXPAND_TIME
                                          animations:^{
                                              tileA.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_MAX_SCALE,
                                                                                                       TILE_POP_MAX_SCALE);
                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:TILE_MERGE_RETRACT_TIME
                                                               animations:^{
                                                                   tileA.layer.affineTransform = CGAffineTransformIdentity;
                                                               } completion:^(BOOL finished) {
                                                                   // nothing yet
                                                               }];
                                          }];
                     }];
}

// Move a single tile onto another tile (that stays stationary), merging the two
- (void)moveTileAtIndexPath:(NSIndexPath *)start
                toIndexPath:(NSIndexPath *)end
                  withValue:(NSUInteger)value {
    F3HLOG(@"Moving tile at row %ld, column %ld to destination row %ld, column %ld",
           (long)start.row, (long)start.section, (long)end.row, (long)end.section);
    if (!start || !end || !self.boardTiles[start]
        || end.row >= self.dimension
        || end.section >= self.dimension) {
        NSAssert(NO, @"Invalid one-tile move and merge");
        return;
    }
    F3HTileView *tile = self.boardTiles[start];
    F3HTileView *endTile = self.boardTiles[end];
    BOOL shouldPop = endTile != nil;
    
    CGFloat x = self.padding + end.section*(self.tileSideLength + self.padding);
    CGFloat y = self.padding + end.row*(self.tileSideLength + self.padding);
    CGRect finalFrame = tile.frame;
    finalFrame.origin.x = x;
    finalFrame.origin.y = y;
    
    // Update board state
    [self.boardTiles removeObjectForKey:start];
    self.boardTiles[end] = tile;
    
    [UIView animateWithDuration:(PER_SQUARE_SLIDE_DURATION)
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         tile.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         tile.tileValue = value;
                         if (!shouldPop || !finished) {
                             return;
                         }
                         tile.layer.affineTransform = CGAffineTransformMakeScale(TILE_MERGE_START_SCALE,
                                                                                 TILE_MERGE_START_SCALE);
                         [endTile removeFromSuperview];
                         [UIView animateWithDuration:TILE_MERGE_EXPAND_TIME
                                          animations:^{
                                              tile.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_MAX_SCALE,
                                                                                                      TILE_POP_MAX_SCALE);
                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:TILE_MERGE_RETRACT_TIME
                                                               animations:^{
                                                                   tile.layer.affineTransform = CGAffineTransformIdentity;
                                                               } completion:^(BOOL finished) {
                                                                   // nothing yet
                                                               }];
                                          }];
                     }];
}

// 瓦片的颜色
- (F3HTileAppearanceProvider *)provider {
    if (!_provider) {
        _provider = [F3HTileAppearanceProvider new];
    }
    return _provider;
}

- (NSMutableDictionary *)boardTiles {
    if (!_boardTiles) {
        _boardTiles = [NSMutableDictionary dictionary];
    }
    return _boardTiles;
}

@end
