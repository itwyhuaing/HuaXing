//
//  TodayNoteCell.h
//  HuaXing
//
//  Created by wangyinghua on 2019/8/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayNoteModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TodayNoteCellEventTypeFold = 990,
    TodayNoteCellEventTypeEdit,
} TodayNoteCellEventType;

typedef void(^TodayNoteEventBlock)(NSString *cnt);
@interface TodayNoteCell : UITableViewCell

@property (nonatomic,strong) TodayNoteModel *model;

@property (nonatomic,copy)   TodayNoteEventBlock foldEventBlock;

@property (nonatomic,copy)   TodayNoteEventBlock editEventBlock;

@end

NS_ASSUME_NONNULL_END
