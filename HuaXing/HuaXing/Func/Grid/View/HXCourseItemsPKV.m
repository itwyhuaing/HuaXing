//
//  HXCourseItemsPKV.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXCourseItemsPKV.h"

#define kBUuttonCancelTag 110
#define kBUuttonConfirmTag 111

@interface HXCourseItemsPKV ()

@property (nonatomic,strong) UIPickerView  *pkv;

@end

@implementation HXCourseItemsPKV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = @[@"1",@"2",@"3",
                            @"4",@"5",@"6",
                            @"7",@"8"];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    //
    UIView *bv = [UIView new];
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.pkv];
    [self addSubview:bv];
    [bv addSubview:leftBtn];
    [bv addSubview:rightBtn];
    
    //
    self.pkv.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self, 30.0)
    .heightIs(160.0 * [UIAdapter Scale47Width]);
    bv.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self.pkv, 0)
    .heightIs(40.0 * [UIAdapter Scale47Width]);
    leftBtn.sd_layout
    .leftEqualToView(bv)
    .bottomEqualToView(bv)
    .topEqualToView(bv)
    .widthIs(60.0);
    rightBtn.sd_layout
    .rightEqualToView(bv)
    .bottomEqualToView(bv)
    .topEqualToView(bv)
    .widthIs(60.0);
    
    self.backgroundColor = [UIAdapter maskLightBlack];
    bv.backgroundColor = [UIColor whiteColor];
    [self modifyButton:leftBtn title:@"取消" tag:kBUuttonCancelTag titileColor:[UIColor redColor]];
    [self modifyButton:rightBtn title:@"确定" tag:kBUuttonConfirmTag titileColor:[UIColor blackColor]];
}

- (void)modifyButton:(UIButton *)btn title:(NSString *)title tag:(NSInteger)tag titileColor:(UIColor *)clr {
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:clr forState:UIControlStateNormal];
    btn.titleLabel.font = [UIAdapter font17];
    btn.tag = tag;
    [btn addTarget:self action:@selector(eventClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)eventClick:(UIButton *)sender {
    NSString *rlt = @"0";
    if (sender.tag == kBUuttonConfirmTag) {
        NSLog(@" \n 测试数据 :eventClick \n ");
        NSInteger idx = [self.pkv selectedRowInComponent:0];
        rlt = self.dataSource[idx];
    }
    if (self.pkvCompletion) {
        self.pkvCompletion(rlt);
    }
    [self dismiss];
}

- (void)dealSelectedResult {
    NSInteger idx = [self.pkv selectedRowInComponent:0];
    NSString *rlt = self.dataSource[idx];
    if (self.pkvCompletion) {
        self.pkvCompletion(rlt);
    }
}

-(void)setDataSource:(NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = dataSource;
        [self.pkv reloadAllComponents];
    }
}

- (void)showOnSView:(UIView *)sv {
    if (sv) {
        [sv addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    self.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

-(void)dismiss {
    [self removeFromSuperview];
}

#pragma mark ------ UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return [UIAdapter deviceWidth];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@" \n 测试数据 : didSelectRow \n ");
    [self dealSelectedResult];
}

-(UIPickerView *)pkv {
    if (!_pkv) {
        _pkv = [UIPickerView new];
        _pkv.backgroundColor = [UIColor whiteColor];
        _pkv.delegate = (id)self;
    }
    return _pkv;
}

@end

