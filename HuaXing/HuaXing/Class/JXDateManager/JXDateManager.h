//
//  JXDateManager.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/6.
//  Copyright © 2019 HuaXing. All rights reserved.
//

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

- (NSString *)getTheYearWithDateString:(NSString *)dateStr;

- (NSString *)getMonthFirstDayWithDateString:(NSString *)dateStr;

- (NSString *)getMonthLastDayWithDateString:(NSString *)dateStr;

- (NSArray *)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate dateFormat:(NSString *)dateFormat;

- (NSArray *)getWeekDaysWithStartDate:(NSString *)startDate endDate:(NSString *)endDate;

@end

NS_ASSUME_NONNULL_END
