//
//  CourseConfigView.h
//  HuaXing
//
//  Created by wangyinghua on 2019/7/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CourseConfigView;
@protocol CourseConfigViewDelegate <NSObject>
@optional
- (void)courseConfigView:(CourseConfigView *)cv headerEventLocation:(NSInteger)location;

- (void)courseConfigView:(CourseConfigView *)cv didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface CourseConfigView : UIView


@property (nonatomic,weak) id <CourseConfigViewDelegate> delegate;

/**
 依据选择结果数字刷新 Table

 @param itemsCount 已选择的数字
 @param section section 区域
 */
- (void)updateTableWithCourseItems:(NSString *)itemsCount section:(NSInteger)section;


/**
 刷新头部信息

 @param them 主题
 @param msg 描述信息
 @param section section 区域
 */
- (void)updateHeaderViewWithThem:(nullable NSString *)them tipMessage:(NSString *)msg section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
