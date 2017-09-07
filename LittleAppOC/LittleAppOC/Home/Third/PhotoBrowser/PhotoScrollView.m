//
//  PhotoScrollView.m
//  WXMovie
//
//  Created by mR yang on 16/7/20.
//  Copyright © 2016年 mR yang. All rights reserved.
//

#import "PhotoScrollView.h"
#import "UIImageView+WebCache.h"

@interface PhotoScrollView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UILabel *tipLabel;


@end

@implementation PhotoScrollView
/**
 1.放大缩小效果
 2.添加点击手势
 3.添加空隙
 */
-(instancetype)initWithFrame:(CGRect)frame{
  
  if (self=[super initWithFrame:frame]) {
    
    //    创建用于浏览的图片视图
    [self creatImageView];

    //    设置代理对象
    self.delegate=self;

    //    设置背景颜色
      self.backgroundColor = [UIColor blackColor];
      
    //    UISwipeGestureRecognizer 轻扫手势
    
    //    点击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];

    //    手指个数
    tap.numberOfTouchesRequired=1;

    //    手指点击次数
    tap.numberOfTapsRequired=1;

    //    添加手势
    [self addGestureRecognizer:tap];
      
      
    //    点击手势
    UITapGestureRecognizer *doublTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapGesture:)];

    //    手指个数
    doublTap.numberOfTouchesRequired=1;

    //    手指点击次数
    doublTap.numberOfTapsRequired=2;

    //    添加手势
    [self addGestureRecognizer:doublTap];
      
      
    //    长按手势
      UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageAction:)];
      longPress.minimumPressDuration = 1;
      [self addGestureRecognizer:longPress];
    
  }
  
  return self;
}

-(void)tapGesture:(UITapGestureRecognizer *)tap{
  
    [self performSelector:@selector(tapAction) withObject:nil afterDelay:0.25];
  
}

- (void)doubleTapGesture:(UITapGestureRecognizer *)tap {

    // 取消单击挂起执行的方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tapAction) object:nil];
    
    //  当前缩放的倍数
    CGFloat scale=self.zoomScale>1?1:2;
    
    //  进行缩放
    [self setZoomScale:scale animated:YES];

}

#pragma mark - 单击执行
- (void)tapAction {

    if ([_photoDelegate respondsToSelector:@selector(singleTagAction)]) {
        [_photoDelegate singleTagAction];
    }

}

#pragma mark - 长按保存相片
- (void)saveImageAction:(UILongPressGestureRecognizer *)press {

    if (press.state == UIGestureRecognizerStateBegan) {
        UIImageWriteToSavedPhotosAlbum(_imageObj, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }

}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        self.tipLabel.text = @"已将图片保存到手机相册";
    }
}

-(void)creatImageView{
  
    _imageV=[[UIImageView alloc]initWithFrame:self.bounds];
  
//  设置图片填充模式
  
    _imageV.contentMode=UIViewContentModeScaleAspectFit;
  
//  打开用户交互
    _imageV.userInteractionEnabled=YES;
  
    [self addSubview:_imageV];
  
//  最大放大比例
    self.maximumZoomScale=2;
  
//  最小缩小比例
    self.minimumZoomScale=1;
}

-(void)setImageURL:(NSString *)imageURL{
 
  _imageURL=imageURL;
  
  
//  给图片设置数据
  [_imageV sd_setImageWithURL:[NSURL URLWithString:_imageURL]];
  
}

- (void)setImageObj:(UIImage *)imageObj {

    _imageObj = imageObj;
    
    _imageV.image = imageObj;

}


//返回缩放视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  
  return _imageV;
}


- (UILabel *)tipLabel {

    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont boldSystemFontOfSize:19];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.numberOfLines = 0;
        [self addSubview:_tipLabel];
        [self bringSubviewToFront:_tipLabel];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        _tipLabel.text = @"";
    }];
    
    return _tipLabel;

}







































@end
