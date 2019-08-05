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
}

-(void)layoutSubviews {
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    [self.table setFrame:rect];
}

#pragma mark ---- delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ds ? self.ds.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddCourseInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCourseInputCell.class)];
    cell.txt = self.ds[indexPath.row];
    HXWeakSelf
    cell.endInputBlock = ^(NSString * _Nonnull rlt) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addCourseView:didSelectedAtIndexpath:inputCnt:)]) {
            [weakSelf.delegate addCourseView:self didSelectedAtIndexpath:indexPath inputCnt:rlt];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
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

@end
