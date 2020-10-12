//
//  FirstCellZoomInLayout.h
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/10/9.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FirstCellZoomInLayoutDelegate <UICollectionViewDelegateFlowLayout>

- (CGSize)sizeForFirstCell;

@end

@interface FirstCellZoomInLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<FirstCellZoomInLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
