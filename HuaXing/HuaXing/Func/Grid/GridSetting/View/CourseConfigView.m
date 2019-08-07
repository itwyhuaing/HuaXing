//
//  CourseConfigView.m
//  HuaXing
//
//  Created by wangyinghua on 2019/7/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseConfigView.h"
#import "CourseHeaderView.h"
#import "HXCourseItemsPKV.h"
#import "CourseTimeInfoCell.h"

@interface CourseConfigView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) CourseHeaderView  *dateHv;

@property (nonatomic,strong) CourseHeaderView  *amHv;

@property (nonatomic,strong) CourseHeaderView  *pmHv;

// 数据
@property (nonatomic,strong) NSMutableArray<ItemTimeModel *> *amItems;
@property (nonatomic,strong) NSMutableArray<ItemTimeModel *> *pmItems;

@end

@implementation CourseConfigView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _amItems = [NSMutableArray new];
        _pmItems = [NSMutableArray new];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.table];
    self.table.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

- (void)updateTableWithCourseItems:(NSString *)itemsCount section:(NSInteger)section {
    // 数据组装
    if (section == CourseConfigViewHeaderAMLocation) {
        [self fillTheArr:self.amItems count:[itemsCount integerValue]];
    }else if (section == CourseConfigViewHeaderPMLocation) {
        [self fillTheArr:self.pmItems count:[itemsCount integerValue]];
    }
    // 刷新
    [self.table reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)fillTheArr:(NSMutableArray *)data count:(NSInteger)cou{
    [data removeAllObjects];
    for (NSInteger s = 0; s < cou; s ++) {
        ItemTimeModel *f = [ItemTimeModel new];
        f.themTxt = [NSString stringWithFormat:@"第%ld节",s + 1];
        f.detailTxt = @"点击设置课程时间";
        f.rightIConName = @"personal_arrow";
        [data addObject:f];
    }
}

- (void)updateHeaderViewWithThem:(nullable NSString *)them tipMessage:(NSString *)msg section:(NSInteger)section {
    if (section == CourseConfigViewHeaderAMLocation) {
        [self.amHv updateContentWithThem:them tipMessage:msg];
    }else if (section == CourseConfigViewHeaderPMLocation){
        [self.pmHv updateContentWithThem:them tipMessage:msg];
    }else if (section == CourseConfigViewHeaderCourseDateLocation){
        [self.dateHv updateContentWithThem:them tipMessage:msg];
    }
}

-(void)updateTableWithItemModel:(ItemTimeModel *)model cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (model) {
        if (indexPath.section == CourseConfigViewHeaderAMLocation) {
            [self.amItems replaceObjectAtIndex:indexPath.row withObject:model];
        }else if (indexPath.section == CourseConfigViewHeaderPMLocation){
            [self.pmItems replaceObjectAtIndex:indexPath.row withObject:model];
        }
        [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return CourseConfigViewHeaderLocationCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger items = 0;
    if (section == CourseConfigViewHeaderAMLocation) {
        items = self.amItems.count;
    }else if (section == CourseConfigViewHeaderPMLocation){
        items = self.pmItems.count;
    }
    return items;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseTimeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_CourseTimeInfoCell];
    if (indexPath.section == CourseConfigViewHeaderAMLocation) {
        cell.data = self.amItems[indexPath.row];
    }else if (indexPath.section == CourseConfigViewHeaderPMLocation){
        cell.data = self.pmItems[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTimeModel *dataModel = [ItemTimeModel new];
    if (indexPath.section == CourseConfigViewHeaderAMLocation) {
        dataModel = self.amItems[indexPath.row];
    }else if (indexPath.section == CourseConfigViewHeaderPMLocation){
        dataModel = self.pmItems[indexPath.row];
    }
    return [tableView cellHeightForIndexPath:indexPath model:dataModel keyPath:@"data" cellClass:[CourseTimeInfoCell class] contentViewWidth:[UIAdapter deviceWidth]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *hv = self.dateHv;
    if (section == CourseConfigViewHeaderAMLocation) {
        hv = self.amHv;
    }else if (section == CourseConfigViewHeaderPMLocation){
        hv = self.pmHv;
    }
    return hv;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *fv = [UIView new];
    //fv.backgroundColor = [UIColor orangeColor];
    return fv;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    if (_delegate && [_delegate respondsToSelector:@selector(courseConfigView:cellModel:didSelectRowAtIndexPath:)]) {
        ItemTimeModel *f = [ItemTimeModel new];
        if (indexPath.section == CourseConfigViewHeaderAMLocation) {
            f = self.amItems[indexPath.row];
        }else if (indexPath.section == CourseConfigViewHeaderPMLocation){
            f = self.pmItems[indexPath.row];
        }
        [_delegate courseConfigView:self cellModel:f didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark ------ lazy load

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSelectionStyleNone;
        [_table registerClass:[CourseTimeInfoCell class] forCellReuseIdentifier:cell_CourseTimeInfoCell];
        _table.bounces = FALSE;
        _table.delegate = (id)self;
        _table.dataSource = (id)self;
    }
    return _table;
}

-(CourseHeaderView *)dateHv {
    if (!_dateHv) {
        _dateHv = [CourseHeaderView new];
        [_dateHv updateContentWithThem:@"开课日期 ?" tipMessage:@"点击选择"];
        HXWeakSelf
        _dateHv.headerEventBlock = ^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigView:headerEventLocation:)]) {
                [weakSelf.delegate courseConfigView:weakSelf headerEventLocation:CourseConfigViewHeaderCourseDateLocation];
            }
        };
    }
    return _dateHv;
}

-(CourseHeaderView *)amHv {
    if (!_amHv) {
        _amHv = [CourseHeaderView new];
        [_amHv updateContentWithThem:@"上午最多几节课 ？" tipMessage:@"点击选择"];
        HXWeakSelf
        _amHv.headerEventBlock = ^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigView:headerEventLocation:)]) {
                [weakSelf.delegate courseConfigView:weakSelf headerEventLocation:CourseConfigViewHeaderAMLocation];
            }
        };
    }
    return _amHv;
}

-(CourseHeaderView *)pmHv {
    if (!_pmHv) {
        _pmHv = [CourseHeaderView new];
        [_pmHv updateContentWithThem:@"下午最多几节课 ？" tipMessage:@"点击选择"];
        HXWeakSelf
        _pmHv.headerEventBlock = ^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigView:headerEventLocation:)]) {
                [weakSelf.delegate courseConfigView:weakSelf headerEventLocation:CourseConfigViewHeaderPMLocation];
            }
        };
    }
    return _pmHv;
}

@end
