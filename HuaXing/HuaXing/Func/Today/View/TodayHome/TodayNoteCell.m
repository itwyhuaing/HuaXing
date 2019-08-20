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

@property (nonatomic,strong) UIButton *deleteButton;

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
    [self.contentView addSubview:self.deleteButton];
    //[self.contentView addSubview:self.line];
    
    self.themLabel.sd_layout
    .topSpaceToView(self.contentView, [UIAdapter lrGap])
    .leftSpaceToView(self.contentView, [UIAdapter lrGap]/2.0)
    //.widthIs(33.0 * [UIAdapter Scale47Width])
    .heightIs(20.0 * [UIAdapter Scale47Width]);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:36.0 * [UIAdapter Scale47Width]];
    
    self.blockImageV.sd_layout
    .centerYEqualToView(self.themLabel)
    .leftSpaceToView(self.themLabel, [UIAdapter lrGap]/2.0)
    .widthIs([UIAdapter lrGap]/2.0)
    .heightEqualToWidth();
    
    self.briefLabel.sd_layout
    .centerYEqualToView(self.themLabel)
    .leftSpaceToView(self.blockImageV, [UIAdapter lrGap]/2.0)
    .rightSpaceToView(self.contentView, [UIAdapter lrGap]/2.0)
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

    self.deleteButton.sd_layout
    .rightEqualToView(self.briefLabel)
    .topEqualToView(self.unfoldButton)
    .bottomEqualToView(self.unfoldButton)
    .widthEqualToHeight();
    self.deleteButton.imageView.sd_layout
    .centerXEqualToView(self.deleteButton)
    .centerYEqualToView(self.deleteButton)
    .heightRatioToView(self.deleteButton, 0.66)
    .widthEqualToHeight();
    
    self.editButton.sd_layout
    .rightSpaceToView(self.deleteButton, [UIAdapter lrGap])
    .topEqualToView(self.unfoldButton)
    .bottomEqualToView(self.unfoldButton)
    .widthEqualToHeight();
    self.editButton.imageView.sd_layout
    .centerXEqualToView(self.editButton)
    .centerYEqualToView(self.editButton)
    .heightRatioToView(self.editButton, 0.66)
    .widthEqualToHeight();
    
    // 分割线
//    self.line.sd_layout
//    .topSpaceToView(self.unfoldButton, [UIAdapter lrGap])
//    .leftEqualToView(self.contentView)
//    .rightEqualToView(self.contentView)
//    .heightIs(1.0);
//    [self setupAutoHeightWithBottomView:self.line bottomMargin:0.f];

    [self setupAutoHeightWithBottomView:self.unfoldButton bottomMargin:[UIAdapter lrGap]];
    
    self.unfoldButton.custom_acceptEventInterval = .5;
    self.editButton.custom_acceptEventInterval   = .5;
    [self.unfoldButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.themLabel.backgroundColor   = [UIColor purpleColor];
//    self.briefLabel.backgroundColor  = [UIColor redColor];
//    self.unfoldButton.backgroundColor = [UIColor orangeColor];
//    self.editButton.backgroundColor  = [UIColor redColor];
//    self.editButton.titleLabel.backgroundColor = [UIColor cyanColor];
//    self.editButton.imageView.backgroundColor = [UIColor purpleColor];
//    self.deleteButton.backgroundColor = [UIColor redColor];
//    self.deleteButton.imageView.backgroundColor = [UIColor purpleColor];
}

- (void)clickEvent:(UIButton *)btn {
    if (btn.tag == TodayNoteCellEventTypeFold) {
        if (self.foldEventBlock) {
            NSString *showTxt = self.model.showInfo;
            self.foldEventBlock(showTxt);
        }
    }else if (btn.tag == TodayNoteCellEventTypeEdit){
        if (self.editEventBlock) {
            self.editEventBlock(@"");
        }
    }else if (btn.tag == TodayNoteCellEventTypeDelete){
        if (self.deleteEventBlock) {
            self.deleteEventBlock(@"");
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
        [self.deleteButton setImage:[UIImage imageNamed:@"today_note_delete"] forState:UIControlStateNormal];
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
        _editButton.tag = TodayNoteCellEventTypeEdit;
    }
    return _editButton;
}

-(UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.tag = TodayNoteCellEventTypeDelete;
    }
    return _deleteButton;
}

-(UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIAdapter lineGray];
    }
    return _line;
}

@end
