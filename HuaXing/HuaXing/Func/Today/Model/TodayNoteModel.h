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

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *briefInfo;

@property (nonatomic,copy) NSString *showInfo;

@property (nonatomic,copy) NSString *foldImageName;

// 信息记录
@property (nonatomic,copy) NSString *detailInfo;

@end

NS_ASSUME_NONNULL_END
