//
//  HXShareManager.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXShareManager.h"

#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@implementation HXShareManager


/**
 单例
 
 @return 实例化后的HNBShareManager
 */
+ (HXShareManager *)defaultManager {
    static HXShareManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}

/**
 分享配置
 */
- (void)config {
    
//    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKEY];
    [[UMSocialManager defaultManager] openLog:YES];
    
    //[UMSocialManager defaultManager];
    
    // 打开图片水印
    [UMSocialGlobal shareInstance].isUsingWaterMark = TRUE;
    // 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = FALSE;
    
    // 设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:WXKEY
                                       appSecret:WXSECRET
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    // 设置分享到QQ互联的appID,U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:QQKEY /*设置QQ平台的appID*/
                                       appSecret:nil
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    // 移除相应平台的分享，如微信收藏
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
}

/**
 分享回调
 
 @param url url
 @param options options
 @return YES：数据处理成功；NO：数据处理失败
 */
+ (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options {
    return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
}

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
- (void)shareWithTile:(NSString *)title des:(NSString *)des image:(id)image url:(NSString *)url mpName:(NSString *)mpName mpPath:(NSString *)mpPath mpImage:(UIImage *)mpImage controller:(UIViewController *)controller completionResult:(HXShareResult)completionResult {
    UMSocialMessageObject *msgObj = [UMSocialMessageObject messageObject];
    UMShareWebpageObject  *sharedObj = [UMShareWebpageObject shareObjectWithTitle:title descr:des thumImage:image];
    sharedObj.webpageUrl = url;
    msgObj.shareObject = sharedObj;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {

        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:msgObj
                                    currentViewController:controller
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (result) {
                                                       HXShareResultType resultType = HXShareSuccess;
                                                       NSString      *resultDes = @"分享成功";
                                                       if (error) {
                                                           if (error.code == UMSocialPlatformErrorType_Cancel) {
                                                               resultType = HXShareCancel;
                                                               resultDes = @"分享取消";
                                                           }else {
                                                               resultType = HXShareFailure;
                                                               resultDes = @"分享出错";
                                                           }
                                                       }
                                                       completionResult ? completionResult(resultType,resultDes) : nil;
                                                   }
                                                   
                                               }];
    }];
}

@end
