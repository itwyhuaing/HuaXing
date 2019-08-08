//
//  PersonMainView.m
//  HuaXing
//
//  Created by wangyinghua on 2019/7/14.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PersonMainView.h"
#import "BriefInfoHeaderView.h"
#import "BriefInfoCell.h"

@interface PersonMainView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong,readwrite) UITableView *listTable;

@end

@implementation PersonMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.listTable];
        self.listTable.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    }
    return self;
}

#pragma mark ------ setter

-(void)setPm:(PersonDataModel *)pm {
    if (pm && [pm isKindOfClass:[PersonDataModel class]]) {
        _pm = pm;
        [self.listTable reloadData];
    }
}

- (ItemDataModel *)currentModelAtIndexPath:(NSIndexPath *)idx {
    GroupDataModel *gm = self.pm.data[idx.section];
    ItemDataModel  *im = gm.items[idx.row];
    return im;
}

#pragma mark ------ delegate / dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.pm.data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroupDataModel *g = self.pm.data[section];
    return g ? g.items.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BriefInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_BriefInfoCell];
    cell.data = [self currentModelAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BriefInfoHeaderView *bfh = [BriefInfoHeaderView new];
    return bfh;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = [tableView cellHeightForIndexPath:indexPath model:[self currentModelAtIndexPath:indexPath] keyPath:@"data" cellClass:[BriefInfoCell class] contentViewWidth:[UIAdapter deviceWidth]];
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    if (_delegate && [_delegate respondsToSelector:@selector(personMainView:didSelectedAtIndexPath:)]) {
        [_delegate personMainView:self didSelectedAtIndexPath:indexPath];
    }
}

#pragma mark ------ lazy load

-(UITableView *)listTable {
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTable.delegate = (id)self;
        _listTable.dataSource = (id)self;
        [_listTable registerClass:[BriefInfoCell class] forCellReuseIdentifier:cell_BriefInfoCell];
        _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTable.bounces = FALSE;
        _listTable.backgroundColor = [UIAdapter lightGray];
    }
    return _listTable;
}

@end
