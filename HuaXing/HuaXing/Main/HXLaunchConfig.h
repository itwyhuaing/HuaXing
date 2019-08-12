//
//  HXLaunchConfig.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXLaunchConfig : NSObject

@property (class, nonatomic, readonly) HXLaunchConfig *currentConfig;

// 用于AppDelegate启动用
- (void)appWillFinishLaunchingThenStartConfig;

- (void)appDidFinishLaunchingThenStartConfig:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
