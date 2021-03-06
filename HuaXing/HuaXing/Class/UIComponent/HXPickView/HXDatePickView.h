//
//  HXDatePickView.h
//  HuaXing
//
//  Created by hxwyh on 2019/7/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^HXDatePickCompletion)(NSString *dateResult);

typedef enum : NSUInteger {
    HXDatePickViewDefaultType = 100,
    HXDatePickViewDateType,
    HXDatePickViewTimeType,
} HXDatePickViewType;

@interface HXDatePickView : UIView

- (instancetype)initWithViewType:(HXDatePickViewType)type;

@property (nonatomic,copy) HXDatePickCompletion pickCompletion;

@property (nonatomic,copy) NSString *barThem;

- (void)showOnSView:(UIView *)sv;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
