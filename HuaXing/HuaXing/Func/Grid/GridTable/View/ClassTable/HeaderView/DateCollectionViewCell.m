//
//  DateCollectionViewCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import "ClassItemDataModel.h"

@interface DateCollectionViewCell ()

@property (nonatomic,strong) UILabel        *cntLabel;

@end

@implementation DateCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self.contentView addSubview:self.cntLabel];
}

-(void)layoutSubviews {
    CGRect rect         = self.bounds;
    rect.origin         = CGPointZero;
    [self.cntLabel setFrame:rect];
}

-(void)setModel:(ClassItemDataModel *)model {
    if (model) {
        _model = model;
        self.cntLabel.text = [NSString stringWithFormat:@"%@\n%@",model.date,model.weekDay];
    }
}

-(UILabel *)cntLabel {
    if (!_cntLabel) {
        _cntLabel = [UILabel new];
        _cntLabel.textColor = [UIAdapter lightTintBlack];
        _cntLabel.numberOfLines = 0;
        _cntLabel.textAlignment = NSTextAlignmentCenter;
        _cntLabel.layer.borderColor = [UIAdapter lineGray].CGColor;
        _cntLabel.layer.borderWidth = 0.5;
        _cntLabel.backgroundColor = [UIColor whiteColor];
    }
    return _cntLabel;
}


@end
