//
//  UIAdapter.m
//  hinabian
//
//  Created by hnbwyh on 2019/6/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "UIAdapter.h"

@implementation UIAdapter

#pragma mark ------ 项目常用几种字体

+ (UIFont *)font10 {
    return [UIFont systemFontOfSize:10.0];
}

+ (UIFont *)font15 {
    return [UIFont systemFontOfSize:15.0];
}

+ (UIFont *)font17{
    return [UIFont systemFontOfSize:17.0];
}

#pragma mark ------ 项目常用几种颜色

+ (UIColor *)mainBlue {
    return [UIColor colorWithHexString:@"#3FA2FF"];
}

+ (UIColor *)lightGray {
    return [UIColor colorWithHexString:@"#EDEDED" alpha:1.0];
}

+ (UIColor *)lightBlack {
    return [UIColor colorWithHexString:@"#333333" alpha:1.0];
}

+ (UIColor *)maskLightBlack {
    return [UIColor colorWithHexString:@"#000" alpha:0.3];
}

#pragma mark ------ 设备尺寸相关参数

+ (CGFloat)lrGap {
    return 20.0 * [UIAdapter Scale47Width];
}

// 设备宽度
+ (CGFloat)deviceWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

// 设备高度
+ (CGFloat)deviceHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

+ (CGFloat)tabBarHeight {
    CYLTabBarController *tabVC = [self cyl_tabBarController];
    return CGRectGetHeight(tabVC.tabBar.frame);
}

+ (CGFloat)Scale47Width {
    return CGRectGetWidth([UIScreen mainScreen].bounds)/375.0;
}

+ (CGFloat)deviceWidthScale {
    return 0.1;
}

+ (BOOL)device4_7Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 375.0 && h == 667.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device5_5Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 414.0 && h == 736.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device5_8Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 375.0 && h == 812.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device6_1Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 414.0 && h == 896.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device6_5Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 414.0 && h == 896.0) {
        rlt = TRUE;
    }
    return rlt;
}


@end
