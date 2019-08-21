//
//  HXUtil.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/9.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXUtil : NSObject


/**
 MD5 加密

 @param str 待加密字符串
 @return MD5 加密之后的字符串
 */
+ (NSString *) md5HexDigest:(NSString*)str;

+ (void)gotoAppStoreEvaluteWithAppID:(NSString *)appID;

/**
 获取随机数

 @param from 起始值
 @param to   终止值
 @param closed 是否闭合
 @return 返回随机数
 */
+ (int)randomFrom:(int)from to:(int)to closed:(BOOL)closed;

@end

NS_ASSUME_NONNULL_END
