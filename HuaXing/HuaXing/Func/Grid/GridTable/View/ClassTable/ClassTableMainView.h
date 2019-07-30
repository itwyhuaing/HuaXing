//
//  ClassTableMainView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassItemModel.h"

NS_ASSUME_NONNULL_BEGIN

// 第一列或第一行额外（课表左上角）
#define kExtraCount 1

@class ClassTableMainView;

@protocol ClassTableMainViewDataSource <NSObject>

/**
 设置课程表第一行数据
 
 @param classTable 课程表
 @return 第一行所需数据
 */
- (NSArray<HorizontalItemDataModel *> *)datasOfFirstHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable;


/**
 设置课程表第一列数据

 @param classTable 课程表
 @return 第一列所需数据
 */
- (NSArray<VerticalItemDataModel *> *)datasOfFirstVerticalRowInClassTableMainView:(ClassTableMainView *)classTable;


/**
 设置第一行的高度

 @param classTable 课程表
 @return 第一行高度
 */
- (CGFloat)heightForFirstHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable;

/**
 设置其他行的高度
 
 @param classTable 课程表
 @return 其他行高度
 */
- (CGFloat)heightForCommonHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable;

@end

@protocol ClassTableMainViewDelegate <NSObject>

- (void)classTableMainView:(ClassTableMainView *)classTable didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ClassTableMainView : UIView

@property (nonatomic,weak) id <ClassTableMainViewDataSource>    dataSource;

@property (nonatomic,weak) id <ClassTableMainViewDelegate>    delegate;

@end

NS_ASSUME_NONNULL_END