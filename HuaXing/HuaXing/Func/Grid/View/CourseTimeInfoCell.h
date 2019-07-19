//
//  CourseTimeInfoCell.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *cell_CourseTimeInfoCell = @"CourseTimeInfoCell";
@interface CourseTimeInfoCell : UITableViewCell

@property (nonatomic,strong) ItemTimeModel          *data;

@end

NS_ASSUME_NONNULL_END
