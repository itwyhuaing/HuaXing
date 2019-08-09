//
//  BriefInfoHeaderView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/8.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "BriefInfoHeaderView.h"

@interface BriefInfoHeaderView ()

@property (nonatomic,strong) UILabel *cntLabel;

@end

@implementation BriefInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI {
    [self addSubview:self.cntLabel];
}

-(void)layoutSubviews {
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    [self.cntLabel setFrame:rect];
}

-(void)setThem:(NSString *)them {
    if (them) {
        _them = them;
        self.cntLabel.text = them;
    }
}

-(UILabel *)cntLabel {
    if (!_cntLabel) {
        _cntLabel = [UILabel new];
        _cntLabel.font                         = [UIAdapter font15];
        _cntLabel.textColor                    = [UIAdapter lightTintBlack];
    }
    return _cntLabel;
}

@end
