//
//  ClassTableHeaderView.m
//  HuaXing
//
//  Created by hxwyh on 2019/7/31.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "ClassTableHeaderView.h"
#import "TableInfoHeaderView.h"
#import "DateCollectionViewCell.h"
#import "ClassItemDataModel.h"

static NSString *ClassTableHeaderView_ReusableViewHeader = @"ClassTableHeaderViewReusableViewHeader";
static NSString *ClassTableHeaderView_ReusableViewFooter = @"ClassTableHeaderViewReusableViewFooter";

@interface ClassTableHeaderView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    CGFloat cellHeight;
    CGFloat cellWidth;
    CGFloat widthForHeader;
    CGFloat widthForCommonRow;
    
    BOOL    _isAllowedNotification;
    CGFloat _lastOffX;
}
// UI
@property (nonatomic,strong) UILabel                            *bottomLine;
@property (nonatomic,strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic,strong) UICollectionView                   *clv;

// 课表每天课程数据
@property (nonatomic,strong) NSArray<ClassItemDataModel *>      *classItems;

@end

@implementation ClassTableHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.clv];
    [self addSubview:self.bottomLine];
    
    self.bottomLine.backgroundColor = [UIAdapter lineGray];
}

-(void)setNotificationName:(NSString *)notificationName {
    _notificationName = notificationName;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:notificationName object:nil];
}

-(void)updateFrameWithTableHeaderWidth:(CGFloat)w tableHeaderHeight:(CGFloat)h widthForFirstVertivalRowInTable:(CGFloat)w1 widthForOtherVertivalRowInTable:(CGFloat)w2 {
    //NSLog(@"\n 测试点尺寸111 \n");
    
    cellWidth = w;
    cellHeight= h;
    widthForHeader = w1;
    widthForCommonRow=w2;
    
    CGRect rect = CGRectZero;
    rect.origin.y = h - 1.0;
    rect.size.height = 1.0;
    rect.size.width = w;
    [self.bottomLine setFrame:rect];
    
    rect.size.height = h - 1.0;
    rect.origin.y = 0.0;
    [self.clv setFrame:rect];
    
    //NSLog(@"\n 测试点尺寸222 :%f \n",widthForCommonRow);
}

-(void)updateTableHeaderWithClassData:(NSArray<ClassItemDataModel *> *)clsItems {
    if (clsItems) {
        self.classItems = clsItems;
        //NSLog(@"\n 测试点刷新 \n");
        [self.clv reloadData];
    }
}

#pragma mark --- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"\n 测试点 :%f \n",widthForCommonRow);
    return CGSizeMake(widthForCommonRow, CGRectGetHeight(collectionView.frame));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(widthForHeader, CGRectGetHeight(collectionView.frame));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0.0, CGRectGetHeight(collectionView.frame));
}


#pragma mark --- UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classItems ? self.classItems.count : 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DateCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(DateCollectionViewCell.class) forIndexPath:indexPath];
    if (self.classItems && self.classItems.count > indexPath.row) {
        ClassItemDataModel *f = self.classItems[indexPath.row];
        item.model = f;
    }
    return item;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *rltView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TableInfoHeaderView *header     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ClassTableHeaderView_ReusableViewHeader forIndexPath:indexPath];
        rltView = header;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        rltView     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ClassTableHeaderView_ReusableViewFooter forIndexPath:indexPath];
        rltView.backgroundColor     = [UIColor blueColor];
    }
    return rltView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@" \n %@ \n ",[NSString stringWithFormat:@"%@",indexPath]);
    //    if (self.selectedBlock) {
    //        self.selectedBlock(indexPath);
    //    }
}


#pragma mark --- UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;//
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_isAllowedNotification) {//是自身才发通知去tableView以及其他的cell
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName object:self userInfo:@{@"cellOffX":@(scrollView.contentOffset.x)}];
    }
    _isAllowedNotification = NO;
}

-(void)scrollMove:(NSNotification*)notification
{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[@"cellOffX"] floatValue];
    if (obj!=self) {
        _isAllowedNotification = YES;
        if (_lastOffX != x) {
            [self.clv setContentOffset:CGPointMake(x, 0) animated:NO];
        }
        _lastOffX = x;
    }else{
        _isAllowedNotification = NO;
    }
    obj = nil;
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.notificationName object:nil];
}

//多种手势处理
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark --- lazy load

-(UILabel *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UILabel new];
        _bottomLine.backgroundColor = [UIColor blueColor];//[UIAdapter lineGray];
    }
    return _bottomLine;
}

-(UICollectionView *)clv {
    if (!_clv) {
        _clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_clv registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(DateCollectionViewCell.class)];
        [_clv registerClass:[TableInfoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ClassTableHeaderView_ReusableViewHeader];
        [_clv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ClassTableHeaderView_ReusableViewFooter];
        _clv.backgroundColor = [UIColor whiteColor];
        _clv.scrollsToTop = FALSE;
        _clv.bounces = FALSE;
        _clv.delegate = (id)self;
        _clv.dataSource = (id)self;
        _clv.showsHorizontalScrollIndicator = FALSE;
    }
    return _clv;
}

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.sectionHeadersPinToVisibleBounds = TRUE;
    }
    return _layout;
}

@end
