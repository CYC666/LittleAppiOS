//
//  WeChatPayFinishViewController.h
//  LittleAppOC
//
//  Created by 曹老师 on 2018/3/15.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeChatPayFinishViewControllerDlegate
-(void)payFinish;
@end

@interface WeChatPayFinishViewController : UIViewController

@property (strong, nonatomic) UIImage *mainImage;
@property (strong, nonatomic) UIImage *iconImage;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *payMoney;


// 代理
@property (weak, nonatomic) id<WeChatPayFinishViewControllerDlegate> delegate;

@end
