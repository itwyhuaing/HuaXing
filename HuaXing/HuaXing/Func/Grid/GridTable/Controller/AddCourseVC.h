//
//  AddCourseVC.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/1.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBaseVC.h"
@class CourseItemModel;

NS_ASSUME_NONNULL_BEGIN

@class AddCourseVC;
@protocol AddCourseVCDelegate <NSObject>
@optional
- (void)addCourseVC:(AddCourseVC *)vc didComposedModel:(CourseItemModel *)model;

@end

@interface AddCourseVC : HXBaseVC

@property (nonatomic,weak) id <AddCourseVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
