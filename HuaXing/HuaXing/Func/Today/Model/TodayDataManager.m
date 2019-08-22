//
//  TodayDataManager.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TodayDataManager.h"
#import "TodayNoteModel.h"

@implementation TodayDataManager

-(NSArray *)orderedByTimeWithDataSource:(NSArray<TodayNoteModel *> *)dataSource {
    /*
     xx:xx
     00/24 - 23
     
     00 - 59
     */
    NSMutableArray *rlt= [NSMutableArray new];
    if (dataSource) {
        
        for (NSInteger cou = 0; cou < dataSource.count; cou ++) {
            
            TodayNoteModel *f   = dataSource[cou];
            NSString *f_time    = f.time;
            TodayNoteModel *min = f;
            
            
            for (NSInteger next = cou+1; next < dataSource.count; next ++) {
                TodayNoteModel *n   = dataSource[next];
                NSString *n_time    = n.time;
                
                NSArray *f_arr = [f_time componentsSeparatedByString:@":"];
                NSArray *n_arr = [n_time componentsSeparatedByString:@":"];
                
                NSString *f_arr_first = [f_arr firstObject];
                NSString *f_arr_last  = [f_arr lastObject];
                
                NSString *n_arr_first = [n_arr firstObject];
                NSString *n_arr_last = [n_arr lastObject];
                
                if (f_arr_first.integerValue < n_arr_first.integerValue) {
                    min = f;
                }else if (f_arr_first.integerValue > n_arr_first.integerValue){
                    min = n;
                }else {
                    if (f_arr_last.integerValue < n_arr_last.integerValue) {
                        min = f;
                    }else if (f_arr_last.integerValue > n_arr_last.integerValue){
                        min = n;
                    }else{
                        min = f;
                    }
                }
                
            }
            
            [rlt addObject:min];
            
        }
        
    }
    return rlt;
}


@end
