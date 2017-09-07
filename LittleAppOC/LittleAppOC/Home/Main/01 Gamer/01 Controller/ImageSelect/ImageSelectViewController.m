//
//  ImageSelectViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/9/6.
//  Copyright © 2017年 CYC. All rights reserved.
//

// 图片选取

#import "ImageSelectViewController.h"
#import "ImageSelectViewCell.h"
#import "PhotoScrollView.h"

@interface ImageSelectViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageSelectViewCellDelegate, PhotoScrollViewDeletage> {

    UICollectionView *_listCollectionView;
    NSMutableArray *_images;
    
    // 单元格编辑状态
    BOOL _editCell;
    
    // 导航栏右边的按钮
    UIButton *_rightItem;

}

@property (strong, nonatomic) UIImageView *fadeImageView;   // 显示大图前，用来做动画的假象
@property (strong, nonatomic) PhotoScrollView *photoView;   // 展示大图
@property (strong, nonatomic) UICollectionViewCell *selectCell; // 标志选中的cell

@end

@implementation ImageSelectViewController







#pragma mark ========================================控制器生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _images = [NSMutableArray array];
    _editCell = NO;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    title.text = @"照片";
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
    
    // 导航栏右边的添加按钮
    _rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightItem setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightItem setTintColor:[UIColor whiteColor]];
    _rightItem.frame = CGRectMake(0, 0, 40, 22);
    [_rightItem addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:_rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth * 0.25, kScreenWidth * 0.25);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)
                                             collectionViewLayout:layout];
    _listCollectionView.backgroundColor = [UIColor clearColor];
    _listCollectionView.alwaysBounceVertical = YES;
    [_listCollectionView registerNib:[UINib nibWithNibName:@"ImageSelectViewCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"ImageSelectViewCell"];
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    [self.view addSubview:_listCollectionView];
    
    // 获取沙河中的image
    [self getImages];
    
    
    
}

- (void)dealloc {

    //获取沙盒路径，
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:Documents_Picture];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //把图片转换为Base64的字符串
    for (UIImage *image in _images) {
        NSData *_data = UIImageJPEGRepresentation(image, 1.0f);
        
        NSString *_encodedImageStr = [_data base64Encoding];
        
        [arr addObject:_encodedImageStr];
    }
    
    
    //写入plist文件
    if ([arr writeToFile:newPath atomically:YES]) {
        NSLog(@"写入成功");
    };

}


#pragma mark ========================================私有方法=============================================

#pragma mark - 获取沙盒中的照片
- (void)getImages {

    //获取沙盒路径，
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:Documents_Picture];
    //获取plist
    NSArray *imageArray = [NSArray arrayWithContentsOfFile:newPath];
    if (imageArray != nil) {
        
        // 解析图片，存到数组中
        for (NSString *imageStr in imageArray) {
            NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:imageStr];
            UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
            [_images addObject:_decodedImage];
            
        }
        
    }
    [_listCollectionView reloadData];

}


#pragma mark - 懒加载
- (PhotoScrollView *)photoView {

    if (_photoView == nil) {
        _photoView = [[PhotoScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _photoView.photoDelegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:_photoView];
    }
    return _photoView;

}

- (UIImageView *)fadeImageView {

    if (_fadeImageView == nil) {
        _fadeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _fadeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [[UIApplication sharedApplication].keyWindow addSubview:_fadeImageView];
    }
    return _fadeImageView;

}

#pragma mark ========================================动作响应=============================================

#pragma mark - 导航栏右边按钮响应
- (void)rightItemAction:(UIButton *)button {
    
    if (_images.count == 0) {
        return;
    }
    
    _editCell = !_editCell;
    
    [_listCollectionView reloadData];
    
    if (_editCell) {
        [_rightItem setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        [_rightItem setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    
}



#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _images.count + 1;

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ImageSelectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageSelectViewCell" forIndexPath:indexPath];
    
    if (_images.count == 0) {
        
        // +
        cell.iconImageView.image = [UIImage imageNamed:@"icon_gamer_image_add"];
        cell.delegate = nil;
        
    } else {
        
        if (indexPath.item == _images.count) {
            // +
            cell.iconImageView.image = [UIImage imageNamed:@"icon_gamer_image_add"];
            cell.delegate = nil;
            
        } else {
            
            // 显示照片
            UIImage *image = _images[indexPath.item];
            cell.iconImageView.image = image;
            cell.ani = _editCell;
            cell.delegate = self;
            
        }
        
    }
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.item == _images.count) {
        if (_editCell) {
            // 正在编辑状态，则先停止编辑
            _editCell = NO;
            [collectionView reloadData];
            
            // 修改导航栏右边按钮的状态
            [_rightItem setTitle:@"编辑" forState:UIControlStateNormal];
            
        } else {
            
            
            // 弹框提示是否执行
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"来自相机"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        // 弹出选取照片
                                                        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                                                        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                        imagePicker.delegate = self;
                                                        [self presentViewController:imagePicker animated:YES completion:^{
                                                            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                                                        }];
                                                    }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"从相册中获取"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        // 弹出选取照片
                                                        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                                                        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                                                        imagePicker.delegate = self;
                                                        [self presentViewController:imagePicker animated:YES completion:^{
                                                            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                                                        }];
                                                    }]];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                           }];
            [alert addAction:action];
            [action setValue:[UIColor redColor] forKey:@"titleTextColor"];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
    } else {
        if (_editCell) {
            // 编辑状态删除图片
            [_images removeObjectAtIndex:indexPath.item];
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];  // 有动画，比较好看
            
            if (_images.count == 0) {
                
                // 退出编辑状态
                _editCell = NO;
                
                // 修改导航栏右边按钮的状态
                [_rightItem setTitle:@"编辑" forState:UIControlStateNormal];
            }
            
        } else {
            // 非编辑状态，查看大图
            // 动画:
            //      1、单元格隐藏
            //      2、假象从单元格出发，前往屏幕中部，然后放大到全屏
            //      3、直接全屏显示要查看的大图
            //      4、隐藏假象
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            cell.alpha = 0;
            _selectCell = cell;
            CGRect rect = [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
            
            self.fadeImageView.frame = rect;
            _fadeImageView.image = _images[indexPath.item];
            
            self.photoView.imageObj = _images[indexPath.item];
            _photoView.alpha = 0;
            
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _fadeImageView.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);

                             } completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.2
                                                  animations:^{
                                                      _fadeImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);

                                                  } completion:^(BOOL finished) {
                                                      [UIView animateWithDuration:0.2
                                                                       animations:^{
                                                                           _photoView.alpha = 1;
                                                                       } completion:^(BOOL finished) {
                                                                           _fadeImageView.alpha = 0;
                                                                       }];
                                                  }];
                             }];
        }
    }

}

#pragma mark - 选取了照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    [_images addObject:selectImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [_listCollectionView reloadData];
    }];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

#pragma mark - 取消选取照片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - 长按单元格响应
- (void)longPressCellAction {
    
    if (_editCell) {
        // 如果已经在编辑状态，不做修改
    } else {
        // 开始编辑单元格
        _editCell = YES;
        [_listCollectionView reloadData];
        
        // 修改导航栏右边的完成按钮状态
        [_rightItem setTitle:@"完成" forState:UIControlStateNormal];
    }

    

}

#pragma mark - 单击了查看大图
- (void)singleTagAction {

    // 隐藏大图
    // 动画
    //      1、显示假象，隐藏大图
    //      2、假象缩小成单元格，移到单元格位置
    //      3、显示单元格，隐藏假象
    
    CGRect rect = [_selectCell convertRect:_selectCell.bounds toView:[UIApplication sharedApplication].keyWindow];
    _fadeImageView.alpha = 1;
    [UIView animateWithDuration:0.2 animations:^{
        _photoView.alpha = 0;
    } completion:^(BOOL finished) {
        [_photoView removeFromSuperview];
        _photoView = nil;
        [UIView animateWithDuration:0.2 animations:^{
            _fadeImageView.frame = CGRectMake((kScreenWidth - kScreenWidth * 0.25) * 0.5,
                                              (kScreenHeight - kScreenWidth * 0.25) * 0.5,
                                              kScreenWidth * 0.25,
                                              kScreenWidth * 0.25);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                _fadeImageView.frame = rect;
            } completion:^(BOOL finished) {
                _selectCell.alpha = 1;
                
                [_fadeImageView removeFromSuperview];
                _fadeImageView = nil;
            }];
        }];
    }];

}

#pragma mark ========================================通知================================================
#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}



































@end
