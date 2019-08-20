//
//  HXTableInputCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXTableInputCell.h"

@implementation InputCellTypeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end


@interface HXTableInputCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView    *leftIcon;

@property (nonatomic,strong) UILabel        *themLabel;

@property (nonatomic,strong) UITextField    *input;

@property (nonatomic,strong) UIView         *line;

@end

@implementation HXTableInputCell


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
    [self.contentView addSubview:self.line];
    
    // 四个控件约束相互独立
    
    self.line.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1.0);
    
    self.leftIcon.sd_layout
    .leftSpaceToView(self.contentView, [UIAdapter lrGap])
    .centerYEqualToView(self.contentView)
    .widthIs(16.0 * [UIAdapter Scale47Width])
    .heightEqualToWidth();
    
    self.input.sd_layout
    .widthIs([UIAdapter deviceWidth]/2.0 - [UIAdapter lrGap])
    .topEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, 1.0)
    .rightSpaceToView(self.contentView, [UIAdapter lrGap]);
    
    self.themLabel.sd_layout
    .topEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, 1.0)
    .leftSpaceToView(self.leftIcon, 10.0 * [UIAdapter Scale47Width]);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:100.0 * [UIAdapter Scale47Width]];
}

+ (CGFloat)cellHeight {
    return 44.0;
}

- (void)endEdit {
    [self.input resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.endInputBlock) {
        self.endInputBlock(textField.text);
    }
}

-(void)setModel:(InputCellTypeModel *)model {
    if (model) {
        _model = model;
        self.leftIcon.image = [UIImage imageNamed:model.leftIconName];
        self.themLabel.text = model.them;
        self.input.placeholder = model.placeHolder;

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
        _themLabel.textColor = [UIAdapter lightTintBlack];
        _themLabel.font      = [UIAdapter font15];
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

-(UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIAdapter lineGray];
    }
    return _line;
}

@end
