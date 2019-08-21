//
//  JXDateManager.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/6.
//  Copyright © 2019 HuaXing. All rights reserved.
//

/**
 2019.8.21 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *dateFormat_ymd = @"yyyy-MM-dd";
static NSString *dateFormat_ym  = @"yyyy-MM";
static NSString *dateFormat_md  = @"MM-dd";

static NSString *dateFormat_ymd_V = @"yyyy/MM/dd";
static NSString *dateFormat_ym_V  = @"yyyy/MM";
static NSString *dateFormat_md_V  = @"MM/dd";

@interface JXDateManager : NSObject

+ (instancetype)shareInstance;

- (NSString *)getCurrentDate;


/**
 获取当前时间 - 返回结果格式: xx:xx

 @return 返回当前设备系统时间
 */
- (NSString *)getCurrentTime;

- (NSString *)getTheYearWithDateString:(NSString *)dateStr;

- (NSString *)getMonthFirstDayWithDateString:(NSString *)dateStr;

- (NSString *)getMonthLastDayWithDateString:(NSString *)dateStr;

- (NSArray *)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate dateFormat:(NSString *)dateFormat;

- (NSArray *)getWeekDaysWithStartDate:(NSString *)startDate endDate:(NSString *)endDate;

@end

NS_ASSUME_NONNULL_END
