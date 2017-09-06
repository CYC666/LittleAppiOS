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

@interface ImageSelectViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

    UICollectionView *_listCollectionView;
    NSMutableArray *_images;

}

@end

@implementation ImageSelectViewController







#pragma mark ========================================控制器生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _images = [NSMutableArray array];
    
    
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
    
    
    
    
    
}


#pragma mark ========================================私有方法=============================================

#pragma mark ========================================动作响应=============================================

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
        
    } else {
        
        if (indexPath.item == _images.count) {
            // +
            cell.iconImageView.image = [UIImage imageNamed:@"icon_gamer_image_add"];
            
        } else {
            
            // 显示照片
            UIImage *image = _images[indexPath.item];
            cell.iconImageView.image = image;
            
        }
        
    }
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.item == _images.count) {
        // 弹出选取照片
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        // 查看照片
    }

}

#pragma mark - 选取了照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    [_images addObject:selectImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [_listCollectionView reloadData];
    }];

}

#pragma mark ========================================通知================================================
#pragma mark - 主题改变，修改背景颜色
- (void)changeBackgroundColor:(NSNotification *)notification {
    
    self.view.backgroundColor = CTHEME.themeColor;
    
}



































@end
