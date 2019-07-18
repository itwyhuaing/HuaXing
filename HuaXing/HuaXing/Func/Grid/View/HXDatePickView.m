//
//  HXDatePickView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXDatePickView.h"

@interface HXDatePickView ()

@property (nonatomic,strong) UIDatePicker *dp;

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
    UIView *bv = [UIView new];
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.dp];
    [self addSubview:bv];
    [bv addSubview:leftBtn];
    [bv addSubview:rightBtn];
    
    //
    self.dp.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(230.0 * [UIAdapter Scale47Width]);
    bv.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self.dp, 0)
    .heightIs(40.0 * [UIAdapter Scale47Width]);
    leftBtn.sd_layout
    .leftEqualToView(bv)
    .bottomEqualToView(bv)
    .topEqualToView(bv)
    .widthIs(60.0);
    rightBtn.sd_layout
    .rightEqualToView(bv)
    .bottomEqualToView(bv)
    .topEqualToView(bv)
    .widthIs(60.0);
    
    self.backgroundColor = [UIAdapter maskLightBlack];
    self.dp.backgroundColor = [UIColor whiteColor];
    if (type == HXDatePickViewTimeType) {
        self.dp.datePickerMode = UIDatePickerModeTime;
    }else{
        self.dp.datePickerMode = UIDatePickerModeDate;
    }
    self.dp.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    [self modifyButton:leftBtn title:@"取消" tag:100 titileColor:[UIColor redColor]];
    [self modifyButton:rightBtn title:@"确定" tag:101 titileColor:[UIColor blackColor]];
    
    bv.backgroundColor = [UIColor whiteColor];
    //    leftBtn.backgroundColor = [UIColor greenColor];
    //    rightBtn.backgroundColor = [UIColor orangeColor];
    
}

- (void)modifyButton:(UIButton *)btn title:(NSString *)title tag:(NSInteger)tag titileColor:(UIColor *)clr {
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:clr forState:UIControlStateNormal];
    btn.titleLabel.font = [UIAdapter font17];
    btn.tag = tag;
    [btn addTarget:self action:@selector(eventClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)eventClick:(UIButton *)sender {
    if (sender.tag == 101) {
        [self dismiss];
        [self dealDate];
    }else {
        [self dismiss];
    }
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

-(void)dismiss {
    [self removeFromSuperview];
}

@end
