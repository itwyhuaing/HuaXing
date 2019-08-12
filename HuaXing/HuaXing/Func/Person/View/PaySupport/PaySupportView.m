//
//  PaySupportView.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/9.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PaySupportView.h"
#import "PayItemView.h"

@interface PaySupportView ()

@property (nonatomic,strong) PayItemView *wxpayview;

@property (nonatomic,strong) PayItemView *alipayview;

@end

@implementation PaySupportView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.wxpayview];
    [self addSubview:self.alipayview];
    self.wxpayview.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self);
    self.alipayview.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self.wxpayview, 30.0);
}

-(PayItemView *)wxpayview {
    if (!_wxpayview) {
        _wxpayview = [PayItemView new];
        [_wxpayview modifyItemViewWithTxt:@"微信支付" imgName:@"pay_wx.png"];
    }
    return _wxpayview;
}

-(PayItemView *)alipayview {
    if (!_alipayview) {
        _alipayview = [PayItemView new];
        [_alipayview modifyItemViewWithTxt:@"支付宝支付" imgName:@"pay_zfb.png"];
    }
    return _alipayview;
}

@end
