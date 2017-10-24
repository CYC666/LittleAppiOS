//
//  UIImageView+CShow.m
//  
//
//  Created by 曹奕程 on 2017/10/24.
//
//

#import "UIImageView+CShow.h"


@implementation UIImageView (CShow)


#pragma mark ========================================点击查看大图=============================================

- (void)Chow {

    // 单击隐藏
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cShowImageView)];
    [self addGestureRecognizer:tap];


}


#pragma mark - 查看大图
- (void)cShowImageView {

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.image = self.image;
    imageView.alpha = 0;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [[UIApplication sharedApplication].keyWindow addSubview:imageView];
    
    [UIView animateWithDuration:0.35 animations:^{
        imageView.alpha = 1;
    }];
    
    // 单击隐藏
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImageView:)];
    [imageView addGestureRecognizer:tap];
    
    // 长按保存
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageAction:)];
    longPress.minimumPressDuration = 1;
    [imageView addGestureRecognizer:longPress];

}


#pragma mark - 隐藏
- (void)dismissImageView:(UITapGestureRecognizer *)tap {

    __block UIImageView *imageView = (UIImageView *)tap.view;
    [UIView animateWithDuration:0.2 animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        imageView = nil;
    }];

}

#pragma mark - 保存图片
- (void)saveImageAction:(UILongPressGestureRecognizer *)longPress {

    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIImageView *imageView = (UIImageView *)longPress.view;
        UIImage *image = imageView.image;
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (!error) {
        __block UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -60, kScreenWidth, 60)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.backgroundColor = [UIColor blackColor];
        tipLabel.font = [UIFont systemFontOfSize:19];
        tipLabel.text = @"已经保存到相册";
        [[UIApplication sharedApplication].keyWindow addSubview:tipLabel];
        
        [UIView animateWithDuration:0.2 animations:^{
            tipLabel.transform = CGAffineTransformMakeTranslation(0, 60);
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    tipLabel.transform = CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                    [tipLabel removeFromSuperview];
                    tipLabel = nil;
                }];
            });
        }];
    }

}






































@end
