//
//  SequenceHeaderView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/1.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "SequenceHeaderView.h"
#import "ClassItemDataModel.h"

@interface SequenceHeaderView ()

@property (nonatomic,strong) UILabel        *cntLabel;

@end

@implementation SequenceHeaderView


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
}

-(void)layoutSubviews {
    CGRect rect         = self.bounds;
    rect.origin         = CGPointZero;
    [self.cntLabel setFrame:rect];
}

-(void)setModel:(SequenceItemModel *)model {
    if (model) {
        _model = model;
        if (model.time) {
            self.cntLabel.text = [NSString stringWithFormat:@"第 %ld 节\n%@",model.sequence+1,model.time];
        }else{
            self.cntLabel.text = [NSString stringWithFormat:@"第 %ld 节",model.sequence+1];
        }
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
