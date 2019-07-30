//
//  GridCollectionView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GridCollectionViewSelectedBlock)(NSIndexPath *idx);
@interface GridCollectionView : UIView

@property (nonatomic,copy)  GridCollectionViewSelectedBlock gcvSelectedBlock;

@end

NS_ASSUME_NONNULL_END
