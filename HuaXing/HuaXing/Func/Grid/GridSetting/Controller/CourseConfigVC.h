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
@required

/**
 课程开始日期

 @param vc 设置控制器
 @param startDateString 已设定的开课时间
 */
- (void)courseConfigVC:(CourseConfigVC *)vc selectedTheStartDate:(NSString *)startDateString;


/**
 上午最多几节课

 @param vc 设置控制器
 @param aMax 已设定的上午最多节数
 */
- (void)courseConfigVC:(CourseConfigVC *)vc amCourseMax:(NSInteger)aMax;


/**
 下午最多几节课
 
 @param vc 设置控制器
 @param pMax 已设定的下午最多节数
 */
- (void)courseConfigVC:(CourseConfigVC *)vc pmCourseMax:(NSInteger)pMax;

@optional


/**
 上午对应节的起至时间

 @param vc 设置控制器
 @param time 已设定的时间
 @param idx 第几节
 */
- (void)courseConfigVC:(CourseConfigVC *)vc amTimeTxt:(NSString *)time rowIndex:(NSInteger)idx;

/**
 下午对应节的起至时间
 
 @param vc 设置控制器
 @param time 已设定的时间
 @param idx 第几节
 */
- (void)courseConfigVC:(CourseConfigVC *)vc pmTimeTxt:(NSString *)time rowIndex:(NSInteger)idx;

@end


@interface CourseConfigVC : HXBaseVC

@property (nonatomic,weak) id <CourseConfigVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
