//
//  AddCourseInputCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/2.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddCourseInputCell.h"

@interface AddCourseInputCell () <UITextFieldDelegate>

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
    UILabel *line = [UILabel new];
    [self.contentView addSubview:self.leftIcon];
    [self.contentView addSubview:self.themLabel];
    [self.contentView addSubview:self.input];
    [self.contentView addSubview:line];
    line.sd_layout
    .leftSpaceToView(self.contentView, 0.0)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1.0);
    
    self.leftIcon.sd_layout
    .widthIs(16.0 * [UIAdapter Scale47Width])
    .heightEqualToWidth()
    .centerYEqualToView(self.contentView).offset(-2.0)
    .leftSpaceToView(self.contentView, [UIAdapter lrGap]);
    self.themLabel.sd_layout
    .topEqualToView(self.contentView)
    .bottomSpaceToView(line, 0.0)
    .leftSpaceToView(self.leftIcon, 5.0);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:100.0 * [UIAdapter Scale47Width]];
    self.input.sd_layout
    .widthIs([UIAdapter deviceWidth]/2.0 - [UIAdapter lrGap])
    .topEqualToView(self.contentView)
    .bottomSpaceToView(line, 0.0)
    .rightSpaceToView(self.contentView, [UIAdapter lrGap]);
    
    line.backgroundColor = [UIAdapter lightGray];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.endInputBlock) {
        self.endInputBlock(textField.text);
    }
}

-(void)setTxt:(NSString *)txt {
    if (txt) {
        _txt = txt;
        self.leftIcon.image = [UIImage imageNamed:@"stress_mark"];
        self.themLabel.text = txt;
    }
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
        _input.delegate = (id)self;
    }
    return _input;
}

@end
