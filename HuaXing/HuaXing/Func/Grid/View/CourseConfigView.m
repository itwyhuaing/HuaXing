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

@property (nonatomic,strong) CourseHeaderView  *firstHv;

@property (nonatomic,strong) CourseHeaderView  *secondHv;

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
    if (section == 0) {
        [self fillTheArr:self.amItems count:[itemsCount integerValue]];
    }else if (section == 1) {
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
    if (section == 0) {
        [self.firstHv updateContentWithThem:them tipMessage:msg];
    }else if (section == 1){
        [self.secondHv updateContentWithThem:them tipMessage:msg];
    }
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger items = section == 0 ? self.amItems.count : self.pmItems.count;
    return items;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseTimeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_CourseTimeInfoCell];
    cell.data = indexPath.section == 0 ? self.amItems[indexPath.row] : self.pmItems[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTimeModel *dataModel = indexPath.section == 0 ? self.amItems[indexPath.row] : self.pmItems[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:dataModel keyPath:@"data" cellClass:[CourseTimeInfoCell class] contentViewWidth:[UIAdapter deviceWidth]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *hv =section == 0 ? self.firstHv : self.secondHv;
    return hv;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *fv = [UIView new];
    fv.backgroundColor = [UIColor orangeColor];
    return fv;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    if (_delegate && [_delegate respondsToSelector:@selector(courseConfigView:didSelectRowAtIndexPath:)]) {
        [_delegate courseConfigView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark ------ lazy load

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSelectionStyleNone;
        [_table registerClass:[CourseTimeInfoCell class] forCellReuseIdentifier:cell_CourseTimeInfoCell];
        _table.delegate = (id)self;
        _table.dataSource = (id)self;
    }
    return _table;
}

-(CourseHeaderView *)firstHv {
    if (!_firstHv) {
        _firstHv = [CourseHeaderView new];
        [_firstHv updateContentWithThem:@"上午几节课 ？" tipMessage:@"点击选择"];
        HXWeakSelf
        _firstHv.headerEventBlock = ^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigView:headerEventLocation:)]) {
                [weakSelf.delegate courseConfigView:weakSelf headerEventLocation:0];
            }
        };
    }
    return _firstHv;
}

-(CourseHeaderView *)secondHv {
    if (!_secondHv) {
        _secondHv = [CourseHeaderView new];
        [_secondHv updateContentWithThem:@"下午几节课 ？" tipMessage:@"点击选择"];
        HXWeakSelf
        _secondHv.headerEventBlock = ^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigView:headerEventLocation:)]) {
                [weakSelf.delegate courseConfigView:weakSelf headerEventLocation:1];
            }
        };
    }
    return _secondHv;
}

@end
