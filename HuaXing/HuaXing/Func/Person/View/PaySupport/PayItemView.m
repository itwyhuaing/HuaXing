//
//  PayItemView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/9.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PayItemView.h"

@interface PayItemView ()

@property (nonatomic,strong) UILabel        *detailLable;

@property (nonatomic,strong) UIImageView    *imgV;

@end

@implementation PayItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.detailLable];
    [self addSubview:self.imgV];
}

-(UILabel *)detailLable {
    if (!_detailLable) {
        _detailLable = [UILabel new];
        _detailLable.textColor = [UIAdapter lightTintBlack];
        _detailLable.font = [UIAdapter font15];
    }
    return _detailLable;
}

-(UIImageView *)imgV {
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.clipsToBounds = TRUE;
    }
    return _imgV;
}

@end
