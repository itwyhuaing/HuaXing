//
//  JXDateManager.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/6.
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

- (NSString *)getCurrentTime {
    NSString *rlt;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger hour = [comps hour];
    NSInteger min  = [comps minute];
    if (min <= 9) {
        rlt = [NSString stringWithFormat:@"%ld:0%ld",hour,min];
    }else {
        rlt = [NSString stringWithFormat:@"%ld:%ld",hour,min];
    }
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


-(NSString *)getChineseCalendarWithDate:(NSString *)date {
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子",@"乙丑",@"丙寅",@"丁卯",@"戊辰",@"己巳",@"庚午",@"辛未",@"壬申",@"癸酉",
                             @"甲戌",@"乙亥",@"丙子",@"丁丑",@"戊寅",@"己卯",@"庚辰",@"辛己",@"壬午",@"癸未",
                             @"甲申",@"乙酉",@"丙戌",@"丁亥",@"戊子",@"己丑",@"庚寅",@"辛卯",@"壬辰",@"癸巳",
                             @"甲午",@"乙未",@"丙申",@"丁酉",@"戊戌",@"己亥",@"庚子",@"辛丑",@"壬寅",@"癸丑",
                             @"甲辰",@"乙巳",@"丙午",@"丁未",@"戊申",@"己酉",@"庚戌",@"辛亥",@"壬子",@"癸丑",
                             @"甲寅",@"乙卯",@"丙辰",@"丁巳",@"戊午",@"己未",@"庚申",@"辛酉",@"壬戌",@"癸亥", nil];
    NSArray *chineseMonths = [NSArray arrayWithObjects:
                              @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月", nil];
    NSArray *chineseDays = [NSArray arrayWithObjects:@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",
                            @"十二",@"十三",@"十四",@"十五", @"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    NSDate  *dateTemp = nil;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    dateTemp = [dateFormater dateFromString:date];
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *localeComp = [localeCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateTemp];
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    NSString *Cz_str = nil;
    if([y_str hasSuffix:@"子"]){
        Cz_str =@"鼠";
        
    }else if([y_str hasSuffix:@"丑"]){
        Cz_str =@"牛";
        
    }else if([y_str hasSuffix:@"寅"]){
        Cz_str =@"虎";
        
    }else if([y_str hasSuffix:@"卯"]){
        Cz_str =@"兔";
        
    }else if([y_str hasSuffix:@"辰"]){
        Cz_str =@"龙";
        
    }else if([y_str hasSuffix:@"巳"]){
        Cz_str =@"蛇";
        
    }else if([y_str hasSuffix:@"午"]){
        Cz_str =@"马";
        
    }else if([y_str hasSuffix:@"未"]){
        Cz_str =@"羊";
        
    }else if([y_str hasSuffix:@"申"]){
        Cz_str =@"猴";
        
    }else if([y_str hasSuffix:@"酉"]){
        Cz_str =@"鸡";
        
    }else if([y_str hasSuffix:@"戌"]){
        Cz_str =@"狗";
        
    }else if([y_str hasSuffix:@"亥"]){
        Cz_str =@"猪";
        
    }
    NSString *chineseCal_str = [NSString stringWithFormat:@"%@(%@)年 %@%@",y_str,Cz_str,m_str,d_str];
    return chineseCal_str;
}


@end
