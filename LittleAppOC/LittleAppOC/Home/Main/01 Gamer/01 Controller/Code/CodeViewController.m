//
//  CodeViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/21.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CodeViewController.h"
#import <CoreImage/CoreImage.h>

@interface CodeViewController () {

    // 滑动视图
    UIScrollView *mainScrollView;

}

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"二维码";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = CTHEME.themeColor;
    
    
    // 监听主题改变
    [CNOTIFY addObserver:self
                selector:@selector(changeBackgroundColor:)
                    name:CThemeChangeNotification
                  object:nil];
    
    [self creatSubview];

    
}



#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}




#pragma mark - 创建UI
- (void)creatSubview {

    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mainScrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight-64);
    mainScrollView.backgroundColor = [UIColor clearColor];
    mainScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    mainScrollView.pagingEnabled = YES;
    [self.view addSubview:mainScrollView];
    
    CGFloat size = (kScreenWidth * 0.5 - 40);
    UIWebView *webViewA = [[UIWebView alloc] initWithFrame:CGRectMake(kScreenWidth + 20, kScreenHeight - size*2, size, size)];
    NSData *gifA = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"icon_gamer_code_A" ofType:@"gif"]];
    [webViewA loadData:gifA MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [mainScrollView addSubview:webViewA];
    webViewA.layer.cornerRadius = size * 0.5;
    webViewA.clipsToBounds = YES;
    
    UIWebView *webViewB = [[UIWebView alloc] initWithFrame:CGRectMake(kScreenWidth + 20 + kScreenWidth * 0.5, kScreenHeight - size*2, size, size)];
    NSData *gifB = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"icon_gamer_code_B" ofType:@"gif"]];
    [webViewB loadData:gifB MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [mainScrollView addSubview:webViewB];
    webViewB.layer.cornerRadius = size * 0.5;
    webViewB.clipsToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth + 20, 20, kScreenWidth - 40, kScreenWidth - 40)];
    [mainScrollView addSubview:imageView];
    
    
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3.设置数据
    NSString *info = @"https://fir.im/cycLittleAppiOS";
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKey:@"inputMessage"];
    // 4.生成二维码
    CIImage *outputImage = [filter outputImage];
    imageView.image = [self createNonInterpolatedUIIamgeFormCIImage:outputImage withSize:kScreenWidth - 40];
    
    

}


#pragma mark - 生成二维码
- (UIImage *)createNonInterpolatedUIIamgeFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    // 1.创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceCMYK();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


































@end
