//
//  CityListController.h
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/14.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityListControllerDelegate <NSObject>

@optional
- (void)didSelectCity:(NSDictionary *)cityDic;

@end

@interface CityListController : UIViewController

@property (weak, nonatomic) id<CityListControllerDelegate> delegate;

@end
