//
//  CourseItem.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


static NSString *item_CourseItem = @"CourseItem";
@interface CourseItem : UICollectionViewCell

- (void)modifyItemWithData:(NSString *)txt;

@end

NS_ASSUME_NONNULL_END
