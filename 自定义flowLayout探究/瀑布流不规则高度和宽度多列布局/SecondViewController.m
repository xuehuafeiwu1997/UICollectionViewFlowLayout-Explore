//
//  SecondViewController.m
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/9/29.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"
#import "WaterFlowLayoutNew.h"

@interface SecondViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WaterFlowLayoutNewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *widthArray;//用于存储宽度数据
@property (nonatomic, strong) NSMutableArray *heightArray;//用于存储高度数据

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"瀑布流的多列自定义展示";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    WaterFlowLayoutNew *layout = [[WaterFlowLayoutNew alloc] init];
    layout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate/dataSource/flowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //点击效果不需要实现
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = [[self.widthArray objectAtIndex:indexPath.row] floatValue];
//    float width = self.view.bounds.size.width - 10 * 2 - 10 * 2;
    float height = [[self.heightArray objectAtIndex:indexPath.row] floatValue];
    return CGSizeMake(width , height);
}

- (NSMutableArray *)widthArray {
    if (_widthArray) {
        return _widthArray;
    }
    _widthArray = [NSMutableArray arrayWithObjects:@(50),@(100),@(150),@(200),@(150),@(100),@(85),@(100),@(50),@(100),nil];
    return _widthArray;
}

- (NSMutableArray *)heightArray {
    if (_heightArray) {
        return _heightArray;
    }
    _heightArray = [NSMutableArray arrayWithObjects:@(100),@(150),@(150),@(50),@(130),@(180),@(200),@(100),@(110),@(200), nil];
    return _heightArray;
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

@end
