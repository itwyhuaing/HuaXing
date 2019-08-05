//
//  TableInfoHeaderView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TableInfoHeaderView.h"

@interface TableInfoHeaderView ()

@property (nonatomic,strong) UILabel        *cntLabel;

@end

@implementation TableInfoHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.cntLabel];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)layoutSubviews {
    CGRect rect         = self.bounds;
    rect.origin         = CGPointZero;
    [self.cntLabel setFrame:rect];
}

-(UILabel *)cntLabel {
    if (!_cntLabel) {
        _cntLabel = [UILabel new];
        _cntLabel.textColor = [UIColor blackColor];
        _cntLabel.numberOfLines = 0;
        _cntLabel.textAlignment = NSTextAlignmentCenter;
        _cntLabel.layer.borderColor = [UIAdapter lightGray].CGColor;
        _cntLabel.layer.borderWidth = 0.5;
        _cntLabel.backgroundColor = [UIColor whiteColor];
    }
    return _cntLabel;
}


@end
