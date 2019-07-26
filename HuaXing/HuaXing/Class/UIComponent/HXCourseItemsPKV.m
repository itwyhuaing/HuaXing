//
//  HXCourseItemsPKV.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXCourseItemsPKV.h"
#import "HXPickViewToolBar.h"

@interface HXCourseItemsPKV ()

@property (nonatomic,strong) UIPickerView  *pkv;

@property (nonatomic,strong) HXPickViewToolBar *toolBar;

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
    self.toolBar = [HXPickViewToolBar new];
    [self addSubview:self.pkv];
    [self addSubview:self.toolBar];
    
    //
    self.pkv.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self, 30.0)
    .heightIs(160.0 * [UIAdapter Scale47Width]);
    self.toolBar.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self.pkv, 0)
    .heightIs(40.0 * [UIAdapter Scale47Width]);
    
    self.backgroundColor = [UIAdapter maskLightBlack];
    
    // 点击回调
    HXWeakSelf
    self.toolBar.eventBlock = ^(NSInteger location) {
        NSString *rlt = @"0";
        if (location == kBUuttonConfirmTag) {
            NSLog(@" \n 测试数据 :eventClick \n ");
            NSInteger idx = [weakSelf.pkv selectedRowInComponent:0];
            rlt = self.dataSource[idx];
        }
        if (weakSelf.pkvCompletion) {
            weakSelf.pkvCompletion(rlt);
        }
        [weakSelf dismiss];
    };
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

- (void)showOnSView:(UIView *)sv  barThem:(NSString *)them{
    if (sv) {
        [sv addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    [self.toolBar updateThem:them];
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

