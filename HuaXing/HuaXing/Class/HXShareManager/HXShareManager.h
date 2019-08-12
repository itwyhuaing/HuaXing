//
//  HXShareManager.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 分享结果
 
 - HXShareSuccess: 分享成功
 - HXShareFailure: 分享失败
 - HXShareCancel: 分享取消
 */
typedef enum : NSUInteger {
    HXShareSuccess = 0,
    HXShareFailure = 1,
    HXShareCancel = 2
} HXShareResultType;

/**
 分享结果回调
 
 @param result 结果
 @param description 描述
 */
typedef void(^HXShareResult)(HXShareResultType result, NSString *description);

@interface HXShareManager : NSObject

/**
 单例
 
 @return 实例化后的HXShareManager
 */
+ (HXShareManager *)defaultManager;

/**
 分享配置
 */
- (void)config;

/**
 分享回调
 
 @param url url
 @param options options
 @return YES：数据处理成功；NO：数据处理失败
 */
+ (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options;


/**
 分享
 
 @param title 标题
 @param des 描述
 @param image 图片
 @param url 链接
 @param mpName 微信小程序name
 @param mpPath 微信小程序path
 @param mpImage 微信小程序image
 @param controller 控制器
 @param completionResult 分享结果
 */
- (void)shareWithTile:(NSString *)title des:(NSString *)des image:(id)image url:(NSString *)url mpName:(NSString *)mpName mpPath:(NSString *)mpPath mpImage:(UIImage *)mpImage controller:(UIViewController *)controller completionResult:(HXShareResult)completionResult;

@end

NS_ASSUME_NONNULL_END
