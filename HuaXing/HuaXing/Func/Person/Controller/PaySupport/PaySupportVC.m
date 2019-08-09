//
//  PaySupportVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/8.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PaySupportVC.h"

@interface PaySupportVC ()

@property (nonatomic,strong) UIImageView    *aliPayImageView;
@property (nonatomic,strong) UIImageView    *wxImageView;

@end

@implementation PaySupportVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"微信与支付宝支付";
    [self setupUI];
    [self modifyWithContent];
}

- (void)setupUI {
    [self.view addSubview:self.wxImageView];
    [self.view addSubview:self.aliPayImageView];
    
    // w756 h760
    self.wxImageView.sd_layout
    .topSpaceToView(self.view, 100.0)
    .centerXEqualToView(self.view)
    .heightIs(100.0)
    .autoWidthRatio(756.0/760.0);
    
    // w520 h536
    self.aliPayImageView.sd_layout
    .topSpaceToView(self.wxImageView, 30.0)
    .centerXEqualToView(self.view)
    .heightIs(100.0)
    .autoWidthRatio(520.0/536.0);
}

- (void)modifyWithContent {
    self.wxImageView.image = [UIImage imageNamed:@"pay_wx.png"];
    self.aliPayImageView.image = [UIImage imageNamed:@"pay_zfb.png"];
}

-(UIImageView *)aliPayImageView {
    if (!_aliPayImageView) {
        _aliPayImageView = [[UIImageView alloc] init];
        _aliPayImageView.contentMode = UIViewContentModeScaleAspectFill;
        _aliPayImageView.clipsToBounds = TRUE;
    }
    return _aliPayImageView;
}

-(UIImageView *)wxImageView {
    if (!_wxImageView) {
        _wxImageView = [[UIImageView alloc] init];
        _wxImageView.contentMode = UIViewContentModeScaleAspectFill;
        _wxImageView.clipsToBounds = TRUE;
    }
    return _wxImageView;
}

@end
