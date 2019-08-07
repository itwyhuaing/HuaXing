//
//  ClassTableMainView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "ClassTableMainView.h"
#import "ClassTableHeaderView.h"
#import "ClassTableCell.h"

@interface ClassTableMainView ()<UITableViewDelegate,UITableViewDataSource>

// 数据表
@property (nonatomic,strong) UITableView                        *table;
@property (nonatomic,strong) ClassTableHeaderView               *headerView;

// 通知标识
@property (nonatomic,copy)   NSString   *notificationName;


@end

@implementation ClassTableMainView

#pragma mark --- life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _notificationName = [NSString stringWithFormat:@"%@_%p",NSStringFromClass(self.class),self];
        NSLog(@" \n %s \n %@ \n ",__FUNCTION__,_notificationName);
        [self addSubview:self.table];
    }
    return self;
}


-(void)layoutSubviews {
    // Table 尺寸设置
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    [self.table setFrame:rect];
}


#pragma mark --- 代理取值

// 第一行高度
- (CGFloat)heightForTableHeader {
    CGFloat rlt = 0.0;
    if (_dataSource && [_dataSource respondsToSelector:@selector(heightForFirstHorizontalRowInClassTableMainView:)]) {
        rlt = [_dataSource heightForFirstHorizontalRowInClassTableMainView:self];
    }
    return rlt;
}

// 其他行高度
- (CGFloat)heightForTableCommonRow {
    CGFloat rlt = 0.0;
    if (_dataSource && [_dataSource respondsToSelector:@selector(heightForCommonHorizontalRowInClassTableMainView:)]) {
        rlt = [_dataSource heightForCommonHorizontalRowInClassTableMainView:self];
    }
    return rlt;
}

// 第一列宽度
- (CGFloat)widthForFirstVerticalRow {
    CGFloat rlt = 0.0;
    if (_dataSource && [_dataSource respondsToSelector:@selector(widthForFirstVerticalRowInClassTableMainView:)]) {
        rlt = [_dataSource widthForFirstVerticalRowInClassTableMainView:self];
    }
    return rlt;
}

// 其他列宽度
- (CGFloat)widthForCommonVerticalRow {
    CGFloat rlt = 0.0;
    if (_dataSource && [_dataSource respondsToSelector:@selector(widthForCommonVerticalRowInClassTableMainView:)]) {
        rlt = [_dataSource widthForCommonVerticalRowInClassTableMainView:self];
    }
    return rlt;
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.ds_sequences ? 1 : 0;
}

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ds_sequences ? self.ds_sequences.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ClassTableCell.class)];
    // 通知标识
    cell.notificationName = self.notificationName;
    // 记录位置
    cell.currentIndexForCell = indexPath.row;
    // cell 所需的尺寸数据
    [cell updateFrameWithCellWidth:CGRectGetWidth(self.table.frame)
                        cellHeight:[self heightForTableCommonRow]
   widthForFirstVertivalRowInTable:[self widthForFirstVerticalRow]
   widthForOtherVertivalRowInTable:[self widthForCommonVerticalRow]];
    // cell 所需的数据源数据
    [cell updateCellWithSequences:self.ds_sequences classData:self.ds_classItems];
    // 点击回调
    HXWeakSelf
    cell.itemSelectedBlock = ^(HXLocation location) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(classTableMainView:didSelectItemAtLocation:)]) {
            [weakSelf.delegate classTableMainView:self didSelectItemAtLocation:location];
        }
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 通知标识
    self.headerView.notificationName = self.notificationName;
    // headerView 所需的尺寸数据
    [self.headerView updateFrameWithTableHeaderWidth:CGRectGetWidth(self.table.frame)
                                   tableHeaderHeight:[self heightForTableHeader]
                     widthForFirstVertivalRowInTable:[self widthForFirstVerticalRow]
                     widthForOtherVertivalRowInTable:[self widthForCommonVerticalRow]];
    // headerView 所需的数据源数据
    [self.headerView updateTableHeaderWithClassData:self.ds_classItems];
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self heightForTableHeader];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForTableCommonRow];
}


#pragma mark --- reload View

- (void)reloadClassTalbe {
    [self.table reloadData];
}

#pragma mark --- lazy load

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_table registerClass:[ClassTableCell class] forCellReuseIdentifier:NSStringFromClass(ClassTableCell.class)];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.bounces        = FALSE;
        _table.delegate       = (id)self;
        _table.dataSource     = (id)self;
    }
    return _table;
}

-(ClassTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ClassTableHeaderView alloc] init];
    }
    return _headerView;
}

@end
