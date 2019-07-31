//
//  CourseCollectionCell.h
//  HuaXing
//
//  Created by wangyinghua on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface CourseCollectionCell : UICollectionViewCell

@property (nonatomic,strong) CourseItemModel *model;

@end

NS_ASSUME_NONNULL_END
