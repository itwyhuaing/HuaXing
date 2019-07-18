//
//  UIAdapter.h
//  hinabian
//
//  Created by hnbwyh on 2019/6/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAdapter : NSObject

// 设备宽度
+ (CGFloat)deviceWidth;

// 设备高度
+ (CGFloat)deviceHeight;

// 底部标签栏的高度
+ (CGFloat)tabBarHeight;

// 以 4.7 inch 屏为基准的宽度比例
+ (CGFloat)Scale47Width;

// 750×1334({375,667})       @2x       4.7                      iPhone6/6s/7/7s/8/8s
+ (BOOL)device4_7Inch;

//1242×2208({414,736})      @3x        5.5                       iPhone6P/iPhone7P/iPhone8P
+ (BOOL)device5_5Inch;

//1125×2436({375,812})       @3x        5.8                       iPhoneX/iPhoneXS
+ (BOOL)device5_8Inch;

// 828x1792({414,896})         @2x       6.1                      iPhoneXR
+ (BOOL)device6_1Inch;

//1242x2688({414, 896})        @3x        6.5            iPhoneX/S  Max
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
