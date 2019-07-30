//
//  ClassTableMainView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "ClassTableMainView.h"
#import "ClassTableCell.h"
#import "ClassTableClassItemCollectionView.h"
#import "ClassTableHeaderCollectionView.h"

@interface ClassTableMainView ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat heightForTableHeader;
    CGFloat heightForTableCommonRow;
}

@property (nonatomic,strong) UITableView                        *table;

//@property (nonatomic,strong) ClassTableHeaderCollectionView     *ctHeader;
@property (nonatomic,strong) ClassTableClassItemCollectionView     *ctHeader;

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
    // 初始化一些尺寸参数
    // 第一行高度
    if (_dataSource && [_dataSource respondsToSelector:@selector(heightForFirstHorizontalRowInClassTableMainView:)]) {
        heightForTableHeader = [_dataSource heightForFirstHorizontalRowInClassTableMainView:self];
    }
    // 其他行高度
    if (_dataSource && [_dataSource respondsToSelector:@selector(heightForCommonHorizontalRowInClassTableMainView:)]) {
        heightForTableCommonRow = [_dataSource heightForCommonHorizontalRowInClassTableMainView:self];
    }
    // Table 尺寸设置
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    [self.table setFrame:rect];
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *vrs; // 上午两节，下午两节
    if (_dataSource && [_dataSource respondsToSelector:@selector(datasOfFirstVerticalRowInClassTableMainView:)]) {
        vrs = [_dataSource datasOfFirstVerticalRowInClassTableMainView:self];
    }
    return vrs ? vrs.count+kExtraCount : kExtraCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ClassTableCell.class)];
    if (_dataSource && [_dataSource respondsToSelector:@selector(datasOfFirstHorizontalRowInClassTableMainView:)]) {
        NSArray *hd = [_dataSource datasOfFirstHorizontalRowInClassTableMainView:self];
        cell.itemsCount = hd ? hd.count + kExtraCount : kExtraCount;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor redColor];
    return v;
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

-(ClassTableClassItemCollectionView *)ctHeader {
    if (!_ctHeader) {
        _ctHeader = [[ClassTableClassItemCollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], heightForTableHeader)];
        _ctHeader.backgroundColor = [UIColor whiteColor];
    }
    return _ctHeader;
}

@end
