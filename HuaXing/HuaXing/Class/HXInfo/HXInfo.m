
//
//  HXInfo.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/9.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXInfo.h"
#import "HXUtil.h"

@interface HXInfo ()

@property(nonatomic, nonatomic, readwrite) HXInfo   *currentInfo;
@property (nonatomic, copy, readwrite) NSString *appVersion;         // 应用版本号 : x.x.x
@property (nonatomic, copy, readwrite) NSString *appId;              // app store 分配的应用 id
@property (nonatomic, copy, readwrite) NSString *appBundleId;        // app 工程 Bundle id
@property (nonatomic, copy, readwrite) NSString *md5AppBundleId;     // app 工程 md5 Bundle id
@property (nonatomic, copy, readwrite) NSString *systemVersion;      // 手机系统版本
@property (nonatomic, copy, readwrite) NSString *model;              // 系统平台类型
@property (nonatomic, copy, readwrite) NSString *idfa;
@property (nonatomic, copy, readwrite) NSString *md5idfa;
@property (nonatomic, copy, readwrite) NSString *fidfa;
@property (nonatomic, copy, readwrite) NSString *md5fidfa;

@end

@implementation HXInfo

+(HXInfo *)currentInfo {
    static HXInfo *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HXInfo alloc] init];
    });
    return instance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.appVersion     = [[NSBundle mainBundle].infoDictionary getStringValueForKey:@"CFBundleShortVersionString"];
        self.appId          = @"998252358";
        self.appBundleId    = [[NSBundle mainBundle].infoDictionary getStringValueForKey:@"CFBundleIdentifier"];
        self.md5AppBundleId = [HXUtil md5HexDigest:self.appBundleId];
        self.systemVersion  = [UIDevice currentDevice].systemVersion;
        self.model          = [UIDevice currentDevice].model;
    }
    return self;
}

@end
