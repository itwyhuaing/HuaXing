//
//  BriefInfoCell.m
//  HuaXing
//
//  Created by wangyinghua on 2019/7/14.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "BriefInfoCell.h"

@interface BriefInfoCell ()

@property (nonatomic,strong)    UILabel         *themLabel;
@property (nonatomic,strong)    UILabel         *detailLabel;
@property (nonatomic,strong)    UIImageView     *iconImgV;

@end

@implementation BriefInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UILabel *line = [UILabel new];
    [self.contentView addSubview:self.themLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.iconImgV];
    [self.contentView addSubview:line];
    line.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1.0);
    self.themLabel.sd_layout
    .leftEqualToView(self.contentView).offset(20.0)
    .topEqualToView(self.contentView)
    .bottomEqualToView(line);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:100.0 * [UIAdapter Scale47Width]];
    self.iconImgV.sd_layout
    .rightSpaceToView(self.contentView, 24.0 * [UIAdapter Scale47Width])
    .widthIs(5.0 * [UIAdapter Scale47Width])
    .heightIs(9.0 * [UIAdapter Scale47Width])
    .centerYEqualToView(self.contentView);
    self.detailLabel.sd_layout
    .leftSpaceToView(self.themLabel, 10.0)
    .rightSpaceToView(self.iconImgV, 10.0)
    .topEqualToView(self.contentView)
    .bottomEqualToView(line);
    [self setupAutoHeightWithBottomView:self.themLabel bottomMargin:0.0];
    
    self.themLabel.font                         = [UIFont systemFontOfSize:15.0];
    self.themLabel.textColor                    = [UIColor colorWithHexString:@"#333333" alpha:1.0];
    self.detailLabel.font                         = [UIFont systemFontOfSize:15.0];
    self.detailLabel.textColor                    = [UIColor colorWithHexString:@"#333333" alpha:1.0];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    line.backgroundColor = [UIColor colorWithHexString:@"#EDEDED" alpha:1.0];
}

-(void)setData:(ItemDataModel *)data {
    if (data) {
        _data = data;
        self.themLabel.text = data.themTxt;
        self.detailLabel.text = data.detailTxt;
        self.iconImgV.image = [UIImage imageNamed:data.rightIConName];
        
//        self.themLabel.backgroundColor = [UIColor redColor];
//        self.detailLabel.backgroundColor = [UIColor orangeColor];
//        self.iconImgV.backgroundColor = [UIColor cyanColor];
    }
}

-(UILabel *)themLabel {
    if (!_themLabel) {
        _themLabel = [UILabel new];
    }
    return _themLabel;
}

-(UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
    }
    return _detailLabel;
}

-(UIImageView *)iconImgV {
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
    }
    return _iconImgV;
}

@end
