//
//  ClassTableHeaderView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassItemDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassTableHeaderView : UIView

/**
 更新 TableHeader Frame
 
 @param w cell 实际宽度
 @param h cell 实际高度
 @param w1 课程表第一列宽度，也即 collectionview 的头部宽度
 @param w2 课程表第其他列宽度，也即 collectionview 的i item 宽度
 */
- (void)updateFrameWithTableHeaderWidth:(CGFloat)w
                      tableHeaderHeight:(CGFloat)h
 widthForFirstVertivalRowInTable:(CGFloat)w1
 widthForOtherVertivalRowInTable:(CGFloat)w2;


/**
 更新 TableHeader 内容
 
 @param clsItems 课表每天数据
 */
- (void)updateTableHeaderWithClassData:(NSArray<ClassItemDataModel *> *)clsItems;

// 通知标识
@property (nonatomic,copy)   NSString   *notificationName;

@end

NS_ASSUME_NONNULL_END
