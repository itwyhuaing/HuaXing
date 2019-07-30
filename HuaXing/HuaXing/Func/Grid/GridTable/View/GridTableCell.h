//
//  GridTableCell.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *cell_GridTableCell = @"GridTableCell";

typedef void(^GridTableCellSelectedBlock)(NSIndexPath *idx);
@interface GridTableCell : UITableViewCell

@property (nonatomic,copy)  GridTableCellSelectedBlock gtcSelectedBlock;

@end

NS_ASSUME_NONNULL_END
