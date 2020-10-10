//
//  FirstCellZoomInLayoutTwo.h
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/10/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FirstCellZoomInLayoutTwoDelegate <UICollectionViewDelegateFlowLayout>

- (CGSize)sizeForFirstCell;

@end

@interface FirstCellZoomInLayoutTwo : UICollectionViewFlowLayout

@property (nonatomic, weak) id<FirstCellZoomInLayoutTwoDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
