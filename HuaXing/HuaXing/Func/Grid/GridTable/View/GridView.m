//
//  GridView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "GridView.h"
#import "GridTableCell.h"
#import "GridCollectionView.h"

@interface GridView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView            *table;

@property (nonatomic,strong) GridCollectionView     *gcvHeader;

@end


@implementation GridView


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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 160.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.gcvHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_GridTableCell];
    cell.gtcSelectedBlock = ^(NSIndexPath * _Nonnull idx) {
        NSLog(@"\n 行 ： %ld - 列 : %ld \n",indexPath.row,idx.row);
    };
    return cell;
}

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_table registerClass:[GridTableCell class] forCellReuseIdentifier:cell_GridTableCell];
        _table.delegate = (id)self;
        _table.dataSource = (id)self;
    }
    return _table;
}

-(GridCollectionView *)gcvHeader {
    if (!_gcvHeader) {
        _gcvHeader = [[GridCollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], 160.0)];
        _gcvHeader.backgroundColor = [UIColor whiteColor];
    }
    return _gcvHeader;
}

@end
