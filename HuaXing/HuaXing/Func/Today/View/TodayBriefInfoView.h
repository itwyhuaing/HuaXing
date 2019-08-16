//
//  TodayBriefInfoView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayBriefInfoView : UIView

@property (nonatomic,strong) NSArray<NSString *> *cnts;

+ (CGFloat)minHeight;

@end

NS_ASSUME_NONNULL_END
