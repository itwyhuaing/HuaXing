//
//  ClassTableMainView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassItemDataModel.h"


NS_ASSUME_NONNULL_BEGIN

@class ClassTableMainView;

@protocol ClassTableMainViewDataSource <NSObject>
@required

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


/**
 设置第一列的宽度
 
 @param classTable 课程表
 @return 第一列宽度
 */
- (CGFloat)widthForFirstVerticalRowInClassTableMainView:(ClassTableMainView *)classTable;

/**
 设置其他列的宽度
 
 @param classTable 课程表
 @return 其他列宽度
 */
- (CGFloat)widthForCommonVerticalRowInClassTableMainView:(ClassTableMainView *)classTable;

@end

@protocol ClassTableMainViewDelegate <NSObject>

- (void)classTableMainView:(ClassTableMainView *)classTable didSelectItemAtLocation:(HXLocation)l;

@end

@interface ClassTableMainView : UIView

// 序列化信息数据 - 第一列数据
@property (nonatomic,strong) NSArray<SequenceItemModel *>       *ds_sequences;

// 课表每天课程数据 - 其他列数据
@property (nonatomic,strong) NSArray<ClassItemDataModel *>      *ds_classItems;

@property (nonatomic,weak) id <ClassTableMainViewDataSource>    dataSource;

@property (nonatomic,weak) id <ClassTableMainViewDelegate>    delegate;

- (void)reloadClassTalbe;

@end

NS_ASSUME_NONNULL_END
