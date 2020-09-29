//
//  WaterFlowLayoutNew.h
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/9/29.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WaterFlowLayoutNewDelegate <UICollectionViewDelegateFlowLayout>


@end

@interface WaterFlowLayoutNew : UICollectionViewFlowLayout

@property (nonatomic, weak) id<WaterFlowLayoutNewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
