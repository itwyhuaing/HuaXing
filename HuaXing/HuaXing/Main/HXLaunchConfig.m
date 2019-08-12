//
//  HXLaunchConfig.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXLaunchConfig.h"
#import "HXShareManager.h"

@implementation HXLaunchConfig

+ (HXLaunchConfig *)currentConfig {
    static HXLaunchConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //
    }
    return self;
}

#pragma mark ------ 应用启动需处理业务

- (void)appWillFinishLaunchingThenStartConfig {
    [[HXShareManager defaultManager] config];
}

- (void)appDidFinishLaunchingThenStartConfig:(NSDictionary *)launchOptions {}

@end
