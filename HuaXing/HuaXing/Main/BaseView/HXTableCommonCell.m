//
//  HXTableCommonCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXTableCommonCell.h"

@implementation CommonCellTypeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@interface HXTableCommonCell ()

@property (nonatomic,strong)    UIImageView     *leftIcon;

@property (nonatomic,strong)    UILabel         *themLabel;

@property (nonatomic,strong)    UILabel         *detailLabel;

@property (nonatomic,strong)    UIImageView     *righIcon;

@property (nonatomic,strong)    UIView          *line;

@end

@implementation HXTableCommonCell


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
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.righIcon];
    [self.contentView addSubview:self.line];
    
    // 四个控件约束相互独立
    
    CGFloat iconWH = 16.0 * [UIAdapter Scale47Width];
    
    self.line.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1.0);
    
    self.leftIcon.sd_layout
    .leftSpaceToView(self.contentView, [UIAdapter lrGap])
    .centerYEqualToView(self.contentView)
    .widthIs(iconWH)
    .heightEqualToWidth();
    
    self.righIcon.sd_layout
    .rightSpaceToView(self.contentView, [UIAdapter lrGap])
    .centerYEqualToView(self.contentView)
    .widthIs(iconWH)
    .heightEqualToWidth();
    
    self.detailLabel.sd_layout
    .topEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, 1.0)
    .rightSpaceToView(self.contentView, 8.0 * [UIAdapter Scale47Width] + iconWH + [UIAdapter lrGap]);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:100.0 * [UIAdapter Scale47Width]];
    
    self.themLabel.sd_layout
    .topEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, 1.0)
    .leftSpaceToView(self.leftIcon, 10.0 * [UIAdapter Scale47Width]);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:100.0 * [UIAdapter Scale47Width]];
}

-(void)setModel:(CommonCellTypeModel *)model {
    if (model) {
        _model = model;
        self.themLabel.text = model.them;
        self.detailLabel.text = model.detail;
        self.leftIcon.image = [UIImage imageNamed:model.leftIconName];
        self.righIcon.image = [UIImage imageNamed:model.rightIconName];
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

-(UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = [UIAdapter lightTintBlack];
        _detailLabel.font      = [UIAdapter font15];
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

-(UIImageView *)righIcon {
    if (!_righIcon) {
        _righIcon = [UIImageView new];
        _righIcon.contentMode = UIViewContentModeScaleAspectFill;
        _righIcon.clipsToBounds = TRUE;
    }
    return _righIcon;
}

-(UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIAdapter lineGray];
    }
    return _line;
}

@end
