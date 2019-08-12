//
//  HXBaseVC.h
//  HuaXing
//
//  Created by hxwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXBaseVC : UIViewController


/**
 是否可手势返回 -- 默认为YES，
 */
@property (nonatomic, assign) BOOL canGestureBack;

@end

NS_ASSUME_NONNULL_END
