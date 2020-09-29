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

@end

@implementation WaterFlowLayoutNew

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemAttributes = [NSMutableArray array];
    self.xOffset = 0;
    self.yOffset = 0;
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    
}



@end
