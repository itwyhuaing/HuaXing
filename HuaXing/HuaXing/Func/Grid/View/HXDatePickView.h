//
//  HXDatePickView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/18.
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

- (void)showOnSView:(UIView *)sv;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
