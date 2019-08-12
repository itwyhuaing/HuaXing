//
//  CourseConfigVC.h
//  HuaXing
//
//  Created by hxwyh on 2019/7/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class CourseConfigVC;
@protocol CourseConfigVCDelegate <NSObject>
@optional
- (void)courseConfigVC:(CourseConfigVC *)vc selectedTheStartDate:(NSString *)startDateString;

- (void)courseConfigVC:(CourseConfigVC *)vc amCourseMax:(NSInteger)aMax;

- (void)courseConfigVC:(CourseConfigVC *)vc pmCourseMax:(NSInteger)pMax;

- (void)courseConfigVC:(CourseConfigVC *)vc amTimeTxt:(NSString *)time rowIndex:(NSInteger)idx;

- (void)courseConfigVC:(CourseConfigVC *)vc pmTimeTxt:(NSString *)time rowIndex:(NSInteger)idx;

@end


@interface CourseConfigVC : HXBaseVC

@property (nonatomic,weak) id <CourseConfigVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
