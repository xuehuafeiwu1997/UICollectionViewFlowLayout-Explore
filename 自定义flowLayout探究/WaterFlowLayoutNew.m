//
//  WaterFlowLayoutNew.m
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/9/29.
//  Copyright © 2020 许明洋. All rights reserved.
//适于用可以多列展示时的瀑布流

#import "WaterFlowLayoutNew.h"

@interface WaterFlowLayoutNew()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *itemAttributes;
@property (nonatomic) CGFloat xOffset;
@property (nonatomic) CGFloat yOffset;
@property (nonatomic) CGFloat maxY;

@end

@implementation WaterFlowLayoutNew

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemAttributes = [NSMutableArray array];
    self.xOffset = 0;
    self.yOffset = 0;
    self.maxY = 0;
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        NSInteger itemsCount = [self.collectionView numberOfItemsInSection:i];
        UIEdgeInsets sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i];
        self.xOffset = sectionInsets.left;
        self.yOffset = sectionInsets.top;
        self.maxY = self.yOffset;
        NSMutableArray *heightArray = [NSMutableArray array];
        for (int j = 0; j < itemsCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            [heightArray addObject:@(itemSize.height)];
            NSInteger perLineCount = floorf((self.collectionView.bounds.size.width - sectionInsets.left - sectionInsets.right + self.minimumInteritemSpacing) / (itemSize.width + self.minimumInteritemSpacing));
            if (self.xOffset + sectionInsets.right + itemSize.width <= self.collectionView.bounds.size.width) {
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                attributes.frame = CGRectMake(self.xOffset, self.yOffset, itemSize.width, itemSize.height);
                [self.itemAttributes addObject:attributes];
                self.xOffset = self.xOffset + itemSize.width + self.minimumInteritemSpacing;
                self.maxY = MAX(self.maxY,itemSize.height);
            } else {
                self.xOffset = sectionInsets.left;
                self.yOffset = self.yOffset + self.minimumLineSpacing + self.maxY;
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                attributes.frame = CGRectMake(self.xOffset, self.yOffset, itemSize.width, itemSize.height);
                [self.itemAttributes addObject:attributes];
            }
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributes;
}

@end
