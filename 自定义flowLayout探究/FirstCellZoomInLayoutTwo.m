//
//  FirstCellZoomInLayoutTwo.m
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/10/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "FirstCellZoomInLayoutTwo.h"

@interface FirstCellZoomInLayoutTwo()

@end

@implementation FirstCellZoomInLayoutTwo

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置滑动方向为水平滑动
}

/*
 获取所有的布局信息
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalArr = [super layoutAttributesForElementsInRect:rect];
    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGRect first = CGRectMake(sectionInsets.left + self.collectionView.contentOffset.x, sectionInsets.top + self.collectionView.contentOffset.y, itemSize.width, itemSize.height);
    CGSize firstCellSize = [self.delegate sizeForFirstCell];
    CGFloat totalOffset = 0;
    for (UICollectionViewLayoutAttributes *attributes in originalArr) {
        CGRect originFrame = attributes.frame;
        //判断两个矩形是否相交
        if (CGRectIntersectsRect(first, originFrame)) {
            //如果相交，获取两个矩形相交的区域
            CGRect insertRect = CGRectIntersection(first, originFrame);
            attributes.size = CGSizeMake(itemSize.width + (insertRect.size.width / itemSize.width) * (firstCellSize.width - itemSize.width), itemSize.height + (insertRect.size.width) / (itemSize.width) * (firstCellSize.height - itemSize.height));
            CGFloat currentOffsetX = attributes.size.width - itemSize.width;
            attributes.center = CGPointMake(attributes.center.x + totalOffset + currentOffsetX / 2, attributes.center.y);
            totalOffset = totalOffset + currentOffsetX;
        } else {
            if (CGRectGetMinX(originFrame) >= CGRectGetMaxX(first)) {
                attributes.center = CGPointMake(attributes.center.x + totalOffset, attributes.center.y);
            }
        }
    }
    return originalArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

//这个方法不会被调用
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
//    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
//    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    CGSize firstSize = [self.delegate sizeForFirstCell];
////    CGSize firstCellFrame = CGRectMake(proposedContentOffset.x , <#CGFloat y#>, <#CGFloat width#>,)
//    return proposedContentOffset;
//}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat adjustOffsetX = CGFLOAT_MAX;
    CGFloat finalPointX = 0;
    do {
        adjustOffsetX = finalPointX - proposedContentOffset.x;
        finalPointX += itemSize.width + self.minimumInteritemSpacing;
    } while (ABS(adjustOffsetX) > ABS(finalPointX - proposedContentOffset.x));
    CGPoint finalPoint = CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
    return finalPoint;
}

@end
