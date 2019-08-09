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
        self.cntLabel.text = [self generateMutableString];
        self.cntLabel.backgroundColor = model.clr;
    }
}

- (NSMutableString *)generateMutableString {
    NSMutableString *rlt = [NSMutableString new];
    BOOL courseName = FALSE;
    BOOL teacher = FALSE;
    if (self.model.courseName && self.model.courseName.length > 0) {
        courseName = TRUE;
        [rlt appendString:self.model.courseName];
    }
    if (self.model.teacher && self.model.teacher.length > 0) {
        teacher = TRUE;
        if (courseName) {
            [rlt appendString:@"\n"];
        }
        [rlt appendString:self.model.teacher];
    }
    if (self.model.location && self.model.location.length > 0) {
        if (courseName || teacher) {
            [rlt appendString:@"\n"];
        }
        [rlt appendString:self.model.location];
    }
    return rlt;
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
