//
//  WaterFlowLayout.m
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/9/29.
//  Copyright © 2020 许明洋. All rights reserved.
//这种实现有缺陷，不足之处在于这种写法是默认只会有两列，如果是多列的情况下，不适用

#import "WaterFlowLayout.h"

@interface WaterFlowLayout()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *itemAttributes;
@property (nonatomic) CGFloat xOffset;
@property (nonatomic) CGFloat yOffset;
@property (nonatomic) CGFloat maxOddY;//奇数时的y
@property (nonatomic) CGFloat maxEvenY;//偶数时的y

@end

@implementation WaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    //竖直方向滚动
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemAttributes = [NSMutableArray array];
    self.xOffset = 0;
    self.yOffset = 0;
    self.maxOddY = 0;
    self.maxEvenY = 0;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSLog(@"当前的大小为%f,%f",self.minimumLineSpacing,self.minimumInteritemSpacing);
    UIEdgeInsets sectionEdgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    self.xOffset = sectionEdgeInsets.left;
    self.yOffset = sectionEdgeInsets.top;
    self.maxOddY = self.yOffset;
    self.maxEvenY = self.yOffset;

    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        if (i % 2 == 0) {
            self.xOffset = sectionEdgeInsets.left;
            self.yOffset = self.maxEvenY;
        } else {
            self.xOffset = sectionEdgeInsets.left + itemSize.width + self.minimumInteritemSpacing;
            self.yOffset = self.maxOddY;
        }
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(self.xOffset, self.yOffset, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attributes];

        if (i % 2 == 0) {
            self.maxEvenY = self.maxEvenY + itemSize.height +
            self.minimumLineSpacing;
            
        } else {
            self.maxOddY = self.maxOddY + itemSize.height + self.minimumLineSpacing;
        }
    }
}

- (CGSize)collectionViewContentSize {
    float height = MAX(self.maxOddY, self.maxEvenY);
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributes;
}

@end
