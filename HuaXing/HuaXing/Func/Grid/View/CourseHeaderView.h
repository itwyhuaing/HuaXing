//
//  CourseHeaderView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HeaderViewClickEventBlock)();
@interface CourseHeaderView : UIView

@property (nonatomic,copy) HeaderViewClickEventBlock headerEventBlock;

- (void)updateContentWithThem:(nullable NSString *)them tipMessage:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
