//
//  HXToast.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/5.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


// toast 延时时间
#define DELAY_TIME 1.5

/**
 HXToastHudStyle
 
 - HXToastHudWaiting: HXToastHudWaiting
 - HXToastHudSuccession: HXToastHudSuccession
 - HXToastHudFailure: HXToastHudFailure
 - HXToastHudOnlyText: HXToastHudOnlyText
 - HXToastHudOnlyTitleAndDetailText: HXToastHudOnlyTitleAndDetailText --样式时参数msg的格式 : "title"P&"content"
 */
typedef NS_ENUM(NSUInteger, HXToastHudStyle) {
    HXToastHudWaiting = 90,
    HXToastHudSuccession,
    HXToastHudFailure,
    HXToastHudOnlyText,
    HXToastHudOnlyTitleAndDetailText
};

@interface HXToast : NSObject


/**
 * hud 上第一个最上面的子控件距离顶部的偏移
 * hinabian - 扩展
 */
@property (assign, nonatomic) CGFloat y_offset;


/**
 * The minimum size of the HUD bezel. Defaults to CGSizeZero (no minimum size).
 * 默认值 - ; 不设置时即以默认值大小样式展示
 */
@property (assign, nonatomic) CGSize minSize;

/**
 * The minimum size of the HUD bezel. Defaults to CGSizeZero (no minimum size).
 * 默认值 - ; 不设置时即以默认值大小样式展示
 */
@property (assign, nonatomic) CGSize maxSize;

/**
 * 蒙版背景色
 */
@property (strong, nonatomic) UIColor *bgColor;

//单例
+(instancetype)shareManager;

//添加hud，如果没有指定目标view，则是在window上添加。
//在同一目标view上继续添加hud时，会先移除已经存在的hud，以保证同一页面只有一个hud存在。
- (void)toast:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle;
- (void)toast:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle complete:(void(^)(void))complete;
- (void)toastWithOnView:(UIView *)view msg:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle;
- (void)toastWithOnView:(UIView *)view msg:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle complete:(void(^)(void))complete;

//移除hud，如果没有指定目标view，则是移除window上的hud
- (void)dismiss;
- (void)dismiss:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
