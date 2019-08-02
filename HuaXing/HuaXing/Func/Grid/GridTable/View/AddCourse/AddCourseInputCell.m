//
//  AddCourseInputCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/2.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddCourseInputCell.h"

@interface AddCourseInputCell ()

@property (nonatomic,strong) UIImageView    *leftIcon;
@property (nonatomic,strong) UILabel        *themLabel;
@property (nonatomic,strong) UITextField    *input;

@end

@implementation AddCourseInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self.contentView addSubview:self.leftIcon];
    [self.contentView addSubview:self.themLabel];
    [self.contentView addSubview:self.input];
}

-(void)layoutSubviews {
    
}

-(UIImageView *)leftIcon {
    if (!_leftIcon) {
        _leftIcon = [UIImageView new];
        _leftIcon.contentMode = UIViewContentModeScaleAspectFill;
        _leftIcon.clipsToBounds = TRUE;
    }
    return _leftIcon;
}

-(UILabel *)themLabel {
    if (!_themLabel) {
        _themLabel = [UILabel new];
    }
    return _themLabel;
}

-(UITextField *)input {
    if (!_input) {
        _input = [[UITextField alloc] init];
    }
    return _input;
}

@end
