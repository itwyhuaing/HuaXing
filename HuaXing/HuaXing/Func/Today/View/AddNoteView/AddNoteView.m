//
//  AddNoteView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddNoteView.h"

@interface AddNoteView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@end

@implementation AddNoteView


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
}

-(void)layoutSubviews {
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    rect.size.height = 300.f;
    [self.table setFrame:rect];
}

//- (void)confirmEvent:(UIButton *)sender {
//    [self resignFirstResponderForCell];
//    if (_delegate && [_delegate respondsToSelector:@selector(AddNoteView:didClickEvent:)]) {
//        [_delegate AddNoteView:self didClickEvent:sender];
//    }
//}

- (void)resignFirstResponderForCell {
    NSArray *cls = self.table.visibleCells;
    if (cls) {
        for (NSInteger cou = 0; cou < cls.count; cou ++) {
            UITableViewCell *cell = cls[cou];
            if ([cell isKindOfClass:[AddNoteNameCell class]]) {
                AddNoteNameCell *theCell = (AddNoteNameCell *)cell;
                [theCell endEdit];
            }
        }
    }
}

#pragma mark ---- delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ds ? self.ds.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *rtnCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (self.ds && self.ds.count > indexPath.row) {
        HXWeakSelf
        id model = self.ds[indexPath.row];
        if ([model isKindOfClass:[InputCellTypeModel class]]) {
            AddNoteNameCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddNoteNameCell.class)];
            cell.model = model;
            rtnCell = cell;
            
            // 点击事件
            cell.endInputBlock = ^(NSString * _Nonnull rlt) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addNoteView:inputCnt:)]) {
                    [weakSelf.delegate addNoteView:self inputCnt:rlt];
                }
            };
            
        }else if ([model isKindOfClass:[CommonCellTypeModel class]]) {
            AddNoteTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddNoteTimeCell.class)];
            cell.model = model;
            rtnCell = cell;
        }
    }
    rtnCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rtnCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self resignFirstResponderForCell];
    if (self.ds && self.ds.count > indexPath.row) {
        id model = self.ds[indexPath.row];
        if ([model isKindOfClass:[CommonCellTypeModel class]]) {
            if (_delegate && [_delegate respondsToSelector:@selector(addNoteView:didSelectedTimeAtIndexPath:)]) {
                [_delegate addNoteView:self didSelectedTimeAtIndexPath:indexPath];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = 0.f;
    if (self.ds && self.ds.count > indexPath.row) {
        h = 44.0;
    }
    return h;
}

#pragma mark ---- lazy load

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        [_table registerClass:[AddNoteNameCell class] forCellReuseIdentifier:NSStringFromClass(AddNoteNameCell.class)];
        [_table registerClass:[AddNoteTimeCell class] forCellReuseIdentifier:NSStringFromClass(AddNoteTimeCell.class)];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = (id)self;
        _table.dataSource = (id)self;
        //_table.backgroundColor = [UIColor redColor];
    }
    return _table;
}

@end
