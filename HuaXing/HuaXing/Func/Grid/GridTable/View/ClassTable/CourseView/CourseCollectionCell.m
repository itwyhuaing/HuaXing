//
//  CourseCollectionCell.m
//  HuaXing
//
//  Created by wangyinghua on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseCollectionCell.h"
#import "ClassItemDataModel.h"

@interface CourseCollectionCell ()

@property (nonatomic,strong) UILabel        *cntLabel;

@end


@implementation CourseCollectionCell


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

-(void)setModel:(CourseItemModel *)model {
    if (model) {
        _model = model;
        self.cntLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",model.courseName,model.teacher,model.location];
    }
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
