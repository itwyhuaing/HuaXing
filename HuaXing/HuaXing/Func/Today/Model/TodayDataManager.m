//
//  TodayDataManager.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TodayDataManager.h"

@implementation TodayDataManager

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
    NSDate*dateTemp = nil;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    dateTemp = [dateFormater dateFromString:date];
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:dateTemp];
    NSString*y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString*m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString*d_str = [chineseDays objectAtIndex:localeComp.day-1];
    NSString*Cz_str =nil;
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
    NSString *chineseCal_str = [NSString stringWithFormat:@"农历%@(%@)年%@%@",y_str,Cz_str,m_str,d_str];
    return chineseCal_str;
}


@end
