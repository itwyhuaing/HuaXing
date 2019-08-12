//
//  HXUtil.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/9.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HXUtil

+ (NSString *) md5HexDigest:(NSString*)str {
    if (str == Nil) {
        return @"";
    }
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

+ (void)gotoAppStoreEvaluteWithAppID:(NSString *)appID {
    NSURL *appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",appID]];
    [self openScheme:appUrl options:@{} complete:^(BOOL success) {
        NSLog(@"%d",success);
    }];
}

+ (void)openScheme:(NSURL *)schemeURL options:(NSDictionary *)option complete:(void(^)(BOOL success))complete {
    UIApplication *application = [UIApplication sharedApplication];
    if (@available(iOS 10.0, *)) {
        [application openURL:schemeURL options:option completionHandler:^(BOOL success) {
            if (complete) {
                complete(success);
            }
        }];
    } else {
        // Fallback on earlier versions
        [application openURL:schemeURL];
        BOOL success = [application canOpenURL:schemeURL];
        if (complete) {
            complete(success);
        }
    }
    
}


@end
