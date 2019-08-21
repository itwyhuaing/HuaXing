//
//  AddNoteView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddNoteView.h"
#import "HXInputView.h"

@interface AddNoteView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HXInputView *themInputV;

@property (nonatomic,strong) UIView      *partLine;

@property (nonatomic,strong) HXInputView *cntInputV;

@property (nonatomic,strong) UITableView *listTable;

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
    [self addSubview:self.themInputV];
    [self addSubview:self.partLine];
    [self addSubview:self.cntInputV];
    [self addSubview:self.listTable];
}

-(void)layoutSubviews {
    CGRect rect = self.themInputV.frame;
    rect.origin.x    = [UIAdapter lrGap];
    rect.origin.y = CGRectGetMaxY(rect) + 3.f;
    rect.size.width  = [UIAdapter deviceWidth] - [UIAdapter lrGap] * 2.0;
    rect.size.height = 1.f;
    [self.partLine setFrame:rect];
    
    CGRect curCntFrame = self.cntInputV.frame;
    curCntFrame.origin.y = CGRectGetMaxY(rect) + 3.f;
    [self.cntInputV setFrame:curCntFrame];
    
    CGRect curTableFrame = self.listTable.frame;
    curTableFrame.origin.y = CGRectGetMaxY(curCntFrame) + 3.f;
    [self.listTable setFrame:curTableFrame];
}

#pragma mark --- setter

-(void)setModel:(CommonCellTypeModel *)model {
    if (model) {
        _model = model;
        [self.listTable reloadData];
    }
}

#pragma mark --- target

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resignFirstResponder];
}

- (void)resignFirstResponder {
    [self.themInputV resignFirstResponder];
    [self.cntInputV resignFirstResponder];
}

-(void)handleWithThem:(NSString *)them detail:(NSString *)detail {
    self.themInputV.bindedContent = them;
    self.cntInputV.bindedContent  = detail;
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AddNoteTimeCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddNoteTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddNoteTimeCell.class)];
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(addNoteView:didSelectedTimeAtIndexPath:)]) {
        [_delegate addNoteView:self didSelectedTimeAtIndexPath:indexPath];
    }
}

#pragma mark ---- lazy load

-(HXInputView *)themInputV {
    if (!_themInputV) {
        _themInputV = [[HXInputView alloc] initWithFrame:CGRectMake([UIAdapter lrGap], 10.f, [UIAdapter deviceWidth] - [UIAdapter lrGap] * 2.0, [HXInputView minHeight])];
        _themInputV.placeHolder = @"事项标题";
        _themInputV.textFont = [UIAdapter font17_Medium];
        HXWeakSelf
        _themInputV.updateHeightBlock = ^(CGFloat h) {
            CGRect rect = weakSelf.themInputV.frame;
            rect.size.height = h;
            [weakSelf.themInputV setFrame:rect];
        };
        _themInputV.endEditBlock = ^(NSString * _Nonnull rlt) {
            NSLog(@"\n them %@ \n",rlt);
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addNoteView:them:)]) {
                [weakSelf.delegate addNoteView:weakSelf them:rlt];
            }
        };
    }
    return _themInputV;
}

-(UIView *)partLine {
    if (!_partLine) {
        _partLine = [UIView new];
        _partLine.backgroundColor = [UIAdapter lineGray];
    }
    return _partLine;
}

-(HXInputView *)cntInputV {
    if (!_cntInputV) {
        _cntInputV = [[HXInputView alloc] initWithFrame:CGRectMake([UIAdapter lrGap], 0,[UIAdapter deviceWidth] - [UIAdapter lrGap] * 2.0, [HXInputView minHeight])];
        _cntInputV.placeHolder = @"备注信息";
        _cntInputV.textFont = [UIAdapter font15];
        HXWeakSelf
        _cntInputV.updateHeightBlock = ^(CGFloat h) {
            CGRect rect = weakSelf.cntInputV.frame;
            rect.size.height = h;
            [weakSelf.cntInputV setFrame:rect];
        };
        _cntInputV.endEditBlock = ^(NSString * _Nonnull rlt) {
            NSLog(@"\n them %@ \n",rlt);
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addNoteView:detail:)]) {
                [weakSelf.delegate addNoteView:weakSelf detail:rlt];
            }
        };
    }
    return _cntInputV;
}

-(UITableView *)listTable {
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], [AddNoteTimeCell cellHeight]) style:UITableViewStylePlain];
        [_listTable registerClass:[AddNoteTimeCell class] forCellReuseIdentifier:NSStringFromClass(AddNoteTimeCell.class)];
        _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTable.bounces = FALSE;
        _listTable.delegate = (id)self;
        _listTable.dataSource = (id)self;
    }
    return _listTable;
}

@end
