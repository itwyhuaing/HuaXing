//
//  TableInfoHeaderView.m
//  HuaXing
//
//  Created by hxwyh on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TableInfoHeaderView.h"

@interface TableInfoHeaderView ()

@property (nonatomic,strong) UILabel        *firstLabel;

@property (nonatomic,strong) UILabel        *secondLabel;

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
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
    [self drawLine];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)layoutSubviews {
    CGRect rect         = self.bounds;
    rect.origin         = CGPointZero;
    rect.size.height    = CGRectGetHeight(self.bounds)/2.0;
    [self.firstLabel setFrame:rect];
    
    rect.origin.y       = CGRectGetHeight(self.bounds)/2.0;
    [self.secondLabel setFrame:rect];
}


- (void)drawLine {
    CGPoint sp = CGPointZero;
    CGPoint ep = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:sp];
    [bezierPath addLineToPoint:ep];
    [bezierPath closePath];
    
    CAShapeLayer *sl = [CAShapeLayer layer];
    sl.strokeColor = [UIAdapter lineGray].CGColor;
    sl.path = bezierPath.CGPath;
    sl.fillColor = UIColor.clearColor.CGColor;
    [self.layer addSublayer:sl];
}

-(UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [UILabel new];
        _firstLabel.textColor = [UIAdapter lightTintBlack];
        _firstLabel.textAlignment = NSTextAlignmentRight;
        _firstLabel.backgroundColor = [UIColor whiteColor];
        _firstLabel.text = @"日期";
    }
    return _firstLabel;
}

-(UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [UILabel new];
        _secondLabel.textColor = [UIAdapter lightTintBlack];
        _secondLabel.textAlignment = NSTextAlignmentLeft;
        _secondLabel.backgroundColor = [UIColor whiteColor];
        _secondLabel.text = @"课程";
    }
    return _secondLabel;
}


@end
