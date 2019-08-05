//
//  ClassTableCell.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassItemDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClassTableCellSelectedBlock)(HXLocation location);

@interface ClassTableCell : UITableViewCell

@property (nonatomic,copy)  ClassTableCellSelectedBlock itemSelectedBlock;


/**
 更新 cell Frame

 @param cw cell 实际宽度
 @param ch cell 实际高度
 @param w1 课程表第一列宽度，也即 collectionview 的头部宽度
 @param w2 课程表第其他列宽度，也即 collectionview 的i item 宽度
 */
- (void)updateFrameWithCellWidth:(CGFloat)cw
                      cellHeight:(CGFloat)ch
 widthForFirstVertivalRowInTable:(CGFloat)w1
 widthForOtherVertivalRowInTable:(CGFloat)w2;


/**
 更新 cell 内容

 @param sequences 课表第一列s序列化数据
 @param clsItems 课表每天数据
 */
- (void)updateCellWithSequences:(NSArray<SequenceItemModel *> *)sequences
                      classData:(NSArray<ClassItemDataModel *> *)clsItems;

// 记录当前 cell 所在行
@property (nonatomic,assign) NSInteger currentIndexForCell;

// 通知标识
@property (nonatomic,copy)   NSString   *notificationName;

@end

NS_ASSUME_NONNULL_END
