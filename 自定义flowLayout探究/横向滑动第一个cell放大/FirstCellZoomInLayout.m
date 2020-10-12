//
//  FirstCellZoomInLayout.m
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/10/9.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "FirstCellZoomInLayout.h"

@interface FirstCellZoomInLayout()

@property (nonatomic) CGFloat originCenterX;
@property (nonatomic) CGFloat offsetX;


@end

@implementation FirstCellZoomInLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置滑动方向为水平滑动
}

/*
 获取所有的布局信息
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalArr = [super layoutAttributesForElementsInRect:rect];
    UICollectionViewLayoutAttributes *attributes = originalArr.firstObject;
    self.originCenterX = attributes.center.x;
    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGSize firstCellSize = [self.delegate sizeForFirstCell];
    CGRect firstCellFrame = CGRectMake(sectionInsets.left, sectionInsets.top, firstCellSize.width, firstCellSize.height);
//    attributes.frame = firstCellFrame;
    self.offsetX = firstCellFrame.size.width - attributes.size.width;
//    //下面的解决思路是 计算每个的偏移量和大小 都重新赋值
    for (UICollectionViewLayoutAttributes *attributes in originalArr) {
        //这样写有问题，在滑动到最右边时，originalArr只是显示在屏幕上的cell的集合，所以滑动到最右边时界面上显示的第一个会被放大
        if (attributes == originalArr.firstObject) {
            attributes.size = CGSizeMake(firstCellSize.width, firstCellSize.height);
            attributes.center = CGPointMake(attributes.center.x + self.offsetX / 2, attributes.center.y);
            continue;
        }
        attributes.size = CGSizeMake(attributes.size.width, attributes.size.height);
        attributes.center = CGPointMake(attributes.center.x + self.offsetX, attributes.center.y);
    }
    return originalArr;
}

//这句话一定要加，如果不加的话，滑动的过程中可能会出现一些地方的cell缺失或者大小异常
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
