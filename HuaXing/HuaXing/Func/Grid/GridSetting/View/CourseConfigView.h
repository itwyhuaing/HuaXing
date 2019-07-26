//
//  CourseConfigView.h
//  HuaXing
//
//  Created by wangyinghua on 2019/7/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CourseConfigViewHeaderCourseDateLocation = 0,
    CourseConfigViewHeaderAMLocation,
    CourseConfigViewHeaderPMLocation,
    CourseConfigViewHeaderLocationCount
} CourseConfigViewHeaderLocation;


@class CourseConfigView;
@protocol CourseConfigViewDelegate <NSObject>
@optional
- (void)courseConfigView:(CourseConfigView *)cv headerEventLocation:(NSInteger)location;

- (void)courseConfigView:(CourseConfigView *)cv cellModel:(ItemTimeModel *)model didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

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


/**
 依据 cell 位置替换数据源，进而更新 Table

 @param model 新的数据模型
 @param indexPath cell 位置
 */
- (void)updateTableWithItemModel:(ItemTimeModel *)model cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
