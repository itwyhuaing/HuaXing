//
//  CourseConfigView.m
//  HuaXing
//
//  Created by wangyinghua on 2019/7/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseConfigView.h"

@interface HeaderView ()

@property (nonatomic,strong) UILabel        *themLabel;
@property (nonatomic,strong) UITextField    *courseCountField;

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.themLabel];
    [self addSubview:self.courseCountField];
    self.themLabel.sd_layout
    .leftSpaceToView(self, [UIAdapter lrGap])
    .topEqualToView(self)
    .bottomEqualToView(self);
    [self.themLabel setSingleLineAutoResizeWithMaxWidth:60.0];
    self.courseCountField.sd_layout
    .rightSpaceToView(self, [UIAdapter lrGap])
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(60.0);
}

-(UILabel *)themLabel {
    if (!_themLabel) {
        _themLabel = [UILabel new];
        _themLabel.font = [UIAdapter font15];
        _themLabel.textColor = [UIAdapter lightBlack];
    }
    return _themLabel;
}

-(UITextField *)courseCountField {
    if (!_courseCountField) {
        _courseCountField = [UITextField new];
        _courseCountField.keyboardType = UIKeyboardTypeNumberPad;
        _courseCountField.placeholder = @"请输入有几节课";
        _courseCountField.font = [UIAdapter font15];
        _courseCountField.textColor = [UIAdapter lightBlack];
    }
    return _courseCountField;
}

@end

@interface CourseConfigView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@end

@implementation CourseConfigView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.table];
    self.table.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"S:%ld - R:%ld",indexPath.section,indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *hv = [UIButton buttonWithType:UIButtonTypeCustom];
    [hv addTarget:self action:@selector(eventClick:) forControlEvents:UIControlEventTouchUpInside];
    hv.tag = section;
    hv.backgroundColor = section  == 0 ? [UIColor redColor] : [UIColor orangeColor];
    return hv;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *fv = [UIView new];
    fv.backgroundColor = [UIColor orangeColor];
    return fv;
}

- (void)eventClick:(UIButton *)btn {
    NSLog(@" \n %s - %ld \n ",__FUNCTION__,btn.tag);
}

#pragma mark ------ lazy load

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = (id)self;
        _table.dataSource = (id)self;
    }
    return _table;
}

@end
