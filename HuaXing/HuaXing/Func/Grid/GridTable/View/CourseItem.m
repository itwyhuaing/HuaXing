//
//  CourseItem.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseItem.h"

@interface CourseItem ()

@property (nonatomic,strong) UILabel        *cntLabel;

@end


@implementation CourseItem

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
    self.cntLabel.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
//    self.cntLabel.backgroundColor = [UIColor orangeColor];
    
}

-(void)modifyItemWithData:(NSString *)txt {
    if (txt) {
        self.cntLabel.text = txt;
    }
}

-(UILabel *)cntLabel {
    if (!_cntLabel) {
        _cntLabel = [UILabel new];
        _cntLabel.backgroundColor = [UIColor whiteColor];
    }
    return _cntLabel;
}

@end
