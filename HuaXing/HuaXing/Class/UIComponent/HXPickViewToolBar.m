//
//  HXPickViewToolBar.m
//  HuaXing
//
//  Created by wangyinghua on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXPickViewToolBar.h"

@interface HXPickViewToolBar ()

@property (nonatomic,strong)    UILabel         *themLabel;

@end

@implementation HXPickViewToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    self.themLabel = [UILabel new];
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.themLabel];
    [self addSubview:cancelBtn];
    [self addSubview:confirmBtn];
    
    //
    cancelBtn.sd_layout
    .leftEqualToView(self)
    .bottomEqualToView(self)
    .topEqualToView(self)
    .widthIs(60.0);
    self.themLabel.sd_layout
    .leftSpaceToView(cancelBtn, 0.0)
    .rightSpaceToView(confirmBtn, 0.0)
    .bottomEqualToView(self)
    .bottomEqualToView(self);
    confirmBtn.sd_layout
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .topEqualToView(self)
    .widthIs(60.0);
    
    self.backgroundColor = [UIColor whiteColor];
    self.themLabel.textAlignment = NSTextAlignmentCenter;
    self.themLabel.textColor = [UIAdapter mainBlue];
    self.themLabel.font = [UIAdapter font17];
    self.themLabel.text = @"请选择";
    [self modifyButton:cancelBtn title:@"取消" tag:kBUuttonCancelTag titileColor:[UIColor redColor]];
    [self modifyButton:confirmBtn title:@"确定" tag:kBUuttonConfirmTag titileColor:[UIColor blackColor]];
}

- (void)modifyButton:(UIButton *)btn title:(NSString *)title tag:(NSInteger)tag titileColor:(UIColor *)clr {
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:clr forState:UIControlStateNormal];
    btn.titleLabel.font = [UIAdapter font17];
    btn.tag = tag;
    [btn addTarget:self action:@selector(eventClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateThem:(NSString *)them {
    if (them) {
        self.themLabel.text = them;
    }
}

-(void)eventClick:(UIButton *)sender {
    if (self.eventBlock) {
        self.eventBlock(sender.tag);
    }
}

@end
