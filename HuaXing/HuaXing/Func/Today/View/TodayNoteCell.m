//
//  TodayNoteCell.m
//  HuaXing
//
//  Created by wangyinghua on 2019/8/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TodayNoteCell.h"

@interface TodayNoteCell ()

@property (nonatomic,strong) UILabel *themLabel;

@property (nonatomic,strong) UIImageView *blockImageV;

@property (nonatomic,strong) UILabel *briefLabel;

@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UIButton *unfoldButton;

@property (nonatomic,strong) UIButton *editButton;

@property (nonatomic,strong) UIView   *line;

@end

@implementation TodayNoteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    [self.contentView addSubview:self.themLabel];
    [self.contentView addSubview:self.blockImageV];
    [self.contentView addSubview:self.briefLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.unfoldButton];
    [self.contentView addSubview:self.editButton];
    //[self.contentView addSubview:self.line];
    
    self.themLabel.sd_layout
    .topSpaceToView(self.contentView, 15.0 * [UIAdapter Scale47Width])
    .leftSpaceToView(self.contentView, 10.0 * [UIAdapter Scale47Width])
    //.widthIs(33.0 * [UIAdapter Scale47Width])
    .heightIs(20.0 * [UIAdapter Scale47Width]);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:36.0 * [UIAdapter Scale47Width]];
    
    self.blockImageV.sd_layout
    .centerYEqualToView(self.themLabel)
    .leftSpaceToView(self.themLabel, 10.0 * [UIAdapter Scale47Width])
    .widthIs(10.0 * [UIAdapter Scale47Width])
    .heightIs(10.0 * [UIAdapter Scale47Width]);
    
    self.briefLabel.sd_layout
    .centerYEqualToView(self.themLabel)
    .leftSpaceToView(self.blockImageV, 10.0 * [UIAdapter Scale47Width])
    .rightSpaceToView(self.contentView, 10.0 * [UIAdapter Scale47Width])
    .autoHeightRatio(0.f);
    
    
    self.detailLabel.sd_layout
    .topSpaceToView(self.briefLabel, 6.0 * [UIAdapter Scale47Width])
    .leftEqualToView(self.briefLabel)
    .rightEqualToView(self.briefLabel)
    .autoHeightRatio(0.f);
    
    self.unfoldButton.sd_layout
    .topSpaceToView(self.detailLabel, 5.0 * [UIAdapter Scale47Width])
    .leftEqualToView(self.detailLabel)
    .widthIs(60.0 * [UIAdapter Scale47Width])
    .heightIs(20.0 * [UIAdapter Scale47Width]);
    self.unfoldButton.titleLabel.sd_layout
    .topEqualToView(self.unfoldButton)
    .leftEqualToView(self.unfoldButton)
    .bottomEqualToView(self.unfoldButton);
    [self.unfoldButton.titleLabel setSingleLineAutoResizeWithMaxWidth:30.f * [UIAdapter Scale47Width]];
    self.unfoldButton.imageView.sd_layout
    .centerYEqualToView(self.unfoldButton)
    .leftSpaceToView(self.unfoldButton.titleLabel, 0.f)
    .heightRatioToView(self.unfoldButton, 0.8)
    .widthEqualToHeight();
    
    self.editButton.sd_layout
    .topEqualToView(self.unfoldButton)
    .rightEqualToView(self.briefLabel)
    .widthRatioToView(self.unfoldButton, 1.0)
    .heightRatioToView(self.unfoldButton, 1.0);
    self.editButton.imageView.sd_layout
    .centerYEqualToView(self.editButton)
    .heightRatioToView(self.editButton, 0.8)
    .rightEqualToView(self.editButton)
    .widthEqualToHeight();
    self.editButton.titleLabel.sd_layout
    .topEqualToView(self.editButton)
    .bottomEqualToView(self.editButton)
    .leftEqualToView(self.editButton)
    .rightSpaceToView(self.editButton.imageView, 0.f);
    
    // 分割线
//    self.line.sd_layout
//    .topSpaceToView(self.unfoldButton, 10.0 * [UIAdapter Scale47Width])
//    .leftEqualToView(self.contentView)
//    .rightEqualToView(self.contentView)
//    .heightIs(1.0);
//    [self setupAutoHeightWithBottomView:self.line bottomMargin:0.f];

    [self setupAutoHeightWithBottomView:self.unfoldButton bottomMargin:10.0 * [UIAdapter Scale47Width]];
    
    self.unfoldButton.custom_acceptEventInterval = .5;
    self.editButton.custom_acceptEventInterval   = .5;
    [self.unfoldButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.themLabel.backgroundColor   = [UIColor purpleColor];
//    self.briefLabel.backgroundColor  = [UIColor redColor];
//    self.unfoldButton.backgroundColor = [UIColor orangeColor];
//    self.editButton.backgroundColor  = [UIColor orangeColor];
//    self.editButton.titleLabel.backgroundColor = [UIColor cyanColor];
//    self.editButton.imageView.backgroundColor = [UIColor redColor];
}

- (void)clickEvent:(UIButton *)btn {
    NSString *showTxt = self.model.showInfo;
    if (btn.tag == TodayNoteCellEventTypeFold) {
        if (self.foldEventBlock) {
            self.foldEventBlock(showTxt);
        }
    }else {
        if (self.editEventBlock) {
            self.editEventBlock(showTxt);
        }
    }
}


-(void)setModel:(TodayNoteModel *)model {
    if (model) {
        _model = model;
        self.themLabel.text = model.time;
        self.briefLabel.text = model.briefInfo;
        self.detailLabel.text = model.showInfo;
        self.detailLabel.backgroundColor = [UIAdapter normalBackgroudColorGray];
        self.blockImageV.image = [UIImage imageNamed:@"today_note_mark"];
        [self.unfoldButton setTitle:@"展开" forState:UIControlStateNormal];
        [self.unfoldButton setImage:[UIImage imageNamed:model.foldImageName] forState:UIControlStateNormal];
        [self.editButton setImage:[UIImage imageNamed:@"today_note_edit"] forState:UIControlStateNormal];
    }
}

-(UILabel *)themLabel {
    if (!_themLabel) {
        _themLabel = [UILabel new];
        _themLabel.textColor = [UIAdapter lightTintGray];
        _themLabel.font = [UIAdapter font10];
    }
    return _themLabel;
}

-(UIImageView *)blockImageV {
    if (!_blockImageV) {
        _blockImageV = [UIImageView new];
        _blockImageV.contentMode = UIViewContentModeScaleAspectFill;
        _blockImageV.clipsToBounds = TRUE;
    }
    return _blockImageV;
}

-(UILabel *)briefLabel {
    if (!_briefLabel) {
        _briefLabel = [UILabel new];
        _briefLabel.textColor = [UIAdapter lightTintGray];
        _briefLabel.font = [UIAdapter font17_Medium];
        _briefLabel.numberOfLines = 0;
    }
    return _briefLabel;
}

-(UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = [UIAdapter lightTintGray];
        _detailLabel.font = [UIAdapter font15];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

-(UIButton *)unfoldButton {
    if (!_unfoldButton) {
        _unfoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unfoldButton setTitleColor:[UIAdapter lightTintGray] forState:UIControlStateNormal];
        _unfoldButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        _unfoldButton.tag = TodayNoteCellEventTypeFold;
    }
    return _unfoldButton;
}

-(UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitleColor:[UIAdapter lightTintGray] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        _editButton.tag = TodayNoteCellEventTypeEdit;
        _editButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _editButton;
}

-(UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIAdapter lineGray];
    }
    return _line;
}

@end
