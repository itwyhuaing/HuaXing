//
//  HXInfo.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/9.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXInfo : NSObject

@property(class, nonatomic, readonly) HXInfo   *currentInfo;
@property (nonatomic, copy, readonly) NSString *appVersion;         // 应用版本号 : x.x.x
@property (nonatomic, copy, readonly) NSString *appId;              // app store 分配的应用 id
@property (nonatomic, copy, readonly) NSString *appBundleId;        // app 工程 Bundle id
@property (nonatomic, copy, readonly) NSString *md5AppBundleId;     // app 工程 md5 Bundle id
@property (nonatomic, copy, readonly) NSString *systemVersion;      // 手机系统版本
@property (nonatomic, copy, readonly) NSString *model;              // 系统平台类型
@property (nonatomic, copy, readonly) NSString *idfa;
@property (nonatomic, copy, readonly) NSString *md5idfa;
@property (nonatomic, copy, readonly) NSString *fidfa;
@property (nonatomic, copy, readonly) NSString *md5fidfa;

@end

NS_ASSUME_NONNULL_END
