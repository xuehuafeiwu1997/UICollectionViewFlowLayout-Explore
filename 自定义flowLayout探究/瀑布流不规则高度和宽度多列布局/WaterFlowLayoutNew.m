//
//  WaterFlowLayoutNew2.m
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/10/12.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "WaterFlowLayoutNew.h"

@interface WaterFlowLayoutNew()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *itemAttributes;
@property (nonatomic) CGFloat xOffset;
@property (nonatomic) CGFloat yOffset;
@property (nonatomic) NSInteger perLineCount;

@end

@implementation WaterFlowLayoutNew

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemAttributes = [NSMutableArray array];
    self.xOffset = 0;
    self.yOffset = 0;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    self.xOffset = sectionInsets.left;
    self.yOffset = sectionInsets.top;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    NSInteger count = floor (self.collectionView.bounds.size.width - sectionInsets.left - sectionInsets.right + self.minimumInteritemSpacing) / (size.width + self.minimumInteritemSpacing);
    self.perLineCount = count;
    NSMutableArray *yOffsetArray = [NSMutableArray arrayWithCapacity:self.perLineCount];
    for (int i = 0; i < itemCount;i++) {
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (self.xOffset + sectionInsets.right + itemSize.width <= self.collectionView.bounds.size.width) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (yOffsetArray.count == self.perLineCount) {
                 self.yOffset = [[yOffsetArray objectAtIndex:(i % self.perLineCount)] floatValue] + self.minimumLineSpacing;
            }
            attributes.frame = CGRectMake(self.xOffset, self.yOffset, itemSize.width, itemSize.height);
            [self.itemAttributes addObject:attributes];
            self.xOffset = self.xOffset + itemSize.width + self.minimumInteritemSpacing;
            if (yOffsetArray.count < self.perLineCount) {
                [yOffsetArray addObject:@(self.yOffset + itemSize.height)];
            } else {
                [yOffsetArray replaceObjectAtIndex:(i % self.perLineCount) withObject:@(self.yOffset + itemSize.height)];
            }
        } else {
            self.xOffset = sectionInsets.left;
            self.yOffset = [[yOffsetArray objectAtIndex:(i % self.perLineCount)] floatValue] + self.minimumLineSpacing;
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            attributes.frame = CGRectMake(self.xOffset, self.yOffset, itemSize.width, itemSize.height);
            [self.itemAttributes addObject:attributes];
            self.xOffset = self.xOffset + itemSize.width + self.minimumInteritemSpacing;
            self.yOffset = self.yOffset + itemSize.height;
            [yOffsetArray replaceObjectAtIndex:(i % self.perLineCount) withObject:@(self.yOffset)];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.bounds.size.width, self.yOffset);
}

@end
