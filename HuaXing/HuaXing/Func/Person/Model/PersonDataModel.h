//
//  PersonDataModel.h
//  HuaXing
//
//  Created by wangyinghua on 2019/7/14.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemDataModel : NSObject

@property (nonatomic,copy) NSString *themTxt;
@property (nonatomic,copy) NSString *detailTxt;
@property (nonatomic,copy) NSString *rightIConName;

@end

@interface GroupDataModel : NSObject

@property (nonatomic,strong) NSArray<ItemDataModel *> *items;

@end

@interface PersonDataModel : NSObject

@property (nonatomic,strong) NSArray<GroupDataModel *> *data;

@end

NS_ASSUME_NONNULL_END
