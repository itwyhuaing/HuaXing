//
//  UIAdapter.h
//  hinabian
//
//  Created by hxwyh on 2019/6/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片 ： 灰色色值 #EAEAEA
        主题色  #3FA2FF
 
 分割线：灰色色值 #EDEDED
 
 背景色：灰色色值 #F6F6F6
 
 字体 ：灰色色值 #999999 #333333
 */

@interface UIAdapter : NSObject


#pragma mark ------ 项目常用几种字体

/**
 补充描述性文字常用字体
 
 @return 字体
 */
+ (UIFont *)font10;

/**
 正文显示常用字体
 
 @return 字体
 */
+ (UIFont *)font15;

/**
 标题常用字体
 
 @return 字体
 */
+ (UIFont *)font17;

/**
 标题常用字体 - 加粗
 
 @return 字体
 */
+ (UIFont *)font17_Medium;

#pragma mark ------ 项目常用几种颜色

/**
 工程主题色
 
 @return 颜色
 */
+ (UIColor *)mainBlue;


/**
 工程主题色

 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)mainBlueWithAlpha:(CGFloat)alpha;

/**
 主要用于分割线颜色设置
 
 @return 颜色
 */
+ (UIColor *)lineGray;

/**
 主要用于普通背景颜色设置
 
 @return 颜色
 */
+ (UIColor *)normalBackgroudColorGray;

/**
 主要用于灰色字体颜色设置
 
 @return 颜色
 */
+ (UIColor *)lightTintGray;

/**
 主要用于字体颜色设置
 
 @return 颜色
 */
+ (UIColor *)lightTintBlack;

/**
 主要用于有一定透明度蒙版颜色设置

 @return 颜色
 */
+ (UIColor *)maskLightBlack;


/**
 随机色

 @return 随机色
 */
+ (UIColor *)randomColor;

#pragma mark ------ 设备尺寸相关参数

/**
 内容距离左右的间距
 
 @return 左右的间距
 */
+ (CGFloat)lrGap;


/**
 普通屏幕设备的导航栏高度

 @return 高度
 */
+ (CGFloat)normalNavBarHeight;


/**
 适配类似 X 系列设备导航栏时高度调整

 @return 高度
 */
+ (CGFloat)suitHeightForX_Device;

/**
 设备宽度
 
 @return 宽度
 */
+ (CGFloat)deviceWidth;

/**
    设备高度
 
 @return 高度
 */
+ (CGFloat)deviceHeight;

/**
    底部标签栏的高度
 
 @return 底部标签栏的高度
 */
+ (CGFloat)tabBarHeight;

/**
    以 4.7 inch 屏为基准的宽度比例
 
 @return 以 4.7 inch 屏为基准的宽度比例
 */
+ (CGFloat)Scale47Width;

/**
    4.7     750×1334({375,667})       @2x                             iPhone6/6s/7/7s/8/8s
 
 @return 4.7 inch
 */
+ (BOOL)device4_7Inch;

/**
     5.5    1242×2208({414,736})      @3x        5.5                       iPhone6P/iPhone7P/iPhone8P
 
 @return  5.5 inch
 */
+ (BOOL)device5_5Inch;

/**
    5.8     1125×2436({375,812})       @3x        5.8                       iPhoneX/iPhoneXS
 
 @return 5.8 inch
 */
+ (BOOL)device5_8Inch;

/**
    6.1 828x1792({414,896})         @2x                             iPhoneXR
 
 @return    6.1 inch
 */
+ (BOOL)device6_1Inch;

/**
    6.5     1242x2688({414, 896})        @3x                    iPhoneX/S  Max
 
 @return    6.5 inch
 */
+ (BOOL)device6_5Inch;



/**
 4.7         750×1334(375 * 667)       @2x         Retina4.7                 iPhone6/6s/7/7s/8/8s
 5.5        1242×2208(414 * 736)      @3x        Retina 5.5                 iPhone6P/iPhone7P/iPhone8P
 5.8        1125×2436(375 * 812)      @3x        iPhone X/ XS            iPhoneX/iPhoneXS
 6.1        828x1792(414 * 896)       @2x        iPhoneXR                   iPhoneXR
 6.5        1242x2688(414 * 896)      @3x        iPhoneXMax             iPhoneX Max
 */

@end

NS_ASSUME_NONNULL_END
