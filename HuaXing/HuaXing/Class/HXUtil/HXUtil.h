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

@end

NS_ASSUME_NONNULL_END
