//
//  CourseHeaderView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseHeaderView.h"


@interface CourseHeaderView ()

@property (nonatomic,strong)    UILabel         *themLabel;
@property (nonatomic,strong)    UILabel         *detailLabel;
@property (nonatomic,strong)    UIImageView     *iconImgV;

@end

@implementation CourseHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    UILabel *line = [UILabel new];
    [self addSubview:self.themLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.iconImgV];
    [self addSubview:line];
    line.sd_layout
    .leftSpaceToView(self, 0.0)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(1.0);
    self.themLabel.sd_layout
    .leftSpaceToView(self, [UIAdapter lrGap])
    .topEqualToView(self)
    .bottomEqualToView(line);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:[UIAdapter deviceWidth]/2.0 * [UIAdapter Scale47Width]];
    self.iconImgV.sd_layout
    .rightSpaceToView(self, 24.0 * [UIAdapter Scale47Width])
    .widthIs(5.0 * [UIAdapter Scale47Width])
    .heightIs(9.0 * [UIAdapter Scale47Width])
    .centerYEqualToView(self);
    self.detailLabel.sd_layout
    .leftSpaceToView(self.themLabel, 10.0)
    .rightSpaceToView(self.iconImgV, 10.0)
    .topEqualToView(self)
    .bottomEqualToView(line);
    [self setupAutoHeightWithBottomView:self.themLabel bottomMargin:0.0];
    
    self.backgroundColor = [UIColor whiteColor];
    self.themLabel.font                         = [UIAdapter font15];
    self.themLabel.textColor                    = [UIAdapter lightBlack];
    self.detailLabel.font                         = [UIAdapter font15];
    self.detailLabel.textColor                    = [UIAdapter lightBlack];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    line.backgroundColor = [UIAdapter lightGray];
}

- (void)updateContentWithThem:(NSString *)them tipMessage:(NSString *)msg {
    
    if (them) {
        self.themLabel.text = them;
    }
    if (msg) {
        self.detailLabel.text = msg;
    }
    
}

#pragma mark --- touch

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.headerEventBlock) {
        self.headerEventBlock();
    }
}


-(UILabel *)themLabel {
    if (!_themLabel) {
        _themLabel = [UILabel new];
        _themLabel.font = [UIAdapter font15];
        _themLabel.textColor = [UIAdapter lightBlack];
        _themLabel.backgroundColor = [UIColor clearColor];
        _themLabel.textAlignment = NSTextAlignmentLeft;
        _themLabel.text = @"几节课";
    }
    return _themLabel;
}

-(UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIAdapter font15];
        _detailLabel.textColor = [UIAdapter lightBlack];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.text = @"点击选择";
    }
    return _detailLabel;
}

-(UIImageView *)iconImgV {
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
    }
    return _iconImgV;
}


@end
