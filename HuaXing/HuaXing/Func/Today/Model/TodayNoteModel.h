//
//  TodayNoteModel.h
//  HuaXing
//
//  Created by wangyinghua on 2019/8/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayNoteModel : NSObject

/**<数据属性 >*/
// 信息记录
@property (nonatomic,copy) NSString *time;
// 信息记录
@property (nonatomic,copy) NSString *briefInfo;
// 信息记录
@property (nonatomic,copy) NSString *detailInfo;


/**<逻辑属性 >*/
// 用于展示详细信息
@property (nonatomic,copy) NSString *showInfo;
// 用于标记展开或折叠图标 TRUE - 折叠状态 ， 反之 - 展开状态
@property (nonatomic,assign) BOOL   foldStatus; // foldImageName
// 用于标记唯一性
@property (nonatomic,copy) NSString *itemID;

@end

NS_ASSUME_NONNULL_END
