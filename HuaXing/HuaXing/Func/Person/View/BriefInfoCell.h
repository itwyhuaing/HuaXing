//
//  BriefInfoCell.h
//  HuaXing
//
//  Created by wangyinghua on 2019/7/14.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDataModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *cell_BriefInfoCell = @"BriefInfoCell";
@interface BriefInfoCell : UITableViewCell

@property (nonatomic,strong) ItemDataModel *data;

@end

NS_ASSUME_NONNULL_END
