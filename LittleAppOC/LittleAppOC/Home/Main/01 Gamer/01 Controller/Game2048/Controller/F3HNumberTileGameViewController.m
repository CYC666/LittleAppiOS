//
//  F3HNumberTileGameViewController.m
//  NumberTileGame
//
//  Created by Austin Zheng on 3/22/14.
//
//

#import "F3HNumberTileGameViewController.h"

#import "F3HGameboardView.h"
#import "F3HControlView.h"
#import "F3HScoreView.h"
#import "F3HGameModel.h"
#import "CYCBangBiScoreView.h"
#import "CYCBestScoreView.h"
#import "CBeginEndButton.h"
#import "CGameRankController.h"

#define GAME2048_DATE @"GAME2048_DATE"              // 记录上一个日期
#define GAME2048_LIFECOUNT @"GAME2048_LIFECOUNT"    // 2048游戏今天剩余次数
#define ELEMENT_SPACING 10                          // 视图之间的差距
#define kScreenHeight [UIScreen mainScreen].bounds.size.height                          // 屏高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width                            // 屏宽


@interface F3HNumberTileGameViewController () <F3HGameModelProtocol, F3HControlViewProtocol>

@property (nonatomic, strong) F3HGameboardView *gameboard;      // 游戏界面
@property (nonatomic, strong) F3HGameModel *model;              // 游戏数据
@property (nonatomic, strong) F3HScoreView *scoreView;          // 得分视图
@property (strong, nonatomic) CYCBangBiScoreView *bangBiView;   // 获得的邦币视图
@property (strong, nonatomic) CYCBestScoreView *bestScoreView;  // 最佳成绩
@property (strong, nonatomic) UILabel *tipLabel;                // 提示
@property (nonatomic, strong) F3HControlView *controlView;      // 控制面板
@property (strong, nonatomic) CBeginEndButton *detialButton;    // 触击显示游戏规则的按钮
@property (strong, nonatomic) UIImageView *detialView;               // 规则详情页

// @property (strong, nonatomic) UILabel *countLabel;  // 步数
@property (strong, nonatomic) UILabel *countPay;    // 消耗邦币

@property (nonatomic) BOOL useScoreView;        // 是否显示得分
@property (nonatomic) BOOL useControlView;      // 是否使用（显示）按钮控制
@property (assign, nonatomic) BOOL isFinal;     // 游戏是否已经结束
@property (assign, nonatomic) NSInteger lifeCount;  // 今日游戏剩余次数

@property (nonatomic) NSUInteger dimension;     // 尺寸       ? * ?
@property (nonatomic) NSUInteger threshold;     // 获胜的分数  ？？？？
@end

@implementation F3HNumberTileGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGame];
}




+ (instancetype)numberTileGameWithDimension:(NSUInteger)dimension
                               winThreshold:(NSUInteger)threshold
                            backgroundColor:(UIColor *)backgroundColor
                              swipeControls:(BOOL)swipeControlsEnabled {
    F3HNumberTileGameViewController *c = [[self class] new];
    c.dimension = dimension > 2 ? dimension : 2;
    c.threshold = threshold > 8 ? threshold : 8;
    c.useScoreView = YES;
    c.useControlView = NO;
    c.view.backgroundColor = backgroundColor ?: [UIColor whiteColor];
    if (swipeControlsEnabled) {
        [c setupSwipeControls];
    }
    return c;
}


- (UIView *)detialView {

    if (_detialView == nil) {
        _detialView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _detialView.backgroundColor = [UIColor whiteColor];
        _detialView.image = [UIImage imageNamed:@"icon_game2048_detial"];
        _detialView.alpha = 0;
        [self.view addSubview:_detialView];
    }
    return _detialView;

}


#pragma mark - 设置手势
- (void)setupSwipeControls {
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(upButtonTapped)];
    upSwipe.numberOfTouchesRequired = 1;
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [_gameboard addGestureRecognizer:upSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(downButtonTapped)];
    downSwipe.numberOfTouchesRequired = 1;
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_gameboard addGestureRecognizer:downSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(leftButtonTapped)];
    leftSwipe.numberOfTouchesRequired = 1;
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_gameboard addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(rightButtonTapped)];
    rightSwipe.numberOfTouchesRequired = 1;
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_gameboard addGestureRecognizer:rightSwipe];
}
#pragma mark - 设置游戏界面
- (void)setupGame {
    
    // 返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_game2048_back"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backButtonAction:)];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    // 标题
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = @"2048";
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    // 左右间隔
    float space = 15;
    
    // 获得的邦币视图
    _bangBiView = [CYCBangBiScoreView bangBiScoreViewWithCornerRadius:5
                                                      backgroundColor:[UIColor colorWithRed:255/255.0 green:127/255.0 blue:47/255.0 alpha:1]
                                                            textColor:[UIColor whiteColor]
                                                             textFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:40] // 32
                                                                frame:CGRectMake(20, 15, 110, 115)];
    [self.view addSubview:_bangBiView];
    
    // 是否打开成绩面板
    if (self.useScoreView) {
        _scoreView = [F3HScoreView scoreViewWithCornerRadius:5
                                             backgroundColor:[UIColor colorWithRed:238/255.0 green:223/255.0 blue:203/255.0 alpha:1]
                                                   textColor:[UIColor colorWithRed:120/255.0 green:110/255.0 blue:100/255.0 alpha:1]
                                                    textFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:32]
                                                       frame:CGRectMake(20 + 110 + space, 15, (kScreenWidth - space*2 - 20*2 - 110)/2.0, 64)];
        [self.view addSubview:_scoreView];
    }
    
    // 排行榜按钮
    UIButton *rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rankButton.frame = CGRectMake(20 + 110 + space, 15 + 64 + 15, (kScreenWidth - space*2 - 20*2 - 110)/2.0, 36);
    rankButton.layer.cornerRadius = 5;
    [rankButton setTitle:@"排行榜" forState:UIControlStateNormal];
    rankButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:19];
    rankButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:223/255.0 blue:203/255.0 alpha:1];
    [rankButton setTitleColor:[UIColor colorWithRed:120/255.0 green:110/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [rankButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
    [rankButton addTarget:self action:@selector(rankButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rankButton];
    
    // 最高成绩
    NSString *key = [NSString stringWithFormat:@"game2048_best_score_%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]];
    NSInteger bestScore = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    _bestScoreView = [CYCBestScoreView bestScoreViewWithCornerRadius:5
                                                     backgroundColor:[UIColor colorWithRed:238/255.0 green:223/255.0 blue:203/255.0 alpha:1]
                                                           textColor:[UIColor colorWithRed:120/255.0 green:110/255.0 blue:100/255.0 alpha:1]
                                                            textFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:32]
                                                           bestScore:bestScore
                                                               frame:CGRectMake(kScreenWidth - 20 - (kScreenWidth - space*2 - 20*2 - 110)/2.0, 15, (kScreenWidth - space*2 - 20*2 - 110)/2.0, 64)];
    [self.view addSubview:_bestScoreView];
    
    // 开始游戏、重置按钮
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(kScreenWidth - 20 - (kScreenWidth - space*2 - 20*2 - 110)/2.0, 15 + 64 + 15, (kScreenWidth - space*2 - 20*2 - 110)/2.0, 36);
    resetButton.layer.cornerRadius = 5;
    [resetButton setTitle:@"开始游戏" forState:UIControlStateNormal];
    resetButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    resetButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:19];
    resetButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:223/255.0 blue:203/255.0 alpha:1];
    [resetButton setTitleColor:[UIColor colorWithRed:120/255.0 green:110/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
    [resetButton addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    float Hspace = 0;
    if (kScreenWidth < 375) {
        Hspace = 15;
    } else if (kScreenWidth == 375) {
        Hspace = 20;
    } else if (kScreenWidth > 375) {
        Hspace = 30;
    }
    
    _lifeCount = [self loadLifeCount];
    // 提示
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15 + 115 + Hspace, kScreenWidth - 20*2, 20)];
    _tipLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    _tipLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
    _tipLabel.adjustsFontSizeToFitWidth = YES;
    _tipLabel.text = [NSString stringWithFormat:@"今日剩余游戏次数: %ld", (long)_lifeCount];
    [self.view addSubview:_tipLabel];
    
    
    
    
    // 游戏主视图
    CGFloat padding = (self.dimension > 5) ? 3.0 : 6.0; // 小格子间隙
    CGFloat cellWidth = floorf((kScreenWidth - 40 - padding*(self.dimension+1))/((float)self.dimension)); // 小格子大小
    if (cellWidth < 30) {   // 控制小格子最小宽高
        cellWidth = 30;
    }
    F3HGameboardView *gameboard = [F3HGameboardView gameboardWithDimension:self.dimension
                                                                 cellWidth:cellWidth
                                                               cellPadding:padding
                                                              cornerRadius:6
                                                           backgroundColor:[UIColor colorWithRed:185/255.0 green:172/255.0 blue:160/255.0 alpha:1]
                                                           foregroundColor:[UIColor colorWithRed:202/255.0 green:190/255.0 blue:180/255.0 alpha:1]];
    CGRect gameboardFrame = gameboard.frame;
    gameboardFrame.origin.y = 15 + 115 + Hspace + 20 + Hspace;
    gameboard.frame = gameboardFrame;
    gameboard.userInteractionEnabled = NO;  // 刚开始不允许游戏，需要点击开始游戏
    gameboard.alpha = 0.5;
    [self.view addSubview:gameboard];
    self.gameboard = gameboard;
    
    
    // 创建游戏数据模型
    F3HGameModel *model = [F3HGameModel gameModelWithDimension:self.dimension
                                                      winValue:self.threshold
                                                      delegate:self];
    [model insertAtRandomLocationTileWithValue:2];
    [model insertAtRandomLocationTileWithValue:2];
    self.model = model;
    
//    // 步数
//    UILabel *bushu = [[UILabel alloc] initWithFrame:CGRectMake(20, kScreenHeight - 94 - 30, 40, 20)];
//    bushu.text = @"步数:";
//    bushu.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
//    [self.view addSubview:bushu];
//    
//    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + 40, kScreenHeight - 94 - 30, 40, 20)];
//    _countLabel.text = @"0";
//    _countLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
//    [self.view addSubview:_countLabel];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 游戏规则提示标签
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 20 - 24 - 200, kScreenHeight - 20 - 24 - 64, 200, 24)];
        tipLabel.text = @"详情规则请长按 --> ";
        tipLabel.textAlignment = NSTextAlignmentRight;
        tipLabel.adjustsFontSizeToFitWidth = YES;
        tipLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
        [self.view addSubview:tipLabel];
    });
    
//    _countPay = [[UILabel alloc] initWithFrame:CGRectMake(20 + 80, kScreenHeight - 104, 100, 20)];
//    _countPay.text = @"0";
//    _countPay.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
//    [self.view addSubview:_countPay];
    
    // 触击显示规则的按钮
    _detialButton = [[CBeginEndButton alloc] initWithFrame:CGRectMake(kScreenWidth - 20 - 24, kScreenHeight - 20 - 24 - 64, 24, 24)
                                              unTouchImage:@"icon_game_detial_unselect"
                                                touchImage:@"icon_game_detial_select"];
    [self.view addSubview:_detialButton];
    
    
    
    
    __weak typeof(self) weakSelf = self;
    _detialButton.startBlock = ^() {
    
        [UIView animateWithDuration:.35
                         animations:^{
                             weakSelf.detialView.alpha = 1;
                         }];
    
    };
    _detialButton.endBlock = ^() {
    
        [UIView animateWithDuration:.35
                         animations:^{
                             weakSelf.detialView.alpha = 0;
                         }];
    
    };
    
}




#pragma mark - 每走一步都会判断，设置邦币
// 判断成绩 如果
- (void)followUp {
    
    // 从新设置步数
    // _countLabel.text = [NSString stringWithFormat:@"%ld", [_countLabel.text integerValue] + 1];
    // 从新设置消耗邦币
    // _countPay.text = [NSString stringWithFormat:@"%ld", [_countPay.text integerValue] + 1];
    
    // This is the earliest point the user can win
    if ([self.model userHasWon]) {
        // [self.delegate gameFinishedWithVictory:YES score:self.model.score];
        // 提示,并修改下一个任务
        if (_threshold == 256) {
            self.bangBiView.score = 50;
            _threshold = 512;
            self.model.winValue = 512;
        } else if (_threshold == 512) {
            self.bangBiView.score = 100;
            _threshold = 1024;
            self.model.winValue = 1024;
        } else if (_threshold == 1024) {
            self.bangBiView.score = 200;
            _threshold = 2048;
            self.model.winValue = 2048;
        } else if (_threshold == 2048) {
            self.bangBiView.score = 400;
            _threshold = 4096;
            self.model.winValue = 4096;
        } else if (_threshold == 4096) {
            self.bangBiView.score = 800;
            _threshold = 8192;
            self.model.winValue = 8192;
        } else if (_threshold == 8192) {
            self.bangBiView.score = 1600;
            _threshold = 16384;
            self.model.winValue = 16384;
        } else {
            self.bangBiView.score = 6400;
            _threshold = 100000000;
            self.model.winValue = 100000000;
        }
        
    }
    else {
        NSInteger rand = arc4random_uniform(10);
        if (rand == 1) {
            [self.model insertAtRandomLocationTileWithValue:4];
        }
        else {
            [self.model insertAtRandomLocationTileWithValue:2];
        }
        // At this point, the user may lose
        if ([self.model userHasLost]) {
            [self.delegate gameFinishedWithVictory:NO score:self.model.score];
            // 提示,
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游戏结束"
                                                            message:nil // [NSString stringWithFormat:@"你获得了%ld个邦币", (long)_bangBiView.score]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:@"再来一局", nil];
            [alert show];
            
            
        }
    }
}



#pragma mark - Model Protocol

- (void)moveTileFromIndexPath:(NSIndexPath *)fromPath toIndexPath:(NSIndexPath *)toPath newValue:(NSUInteger)value {
    [self.gameboard moveTileAtIndexPath:fromPath toIndexPath:toPath withValue:value];
}

- (void)moveTileOne:(NSIndexPath *)startA tileTwo:(NSIndexPath *)startB toIndexPath:(NSIndexPath *)end newValue:(NSUInteger)value {
    [self.gameboard moveTileOne:startA tileTwo:startB toIndexPath:end withValue:value];
}

- (void)insertTileAtIndexPath:(NSIndexPath *)path value:(NSUInteger)value {
    [self.gameboard insertTileAtIndexPath:path withValue:value];
}
// 分数改变
- (void)scoreChanged:(NSInteger)newScore {
    self.scoreView.score = newScore;
    // 获取的邦币(存在2048就赠送1000)
    // self.bangBiView.score = newScore*0.012;
    // 最佳成绩
    if (newScore >= _bestScoreView.score) {
        _bestScoreView.score = newScore;
    }
    
    // 重新开始
    if (newScore == 0) {
        _bangBiView.score = 0;
        // _countLabel.text = @"0";
        // _countPay.text = @"0";
    }
}


#pragma mark - 手势响应
- (void)upButtonTapped {
    [self.model performMoveInDirection:F3HMoveDirectionUp completionBlock:^(BOOL changed) {
        if (changed) [self followUp];
    }];
}

- (void)downButtonTapped {
    [self.model performMoveInDirection:F3HMoveDirectionDown completionBlock:^(BOOL changed) {
        if (changed) [self followUp];
    }];
}

- (void)leftButtonTapped {
    [self.model performMoveInDirection:F3HMoveDirectionLeft completionBlock:^(BOOL changed) {
        if (changed) [self followUp];
    }];
}

- (void)rightButtonTapped {
    [self.model performMoveInDirection:F3HMoveDirectionRight completionBlock:^(BOOL changed) {
        if (changed) [self followUp];
    }];
}

#pragma mark - 按钮响应
- (void)backButtonAction:(UIBarButtonItem *)button {

    // 当分数不为0时，提示是否重新开始，否则直接重新开始
    if (_scoreView.score != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要退出游戏？"
                                                        message:nil // @"这将结束游戏，但你仍然获得邦币"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
    
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

}

- (void)rankButtonAction:(UIButton *)button {

    // 跳转到排行榜
    CGameRankController *controller = [[CGameRankController alloc] initWithGameType:GAME2048];
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)resetButtonAction:(UIButton *)button {
    
    // 游戏次数用尽，直接返回
    if (_lifeCount == 0) {
        return;
    }
    
    if ([button.titleLabel.text isEqualToString:@"开始游戏"]) {
        [button setTitle:@"重新开始" forState:UIControlStateNormal];
        _gameboard.alpha = 1;
        _gameboard.userInteractionEnabled = YES;
        _tipLabel.text = [NSString stringWithFormat:@"今日剩余游戏次数: %ld", (long)--_lifeCount];
        NSString *lifeKey = [NSString stringWithFormat:@"GAME2048_LIFECOUNT_%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)_lifeCount] forKey:lifeKey];
    } else {
        // 当得分不为0时，提示是否重新开始，否则直接重新开始
        if (_scoreView.score != 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要重新开始？"
                                                            message:nil // @"这将结束进度，但你仍然获得邦币"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
        } else {
            [self resetButtonTapped];
        }
    }
    
    

}

- (void)resetButtonTapped {
    [self.gameboard reset];
    [self.model reset];
    [self.model insertAtRandomLocationTileWithValue:2];
    [self.model insertAtRandomLocationTileWithValue:2];
}

-(void)exitButtonTapped {

    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - 保存最佳成绩（应该在退出、重新开始、游戏结束的时候执行,同时上传最佳成绩）
- (void)saveBestScore {
    
    // 判断游戏记录是否更新
    NSString *key = [NSString stringWithFormat:@"game2048_best_score_%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]];
    if (_bestScoreView.score > [[NSUserDefaults standardUserDefaults] integerForKey:key]) {
        [[NSUserDefaults standardUserDefaults] setInteger:_bestScoreView.score forKey:key];
    }
    
    

}

#pragma mark - 点击了alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertView.title isEqualToString:@"游戏结束"]) {
        if (buttonIndex == 1) {
            // 再来一局
            [self saveBestScore];
            [self resetButtonTapped];
        } else {
            // 当游戏结束了，点击了取消按钮，那么就把当前游戏进度定位isFinal
            _isFinal = YES;
            [self saveBestScore];
        }
        
        
    } else if ([alertView.title isEqualToString:@"确定要重新开始？"]) {
        if (buttonIndex == 1) {
            // 修改今日剩余游戏次数
            _tipLabel.text = [NSString stringWithFormat:@"今日剩余游戏次数: %ld", (long)--_lifeCount];
            NSString *lifeKey = [NSString stringWithFormat:@"GAME2048_LIFECOUNT_%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)_lifeCount] forKey:lifeKey];
            // 重开一局就上传最佳成绩
            // 如果已经是游戏结束了，那就不必再显示赠送邦币
            if (_isFinal == YES) {
                [self resetButtonTapped];
                _isFinal = NO;
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游戏结束"
                                                                message:nil // [NSString stringWithFormat:@"你获得了%ld个邦币", (long)_bangBiView.score]
                                                               delegate:self
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles:nil];
                [alert show];

                [self saveBestScore];
                [self resetButtonTapped];
            }
            
            
        }
        
    } else if ([alertView.title isEqualToString:@"确定要退出游戏？"]) {
        if (buttonIndex == 1) {
            // 退出游戏就上传最佳成绩
            // 如果已经是游戏结束了，那就不必要再保存
            if (_isFinal == NO) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游戏结束"
                                                                message: nil // [NSString stringWithFormat:@"你获得了%ld个邦币", (long)_bangBiView.score]
                                                               delegate:self
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles:nil];
                [alert show];
                [self saveBestScore];
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark - 获取游戏剩余次数
- (NSInteger)loadLifeCount {

    // 判断上个日期是否存在，不存在则创建
    if ([[NSUserDefaults standardUserDefaults] objectForKey:GAME2048_DATE] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2017-01-14" forKey:GAME2048_DATE];
    }
    // 判断游戏剩余次数是否存在，不存在则创建
    NSString *lifeKey = [NSString stringWithFormat:@"GAME2048_LIFECOUNT_%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:lifeKey] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@10 forKey:lifeKey];
    }
    
    // 判断当前日期是否跟上一个日期一致，一致则不重置剩余次数，直从沙盒中提取
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    if ([currentTime isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:GAME2048_DATE]]) {    // 一致，直接从沙盒取出
        return [[[NSUserDefaults standardUserDefaults] objectForKey:lifeKey] integerValue];
    
    } else {    // 不一致，重置次数
        // 修改日期,修改游戏次数
        [[NSUserDefaults standardUserDefaults] setObject:currentTime forKey:GAME2048_DATE];
        [[NSUserDefaults standardUserDefaults] setObject:@10 forKey:lifeKey];
        return 10;
    }

}




@end



/*
 
 // 是否打开了允许按钮控制
 if (self.useControlView) {
 controlView = [F3HControlView controlViewWithCornerRadius:5
 backgroundColor:[UIColor blackColor]
 movementButtons:YES
 exitButton:NO
 delegate:self];
 totalHeight += (ELEMENT_SPACING + controlView.bounds.size.height);
 self.controlView = controlView;
 }

 
 if (self.useScoreView) {
 CGRect scoreFrame = scoreView.frame;
 scoreFrame.origin.x = 0.5*(self.view.bounds.size.width - scoreFrame.size.width);
 scoreFrame.origin.y = currentTop;
 scoreView.frame = scoreFrame;
 [self.view addSubview:scoreView];
 currentTop += (scoreFrame.size.height + ELEMENT_SPACING);
 }

 if (self.useControlView) {
 CGRect controlFrame = controlView.frame;
 controlFrame.origin.x = 0.5*(self.view.bounds.size.width - controlFrame.size.width);
 controlFrame.origin.y = currentTop;
 controlView.frame = controlFrame;
 [self.view addSubview:controlView];
 }
 
 //-----------------------------------------------------计算并设置frame-----------------------------------------------------
 // 计算UI的Y起点，如果小于0那么从0开始
 CGFloat currentTop = 0.5*(self.view.bounds.size.height - totalHeight);
 if (currentTop < 0) {
 currentTop = 0;
 }


 CGRect gameboardFrame = gameboard.frame;
 gameboardFrame.origin.x = 0.5*(self.view.bounds.size.width - gameboardFrame.size.width);
 gameboardFrame.origin.y = currentTop;
 gameboard.frame = gameboardFrame;
 
 currentTop += (gameboardFrame.size.height + ELEMENT_SPACING);



 // 监听最佳成绩是否变化
 [_bestScoreView addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:nil];
 
 #pragma mark - 最佳成绩变化的监听
 - (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
 
 // 当最佳成绩变化了，那就更改本地最佳成绩
 if ([keyPath isEqualToString:@"score"]) {
 [self saveBestScore];
 }
 
 }

 #pragma mark - 对象销毁
 - (void)dealloc {
 
 [_bestScoreView removeObserver:self forKeyPath:@"score"];
 
 }
























 
 */


































