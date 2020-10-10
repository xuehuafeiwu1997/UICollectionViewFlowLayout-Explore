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
    
    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    CGSize firstCellSize = [self.delegate sizeForFirstCell];
    CGRect firstCellFrame = CGRectMake(sectionInsets.left, sectionInsets.top, firstCellSize.width, firstCellSize.height);
    
}

/*
 获取所有的布局信息
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalArr = [super layoutAttributesForElementsInRect:rect];
    UICollectionViewLayoutAttributes *attributes = originalArr.firstObject;
    self.originCenterX = attributes.center.x;
    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    CGSize firstCellSize = [self.delegate sizeForFirstCell];
    CGRect firstCellFrame = CGRectMake(sectionInsets.left, sectionInsets.top, firstCellSize.width, firstCellSize.height);
//    attributes.frame = firstCellFrame;
//    self.offsetX = attributes. - self.originCenterX;
    self.offsetX = firstCellFrame.size.width - attributes.size.width;
    for (UICollectionViewLayoutAttributes *attributes in originalArr) {
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

@end
