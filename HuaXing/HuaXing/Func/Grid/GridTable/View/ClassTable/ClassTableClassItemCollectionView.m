//
//  ClassTableClassItemCollectionView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "ClassTableClassItemCollectionView.h"
#import "GridCollectionHeader.h"
#import "CourseItem.h"

static NSString *GridCollectionViewReusableViewHeader = @"GridCollectionViewReusableViewHeader";
static NSString *GridCollectionViewReusableViewFooter = @"GridCollectionViewReusableViewFooter";


static NSString *notifycationID = @"GridCollectionView_notifycationID";
@interface ClassTableClassItemCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    BOOL    _isAllowedNotification;
    CGFloat _lastOffX;
}

@property (nonatomic,strong) UILabel                            *bottomLine;
@property (nonatomic,strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic,strong) UICollectionView                   *clv;

@end

@implementation ClassTableClassItemCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        NSLog(@"\n 监听测试 - 添加监听: %@ \n",self);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:notifycationID object:nil];
    }
    return self;
}


#pragma mark - UIScrollViewDelegate
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
        NSLog(@"\n 监听测试 - 发出通知: %@ \n",self);
        [[NSNotificationCenter defaultCenter] postNotificationName:notifycationID object:self userInfo:@{@"cellOffX":@(scrollView.contentOffset.x)}];
    }
    _isAllowedNotification = NO;
}


-(void)scrollMove:(NSNotification*)notification
{
    NSLog(@"\n 监听测试 - 通知后执行: %@ \n",self);
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
    NSLog(@"\n 监听测试 - 移除: %@ \n",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notifycationID object:nil];
}

#pragma mark - UI

- (void)configUI {
    [self addSubview:self.clv];
    [self addSubview:self.bottomLine];
}

-(void)layoutSubviews {
    CGRect rect = CGRectZero;
    rect.origin.y = CGRectGetMaxY(self.clv.frame);
    rect.size.height = 1.0;
    [self.bottomLine setFrame:rect];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CourseItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CourseItem.class) forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    [item modifyItemWithData:[NSString stringWithFormat:@"Idx %ld - %ld",indexPath.section,indexPath.row]];
    return item;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *rltView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GridCollectionHeader *header     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GridCollectionViewReusableViewHeader forIndexPath:indexPath];
        header.them                     = [NSString stringWithFormat:@"Header%ld",indexPath.section];
        rltView = header;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        rltView     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GridCollectionViewReusableViewFooter forIndexPath:indexPath];
        rltView.backgroundColor     = [UIColor blueColor];
    }
    return rltView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" \n %@ \n ",[NSString stringWithFormat:@"%@",indexPath]);
    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }
}

#pragma mark --- lazy load

-(UILabel *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UILabel new];
        _bottomLine.backgroundColor = [UIColor redColor];//[UIAdapter lightGray];
    }
    return _bottomLine;
}

-(UICollectionView *)clv {
    if (!_clv) {
        CGRect rect = self.frame;
        rect.origin = CGPointZero;
        rect.size.height = CGRectGetHeight(self.frame) - 2.0;
        _clv = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.layout];
        [_clv registerClass:[CourseItem class] forCellWithReuseIdentifier:NSStringFromClass(CourseItem.class)];
        [_clv registerClass:[GridCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GridCollectionViewReusableViewHeader];
        [_clv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GridCollectionViewReusableViewFooter];
        _clv.backgroundColor = [UIColor whiteColor];
        _clv.bounces = FALSE;
        _clv.delegate = (id)self;
        _clv.dataSource = (id)self;
        _clv.showsHorizontalScrollIndicator = TRUE;
    }
    return _clv;
}

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0.0;
        _layout.sectionInset = UIEdgeInsetsMake(0, 10.0, 0, 0);
        _layout.itemSize            = CGSizeMake(200.0, CGRectGetHeight(self.frame));
        _layout.headerReferenceSize         = CGSizeMake(100, 160);
        _layout.footerReferenceSize         = CGSizeMake(10, 160);
        _layout.sectionHeadersPinToVisibleBounds = TRUE;
    }
    return _layout;
}

@end
