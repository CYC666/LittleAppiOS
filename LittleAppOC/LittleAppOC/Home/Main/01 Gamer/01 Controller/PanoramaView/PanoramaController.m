//
//  PanoramaController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/11.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "PanoramaController.h"
#import "YQPanoramaView.h"

@interface PanoramaController ()

@property (nonatomic,strong) YQPanoramaView *panaromview;

@end

@implementation PanoramaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全景图";
    
    //初始化
    self.panaromview = [[YQPanoramaView alloc]initWithFrame:CGRectMake(0, Nav_Height, self.view.frame.size.width, self.view.frame.size.height-Nav_Height)];
    
    //设图片
    self.panaromview.image = [UIImage imageNamed:@"WechatIMG72.jpeg"];
    
    //显示
    [self.view addSubview:self.panaromview];
    
    //完事了
}

@end
