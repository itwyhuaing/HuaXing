//
//  ClassTableCell.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClassTableCellSelectedBlock)(NSIndexPath *idx);

@interface ClassTableCell : UITableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier heightForCell:(CGFloat)hc widthForCell:(CGFloat)fc;

@property (nonatomic,copy)  ClassTableCellSelectedBlock cellSelectedBlock;

@property (nonatomic,assign) NSInteger itemsCount;

@end

NS_ASSUME_NONNULL_END
