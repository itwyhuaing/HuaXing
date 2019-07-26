//
//  GridCollectionView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "GridCollectionView.h"
#import "GridCollectionHeader.h"
#import "CourseItem.h"

static NSString *GridCollectionViewReusableViewHeader = @"GridCollectionViewReusableViewHeader";
static NSString *GridCollectionViewReusableViewFooter = @"GridCollectionViewReusableViewFooter";

@interface GridCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic,strong) UICollectionView                   *clv;

@end

@implementation GridCollectionView

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
    //self.clv.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CourseItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:item_CourseItem forIndexPath:indexPath];
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
        rltView.backgroundColor     = [UIColor purpleColor];
    }
    return rltView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" \n %@ \n ",[NSString stringWithFormat:@"%@",indexPath]);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@" \n %@ \n ",scrollView);
}

-(UICollectionView *)clv {
    if (!_clv) {
        _clv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], 160.0) collectionViewLayout:self.layout];
        [_clv registerClass:[CourseItem class] forCellWithReuseIdentifier:item_CourseItem];
        [_clv registerClass:[GridCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GridCollectionViewReusableViewHeader];
        [_clv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GridCollectionViewReusableViewFooter];
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
        _layout.footerReferenceSize         = CGSizeMake(30, 160);
        _layout.sectionHeadersPinToVisibleBounds = TRUE;
    }
    return _layout;
}

@end
