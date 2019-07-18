//
//  HXTabAdapter.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXTabAdapter : NSObject

/**
 实例化单例
 */
+ (instancetype)defaultInstance;

/**
 实例化对象
 */
- (CYLTabBarController *)tabBarController;

@end

NS_ASSUME_NONNULL_END
