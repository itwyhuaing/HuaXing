//
//  HXToast.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/5.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXToast.h"
#import "MBProgressHUD.h"

//190 x 110 单行最多容纳 10 个字 & 2行
#define HUD_WIDTH  (190 * [UIAdapter Scale47Width])
#define HUD_HEIGHT (110)

#define HUD_WIDTH_SQURE (100)

#define WORD_MUN_MIN (4)
#define WORD_MUN_MAX (10 * [UIAdapter Scale47Width])


@implementation HXToast


+(instancetype)shareManager {
    static HXToast *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HXToast alloc] init];
    });
    return instance;
}

- (void)toast:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle {
    [self toast:msg afterDelay:delay style:hudStyle complete:nil];
}

- (void)toast:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle complete:(void(^)(void))complete {
    [self toastWithOnView:nil msg:msg afterDelay:delay style:hudStyle complete:complete];
}

- (void)toastWithOnView:(UIView *)view msg:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle{
    [self toastWithOnView:view msg:msg afterDelay:delay style:hudStyle complete:nil];
}

- (void)toastWithOnView:(UIView *)view msg:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HXToastHudStyle)hudStyle complete:(void(^)(void))complete {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [self dismiss:view];
    MBProgressHUD *hud = nil;
    switch (hudStyle) {
            case HXToastHudWaiting:
        {
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [self modifyHXToastHudWaitingToastWithMsg:hud msg:msg];
        }
            break;
            case HXToastHudSuccession:
        {
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [self modifyToastWithMsg:hud msg:msg imgName:@"toast_success"];
        }
            break;
            case HXToastHudFailure:
        {
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [self modifyToastWithMsg:hud msg:msg imgName:@"toast_problem"];
        }
            break;
            case HXToastHudOnlyText:
        {
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [self modifyToastWithMsg:hud msg:msg imgName:nil];
        }
            break;
            case HXToastHudOnlyTitleAndDetailText:
        {
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [self modifyTitleAndDetailTextToastWithMsg:hud msg:msg];
        }
            break;
        default:
            break;
    }
    hud.removeFromSuperViewOnHide = YES;
    hud.completionBlock = ^{
        if (complete) {
            complete();
        }
    };
    if (delay > 0.f) {
        [hud hideAnimated:YES afterDelay:delay];
    }
}

/**
 移除hud
 */
- (void)dismiss {
    [[HXToast shareManager] dismiss:nil];
}

/**
 移除hud
 
 @param view 目标view
 */
- (void)dismiss:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)obj;
            [hud hideAnimated:YES];
        }
    }];
}

#pragma mark ------ HXToastHudWaiting

- (void)modifyHXToastHudWaitingToastWithMsg:(MBProgressHUD *)hud msg:(NSString *)msg{
    if (msg.length <= 0) {
        msg = @"请稍后";
    }
    if (msg.length <= WORD_MUN_MIN) {
        hud.maxSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
        hud.minSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
        hud.square = YES;
    } else if(msg.length > WORD_MUN_MIN && msg.length < WORD_MUN_MAX) {
        hud.maxSize = CGSizeMake(HUD_WIDTH, HUD_WIDTH_SQURE);
    } else if (msg.length >= WORD_MUN_MAX && msg.length <= WORD_MUN_MAX * 2) {
        hud.maxSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
        hud.minSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
    } else if (msg.length > WORD_MUN_MAX * 2) {
        hud.maxSize = CGSizeMake(HUD_WIDTH, [UIAdapter deviceHeight]);
    }
    hud.activityIndictorColor = UIActivityIndicatorViewStyleWhiteLarge;
    hud.label.text = msg;
    [self modifyToast:hud];
}

#pragma mark ------ HXToastHudSuccession HXToastHudFailure HXToastHudOnlyText

- (void)modifyToastWithMsg:(MBProgressHUD *)hud msg:(NSString *)msg imgName:(NSString *)imgName{
    if ([msg isKindOfClass:[NSString class]]) {
        //防护
        hud.mode = MBProgressHUDModeCustomView;
        if (imgName.length > 0) {
            // 图片
            UIImage *img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            hud.customView = [[UIImageView alloc] initWithImage:img];
            // 文字
            if (msg != nil && msg.length > 0 && msg.length <= WORD_MUN_MIN) {
                hud.maxSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
                hud.minSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
                hud.square = YES;
            } else if(msg.length > WORD_MUN_MIN && msg.length < WORD_MUN_MAX) {
                hud.maxSize = CGSizeMake(HUD_WIDTH, HUD_WIDTH_SQURE);
            } else if (msg.length >= WORD_MUN_MAX && msg.length <= WORD_MUN_MAX * 2) {
                hud.maxSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
                hud.minSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
            } else if (msg.length > WORD_MUN_MAX * 2) {
                hud.maxSize = CGSizeMake(HUD_WIDTH, [UIAdapter deviceHeight]);
            }
        } else {
            if (msg.length >= WORD_MUN_MAX) {
                hud.maxSize = CGSizeMake(HUD_WIDTH, [UIAdapter deviceHeight]);
            }
        }
        hud.label.text = msg;
        [self modifyToast:hud];
    }
}

#pragma mark ------ HXToastHudOnlyTitleAndDetailText

- (void)modifyTitleAndDetailTextToastWithMsg:(MBProgressHUD *)hud msg:(NSString *)msg{
    NSArray *tmpArr = [msg componentsSeparatedByString:@"P&"];
    NSString *title = [tmpArr firstObject];
    NSString *content = [tmpArr lastObject];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.maxSize = CGSizeMake([UIAdapter deviceWidth] * 0.8, [UIAdapter deviceHeight]);
    hud.label.text = title;
    hud.detailsLabel.text = content;
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor whiteColor];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    hud.detailsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    hud.bezelView.color = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
}

#pragma mark ------

- (void)modifyToast:(MBProgressHUD *)hud {
    hud.label.font = [UIFont systemFontOfSize:14.0];
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
}

#pragma mark ------ setter

-(void)setMaxSize:(CGSize)maxSize{
    _maxSize = maxSize;
}


-(void)setMinSize:(CGSize)minSize{
    _minSize = minSize;
}

- (void)setY_offset:(CGFloat)y_offset{
    _y_offset = y_offset;
}

- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
}


@end
