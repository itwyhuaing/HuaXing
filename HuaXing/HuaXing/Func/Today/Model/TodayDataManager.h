//
//  TodayDataManager.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TodayNoteModel;

NS_ASSUME_NONNULL_BEGIN

@interface TodayDataManager : NSObject

- (NSArray *)orderedByTimeWithDataSource:(NSArray<TodayNoteModel *> *)dataSource;

@end

NS_ASSUME_NONNULL_END
