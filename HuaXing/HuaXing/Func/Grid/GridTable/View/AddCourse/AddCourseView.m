//
//  AddCourseView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/2.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddCourseView.h"
#import "AddCourseInputCell.h"

@interface AddCourseView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) UIView     *confirmView;
@property (nonatomic,strong) UIButton   *cfmButton;

@end


@implementation AddCourseView

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
    [self.confirmView addSubview:self.cfmButton];
}

-(void)layoutSubviews {
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    [self.table setFrame:rect];
}

- (void)confirmEvent:(UIButton *)sender {
    [self resignFirstResponderForCell];
    if (_delegate && [_delegate respondsToSelector:@selector(addCourseView:didClickEvent:)]) {
        [_delegate addCourseView:self didClickEvent:sender];
    }
}

- (void)resignFirstResponderForCell {
    NSArray *cls = self.table.visibleCells;
    if (cls) {
        for (NSInteger cou = 0; cou < cls.count; cou ++) {
            AddCourseInputCell *cell = (AddCourseInputCell *)cls[cou];
            [cell endEdit];
        }
    }
}

#pragma mark ---- delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ds ? self.ds.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddCourseInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCourseInputCell.class)];
    if (self.ds && self.ds.count > indexPath.row) {
        [cell modifyCellWithModel:self.ds[indexPath.row]];
    }
    HXWeakSelf
    cell.endInputBlock = ^(NSString * _Nonnull rlt) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addCourseView:didSelectedAtIndexpath:inputCnt:)]) {
            [weakSelf.delegate addCourseView:self didSelectedAtIndexpath:indexPath inputCnt:rlt];
        }
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.confirmView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80.0 * [UIAdapter Scale47Width];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0 * [UIAdapter Scale47Width];
}

#pragma mark ---- lazy load

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_table registerClass:[AddCourseInputCell class] forCellReuseIdentifier:NSStringFromClass(AddCourseInputCell.class)];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = (id)self;
        _table.dataSource = (id)self;
    }
    return _table;
}

-(UIView *)confirmView {
    if (!_confirmView) {
        _confirmView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], 80.0 * [UIAdapter Scale47Width])];
        _confirmView.backgroundColor = [UIColor whiteColor];
    }
    return _confirmView;
}

-(UIButton *)cfmButton {
    if (!_cfmButton) {
        _cfmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cfmButton setFrame:CGRectMake(20.0, 15.0, [UIAdapter deviceWidth] - 40.0, 50.0 * [UIAdapter Scale47Width])];
        [_cfmButton setTitle:@"确  定" forState:UIControlStateNormal];
        [_cfmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cfmButton.titleLabel.font = [UIAdapter font15];
        _cfmButton.backgroundColor = [UIAdapter mainBlue];
        _cfmButton.layer.cornerRadius = 6.0;
        _cfmButton.layer.masksToBounds = TRUE;
        [_cfmButton addTarget:self action:@selector(confirmEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cfmButton;
}

@end
