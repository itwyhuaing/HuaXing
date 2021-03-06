//
//  ClassItemDataModel.h
//  HuaXing
//
//  Created by hxwyh on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

// 课表位置 - 左上角 (0,0)
typedef struct _HXLocation {
    NSUInteger XLocation;
    NSUInteger YLocation;
} HXLocation;


// 第一列 - 序列化数据信息数据模型
@interface SequenceItemModel : BaseDataModel

// 第几节 - 从 0 开始
@property (nonatomic,assign) NSInteger          sequence;

@property (nonatomic,copy)   NSString           *time;

@end


// 每节课数据模型
@interface CourseItemModel : BaseDataModel

@property (nonatomic,copy)      NSString        *courseName;
@property (nonatomic,copy)      NSString        *location;
@property (nonatomic,copy)      NSString        *teacher;

// 第几节 - 从 0 开始
@property (nonatomic,assign)    NSInteger       idx;
// 颜色标记
@property (nonatomic,strong)    UIColor         *clr;


@end

// 每天课程数据模型
@interface ClassItemDataModel : BaseDataModel

@property (nonatomic,copy)      NSString        *date;
@property (nonatomic,copy)      NSString        *weekDay;
@property (nonatomic,strong)    NSArray<CourseItemModel *> *courses;

// 每天最多 节 数
@property (nonatomic,assign)    NSInteger       maxCount;

@end

NS_ASSUME_NONNULL_END
