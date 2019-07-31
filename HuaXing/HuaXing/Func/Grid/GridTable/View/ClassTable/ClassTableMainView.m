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
//#import "ClassTableClassItemCollectionView.h"
//#import "ClassTableHeaderCollectionView.h"

@interface ClassTableMainView ()<UITableViewDelegate,UITableViewDataSource>
{
    // 行高
    CGFloat heightForTableHeader;
    CGFloat heightForTableCommonRow;
    
    // 列宽
    CGFloat widthForFirstVerticalRow;
    CGFloat widthForCommonVerticalRow;
}
// 课表每天课程数据
@property (nonatomic,strong) NSArray<ClassItemDataModel *>      *ds_classItems;
// 序列化信息数据
@property (nonatomic,strong) NSArray<SequenceItemModel *>       *ds_sequences;


// 数据表
@property (nonatomic,strong) UITableView                        *table;
@property (nonatomic,strong) ClassTableHeaderView               *headerView;

@end

@implementation ClassTableMainView

#pragma mark --- life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.table];
    }
    return self;
}


-(void)layoutSubviews {
    // 初始化参数
    // 数据源
    if (_dataSource && [_dataSource respondsToSelector:@selector(datasInClassTableMainView:)]) {
        self.ds_classItems = [_dataSource datasInClassTableMainView:self];
    }
    if (_dataSource && [_dataSource respondsToSelector:@selector(datasOfFirstVerticalRowInClassTableMainView:)]) {
        self.ds_sequences = [_dataSource datasOfFirstVerticalRowInClassTableMainView:self];
    }
    // 第一行高度
    if (_dataSource && [_dataSource respondsToSelector:@selector(heightForFirstHorizontalRowInClassTableMainView:)]) {
        heightForTableHeader = [_dataSource heightForFirstHorizontalRowInClassTableMainView:self];
    }
    // 其他行高度
    if (_dataSource && [_dataSource respondsToSelector:@selector(heightForCommonHorizontalRowInClassTableMainView:)]) {
        heightForTableCommonRow = [_dataSource heightForCommonHorizontalRowInClassTableMainView:self];
    }
    // 第一列宽度
    if (_dataSource && [_dataSource respondsToSelector:@selector(widthForFirstVerticalRowInClassTableMainView:)]) {
        widthForFirstVerticalRow = [_dataSource widthForFirstVerticalRowInClassTableMainView:self];
    }
    // 其他列宽度
    if (_dataSource && [_dataSource respondsToSelector:@selector(widthForCommonVerticalRowInClassTableMainView:)]) {
        widthForCommonVerticalRow = [_dataSource widthForCommonVerticalRowInClassTableMainView:self];
    }
    // Table 尺寸设置
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    [self.table setFrame:rect];
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ds_sequences ? self.ds_sequences.count+kExtraCount : kExtraCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ClassTableCell.class)];
    // 通知位置
    cell.currentIndexPathForCell = indexPath.row;
    // cell 所需的尺寸数据
    [cell updateFrameWithCellWidth:CGRectGetWidth(self.table.frame)
                        cellHeight:heightForTableCommonRow
   widthForFirstVertivalRowInTable:widthForFirstVerticalRow
   widthForOtherVertivalRowInTable:widthForCommonVerticalRow];
    // cell 所需的数据源数据
    [cell updateCellWithSequences:self.ds_sequences classData:self.ds_classItems];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // headerView 所需的尺寸数据
    [self.headerView updateFrameWithTableHeaderWidth:CGRectGetWidth(self.table.frame)
                                   tableHeaderHeight:heightForTableHeader
                     widthForFirstVertivalRowInTable:widthForFirstVerticalRow
                     widthForOtherVertivalRowInTable:widthForCommonVerticalRow];
    // headerView 所需的数据源数据
    [self.headerView updateTableHeaderWithClassData:self.ds_classItems];
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return heightForTableHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heightForTableCommonRow;
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
