//
//  SequenceHeaderView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/1.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SequenceItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface SequenceHeaderView : UICollectionReusableView

@property (nonatomic,strong) SequenceItemModel *model;

@end

NS_ASSUME_NONNULL_END
