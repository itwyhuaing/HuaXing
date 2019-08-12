//
//  PaySupportVC.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/8.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PaySupportVC.h"
#import "PaySupportView.h"

@interface PaySupportVC ()

@property (nonatomic,strong) PaySupportView    *pstv;

@end

@implementation PaySupportVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"微信与支付宝支付";
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.pstv];
    self.pstv.sd_layout
    .topSpaceToView(self.view, 30.0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
}

-(PaySupportView *)pstv {
    if (!_pstv) {
        _pstv = [PaySupportView new];
    }
    return _pstv;
}

@end
