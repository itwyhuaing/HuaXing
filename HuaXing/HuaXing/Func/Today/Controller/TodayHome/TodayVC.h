//
//  TodayVC.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXBaseVC.h"
#import "LTSCalendarBaseViewController.H"
@class TodayNoteModel;

NS_ASSUME_NONNULL_BEGIN

@interface TodayVC : LTSCalendarBaseViewController

@property (nonatomic,strong) NSArray<TodayNoteModel *> *dataSource;

@end

NS_ASSUME_NONNULL_END
