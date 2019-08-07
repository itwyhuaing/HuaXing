//
//  JXDateManager.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/6.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "JXDateManager.h"

@implementation JXDateManager

+ (instancetype)shareInstance {
    static JXDateManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JXDateManager alloc] init];
    });
    return instance;
}

-(NSString *)getCurrentDate {
    NSString *rlt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat_ymd];
    rlt = [formatter stringFromDate:[NSDate date]];
    return rlt;
}

- (NSString *)getTheYearWithDateString:(NSString *)dateStr {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = dateFormat_ymd;
    NSDate *start = [matter dateFromString:dateStr];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
    NSInteger year = [comps year];
    return [NSString stringWithFormat:@"%ld",year];
    
}

- (NSString *)getMonthFirstDayWithDateString:(NSString *)dateStr {
    NSString *rlt;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:dateFormat_ymd];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDate interval:&interval forDate:newDate];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:dateFormat_ymd];
    rlt = [myDateFormatter stringFromDate:firstDate];
    return rlt;
}

- (NSString *)getMonthLastDayWithDateString:(NSString *)dateStr {
    NSString *rlt;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:dateFormat_ymd];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDate interval:&interval forDate:newDate];
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:dateFormat_ymd];
    rlt = [myDateFormatter stringFromDate:lastDate];
    return rlt;
}

- (NSArray *)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate dateFormat:(nonnull NSString *)dateFormat{
    
    NSMutableArray *rlt = [NSMutableArray new];
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = dateFormat_ymd;
    NSDate *start = [matter dateFromString:startDate];
    NSDate *end = [matter dateFromString:endDate];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        
        // 添加其他
        matter.dateFormat = dateFormat ? dateFormat : dateFormat_ymd;
        NSString *theDateString = [matter stringFromDate:start];
        [rlt addObject:theDateString];
        //NSLog(@"\n  循环计算 : \n %@ - %@ \n",start,theDateString);
        
        //后一天
        [comps setDay:([comps day]+1)];
        start = [calendar dateFromComponents:comps];
        //对比日期大小
        result = [start compare:end];
    }
    return rlt;
}


- (NSArray *)getWeekDaysWithStartDate:(NSString *)startDate endDate:(NSString *)endDate {
    
    NSMutableArray *rlt = [NSMutableArray new];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = dateFormat_ymd;
    NSDate *start = [matter dateFromString:startDate];
    NSDate *end = [matter dateFromString:endDate];
    
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        
        // 提取 今天是星期 X
        NSInteger weekday = [comps weekday];
        [rlt addObject:[self weekDateNormalWithInteger:weekday]];
        
        //后一天
        [comps setDay:([comps day]+1)];
        start = [calendar dateFromComponents:comps];
        //对比日期大小
        result = [start compare:end];
    }
    return rlt;
}

- (NSString *)weekDateNormalWithInteger:(NSInteger)integer{
    NSString *rlt = @"周一";
    if (integer == 1) {
        rlt = @"周日";
    }else if (integer == 2) {
        rlt = @"周一";
    }else if (integer == 3) {
        rlt = @"周二";
    }else if (integer == 4) {
        rlt = @"周三";
    }else if (integer == 5) {
        rlt = @"周四";
    }else if (integer == 6) {
        rlt = @"周五";
    }else if (integer == 7) {
        rlt = @"周六";
    }
    return rlt;
}

@end
