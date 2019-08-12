//
//  HXDatePickView.m
//  HuaXing
//
//  Created by hxwyh on 2019/7/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXDatePickView.h"
#import "HXPickViewToolBar.h"

@interface HXDatePickView ()

@property (nonatomic,strong) UIDatePicker *dp;

@property (nonatomic,strong) HXPickViewToolBar *toolBar;

@property (nonatomic,assign) HXDatePickViewType vType;

@end

@implementation HXDatePickView

- (instancetype)initWithViewType:(HXDatePickViewType)type
{
    self = [super init];
    if (self) {
        _vType = type;
        [self configUIWithViewType:type];
    }
    return self;
}

- (void)configUIWithViewType:(HXDatePickViewType)type {
    //
    self.dp = [UIDatePicker new];
    self.toolBar = [HXPickViewToolBar new];
    [self addSubview:self.dp];
    [self addSubview:self.toolBar];
    
    //
    self.dp.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(230.0 * [UIAdapter Scale47Width]);
    self.toolBar.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self.dp, 0)
    .heightIs(40.0 * [UIAdapter Scale47Width]);
    
    self.backgroundColor = [UIAdapter maskLightBlack];
    self.dp.backgroundColor = [UIColor whiteColor];
    if (type == HXDatePickViewTimeType) {
        self.dp.datePickerMode = UIDatePickerModeTime;
    }else{
        self.dp.datePickerMode = UIDatePickerModeDate;
    }
    self.dp.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    
    // 点击回调
    HXWeakSelf
    self.toolBar.eventBlock = ^(NSInteger location) {
        [weakSelf dismiss];
        if (location == kBUuttonConfirmTag) {
            [weakSelf dealDate];
        }
    };
}

- (void)dealDate {
    NSString *dateResult = @"";
    NSDate* date = self.dp.date;
    //NSLog(@"%@",[date descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    if (self.vType == HXDatePickViewTimeType) {
        df.dateFormat = @"HH:mm";
        //NSLog(@" HXDatePickViewTimeType :%@",[df stringFromDate:date]);
        dateResult = [df stringFromDate:date];
    }else{
        df.dateFormat = @"YYYY-MM-dd";
        //NSLog(@" HXDatePickViewDateType : %@",[df stringFromDate:date]);
        dateResult = [df stringFromDate:date];
    }
    if (self.pickCompletion) {
        self.pickCompletion(dateResult);
    }
}

- (void)showOnSView:(UIView *)sv {
    if (sv) {
        [sv addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    self.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

-(void)setBarThem:(NSString *)barThem {
    if (barThem) {
        [self.toolBar updateThem:barThem];
    }
}

-(void)dismiss {
    [self removeFromSuperview];
}

@end
