//
//  HXPickView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/17.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXPickView.h"

@interface HXPickView ()

@property (nonatomic,strong) UIDatePicker *dp;

@end

@implementation HXPickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    //
    self.dp = [UIDatePicker new];
    UIView *bv = [UIView new];
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.dp];
    [self addSubview:bv];
    [bv addSubview:leftBtn];
    [bv addSubview:rightBtn];
    
    //
    self.dp.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(230.0 * [UIAdapter Scale47Width]);
    bv.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self.dp, 0)
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
    
    self.backgroundColor = [UIColor colorWithHexString:@"#000" alpha:0.3];
    self.dp.backgroundColor = [UIColor whiteColor];
    self.dp.datePickerMode = UIDatePickerModeDate;
    self.dp.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    [self modifyButton:leftBtn title:@"取消" tag:100 titileColor:[UIColor redColor]];
    [self modifyButton:rightBtn title:@"确定" tag:101 titileColor:[UIColor blackColor]];
    
    bv.backgroundColor = [UIColor whiteColor];
//    leftBtn.backgroundColor = [UIColor greenColor];
//    rightBtn.backgroundColor = [UIColor orangeColor];
    
}

- (void)modifyButton:(UIButton *)btn title:(NSString *)title tag:(NSInteger)tag titileColor:(UIColor *)clr {
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:clr forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    btn.tag = tag;
    [btn addTarget:self action:@selector(eventClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)eventClick:(UIButton *)sender {
    if (sender.tag == 101) {
        [self removeFromSuperview];
        [self dealDate];
    }else {
        [self removeFromSuperview];
    }
}

- (NSString *)dealDate {
    NSDate* date = self.dp.date;
    NSLog(@"%@",[date descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@",[df stringFromDate:date]);
    return [df stringFromDate:date];
}

//-(void)eventClick:(UIButton *)sender {
//    if (sender.tag == 101) {
//        NSDate* date = self.dp.date;
//        NSLog(@"%@",[date descriptionWithLocale:[NSLocale currentLocale]]);
//        NSDateFormatter* df = [[NSDateFormatter alloc] init];
//        df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
//        NSLog(@"%@",[df stringFromDate:date]);
//    }else {
//        [self removeFromSuperview];
//    }
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[self removeFromSuperview];
}

//
//#pragma mark ------ UIPickerViewDelegate,UIPickerViewDataSource
//
//// returns the number of 'columns' to display.
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 3;
//}
//
//// returns the # of rows in each component..
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    NSInteger cnum = 1;
//    if (component == 2) {
//        cnum = 6;
//    }else if (component == 1) {
//        cnum = 6;
//    }
//    return cnum;
//}
//
//
//// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return [UIAdapter deviceWidth]/3.0;
//}
//
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
//    return 60.0;
//}
//
//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [NSString stringWithFormat:@"C%ld-R%ld",component,row];
//}
//
////- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component  {
////
////}
//
////- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
////    UIView *rv = [UIView ];
////}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSLog(@"\n didSelectRow \n");
//}
//

@end
