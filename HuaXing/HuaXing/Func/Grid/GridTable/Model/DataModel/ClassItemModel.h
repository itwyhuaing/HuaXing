//
//  ClassItemModel.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface HorizontalItemDataModel : NSObject

@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *weekDay;

@end

@interface VerticalItemDataModel : NSObject

@property (nonatomic,copy) NSString *sequence;

@end

@interface ClassItemModel : NSObject

@end

NS_ASSUME_NONNULL_END
