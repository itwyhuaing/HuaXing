//
//  CourseConfigVC.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class CourseConfigVC;
@protocol CourseConfigVCDelegate <NSObject>
@optional
- (void)courseConfigVC:(CourseConfigVC *)vc selectedTheStartDate:(NSString *)startDateString;

- (void)courseConfigVC:(CourseConfigVC *)vc amCourseMax:(NSInteger)aMax pmCourseMax:(NSInteger)pMax;

- (void)courseConfigVC:(CourseConfigVC *)vc amTimeTxt:(NSString *)time rowIndex:(NSInteger)idx;

- (void)courseConfigVC:(CourseConfigVC *)vc pmTimeTxt:(NSString *)time rowIndex:(NSInteger)idx;

@end


@interface CourseConfigVC : HXBaseVC

@property (nonatomic,weak) id <CourseConfigVCDelegate> delegate;

@property (nonatomic,copy) NSString *lastSelectedDateString;

@property (nonatomic,copy) NSString *lastSelectedAMax;

@property (nonatomic,copy) NSString *lastSelectedPMax;

@end

NS_ASSUME_NONNULL_END
