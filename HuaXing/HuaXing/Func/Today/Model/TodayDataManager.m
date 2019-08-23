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
        [rlt addObjectsFromArray:dataSource];
        for (NSInteger cou = 0; cou < rlt.count; cou ++) {
            
            NSInteger      min_location = cou;
            TodayNoteModel *min_model   = rlt[min_location];
            NSString       *min_time    = min_model.time;
            
            
            // 查找当前余下数据项中的最小值
            for (NSInteger next = cou+1; next < rlt.count; next ++) {
                TodayNoteModel *n_model   = rlt[next];
                NSString *n_time          = n_model.time;
                
                NSArray *f_arr = [min_time componentsSeparatedByString:@":"];
                NSArray *n_arr = [n_time componentsSeparatedByString:@":"];
                
                NSString *f_arr_first = [f_arr firstObject];
                NSString *f_arr_last  = [f_arr lastObject];
                
                NSString *n_arr_first = [n_arr firstObject];
                NSString *n_arr_last = [n_arr lastObject];

                if (f_arr_first.integerValue < n_arr_first.integerValue) {
                    
                }else if (f_arr_first.integerValue > n_arr_first.integerValue){
                    min_location = next;
                }else {
                    if (f_arr_last.integerValue < n_arr_last.integerValue) {
                        
                    }else if (f_arr_last.integerValue > n_arr_last.integerValue){
                        min_location = next;
                    }else{

                    }
                }
                
                min_model = rlt[min_location];
                min_time    = min_model.time;
            }
            TodayNoteModel *tmp = rlt[cou];
            [rlt replaceObjectAtIndex:cou withObject:min_model];
            [rlt replaceObjectAtIndex:min_location withObject:tmp];
        }
        
    }
    return rlt;
}

@end
