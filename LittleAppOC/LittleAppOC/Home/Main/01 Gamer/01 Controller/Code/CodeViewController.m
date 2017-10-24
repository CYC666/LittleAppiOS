//
//  CodeViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/21.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CodeViewController.h"
#import <CoreImage/CoreImage.h>
#import "CNetWorking.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+CShow.h"

@interface CodeViewController () <UITextFieldDelegate> {

    BOOL isColor;       // 是否是彩色的
    UIImageView *imageView; // 显示二维码的图

}

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"普通二维码";
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.view.backgroundColor = CTHEME.themeColor;
    
    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setImage:[UIImage imageNamed:@"普通二维码"]  forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 40, 22);
    [rightItem addTarget:self action:@selector(changeCodeStyleAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
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


#pragma mark - 输入完毕，准备生产二维码
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if ([textField.text isEqualToString:@""]) {
        
        // 弹框提示是否执行
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"请输入内容"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"好的"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    
                                                    
                                                    
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
    
        if (isColor) {
            
            // 彩色二维码
            [self creatColorCode:textField.text];
            
        } else {
        
            // 普通二维码
            // 1.创建滤镜对象
            CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
            
            // 2.恢复默认设置
            [filter setDefaults];
            
            // 3.设置数据
            NSString *info = textField.text;
            NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
            [filter setValue:infoData forKey:@"inputMessage"];
            // 4.生成二维码
            CIImage *outputImage = [filter outputImage];
            imageView.image = [self createNonInterpolatedUIIamgeFormCIImage:outputImage withSize:kScreenWidth - 40];
        
        }
    
    }
    
    
    
    return YES;

}

#pragma mark - 切换二维码样式
- (void)changeCodeStyleAction:(UIButton *)button {
    
    isColor = !isColor;
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    
    //1 创建动画对象
    CATransition *trans = [CATransition animation];
    //2 设置动画属性
    trans.duration = 0.35;
    trans.repeatCount = 1;
    //3 设置动画效果（立方体效果）
    trans.type = @"cube";
    trans.subtype = @"fromLeft";
    //4 开始动画
    [button.layer addAnimation:trans forKey:nil];
    
    
    if (isColor) {
        titleLabel.text = @"彩色二维码";
        [button setImage:[UIImage imageNamed:@"彩色二维码"] forState:UIControlStateNormal];
    } else {
        titleLabel.text = @"普通二维码";
        [button setImage:[UIImage imageNamed:@"普通二维码"] forState:UIControlStateNormal];
    }
    
}


#pragma mark - 创建UI
- (void)creatSubview {
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, kScreenWidth - 40, 30)];
    field.placeholder = @"输入要生成二维码的文本";
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.delegate = self;
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.returnKeyType = UIReturnKeyGo;
    [self.view addSubview:field];
    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, kScreenWidth - 120, kScreenWidth - 120)];
    [imageView Chow];       // 赋予点击事件，查看大图
    [self.view addSubview:imageView];
    
    
    

}

#pragma mark - 生产彩色二维码
- (void)creatColorCode:(NSString *)string {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"还没做好呢"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"好吧"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                
                                                
                                            }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - 生成普通二维码
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
