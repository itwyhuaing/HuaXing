//
//  PayItemView.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/9.
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
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.detailLable];
    [self addSubview:self.imgV];
    self.detailLable.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .heightIs(20.0 * [UIAdapter Scale47Width])
    .rightEqualToView(self);
    self.imgV.sd_layout
    .topSpaceToView(self.detailLable, 6.0 * [UIAdapter Scale47Width])
    .widthIs(200.0)
    .heightEqualToWidth()
    .centerXEqualToView(self);
    [self setupAutoHeightWithBottomView:self.imgV bottomMargin:0.0];
    
}

-(void)modifyItemViewWithTxt:(NSString *)txt imgName:(NSString *)imgName {
    self.detailLable.text = txt;
    self.imgV.image = [UIImage imageNamed:imgName];
//    self.detailLable.backgroundColor = [UIColor redColor];
//    self.imgV.backgroundColor        = [UIColor purpleColor];
}

-(UILabel *)detailLable {
    if (!_detailLable) {
        _detailLable = [UILabel new];
        _detailLable.textColor = [UIAdapter lightTintBlack];
        _detailLable.font = [UIAdapter font15];
        _detailLable.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLable;
}

-(UIImageView *)imgV {
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
        _imgV.clipsToBounds = TRUE;
    }
    return _imgV;
}

@end
