//
//  ClassTableCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "ClassTableCell.h"
//#import "GridCollectionHeader.h"
#import "SequenceHeaderView.h"
#import "CourseCollectionCell.h"

static NSString *ClassTableCell_ReusableViewHeader = @"ClassTableCellReusableViewHeader";
static NSString *ClassTableCell_ReusableViewFooter = @"ClassTableCellReusableViewFooter";
@interface ClassTableCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    CGFloat cellHeight;
    CGFloat cellWidth;
    CGFloat widthForHeader;
    CGFloat widthForCommonRow;
}
// UI
@property (nonatomic,strong) UILabel                            *bottomLine;
@property (nonatomic,strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic,strong) UICollectionView                   *clv;

// 课表每天课程数据
@property (nonatomic,strong) NSArray<ClassItemDataModel *>      *classItems;
// 序列化信息数据
@property (nonatomic,strong) NSArray<SequenceItemModel *>       *sequences;


@end

@implementation ClassTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self.contentView addSubview:self.clv];
    [self.contentView addSubview:self.bottomLine];
    
    self.bottomLine.backgroundColor = [UIColor redColor];
}

-(void)updateFrameWithCellWidth:(CGFloat)cw cellHeight:(CGFloat)ch widthForFirstVertivalRowInTable:(CGFloat)w1 widthForOtherVertivalRowInTable:(CGFloat)w2 {
    
    //NSLog(@"\n 测试点尺寸111 \n");
    
    cellWidth = cw;
    cellHeight= ch;
    widthForHeader = w1;
    widthForCommonRow=w2;
    
    CGRect rect = CGRectZero;
    rect.origin.y = ch - 1.0;
    rect.size.height = 1.0;
    rect.size.width = cw;
    [self.bottomLine setFrame:rect];
    
    rect.size.height = ch - 1.0;
    rect.origin.y = 0.0;
    [self.clv setFrame:rect];
    
    //NSLog(@"\n 测试点尺寸222 :%f \n",widthForCommonRow);
    
}

- (void)updateCellWithSequences:(NSArray<SequenceItemModel *> *)sequences classData:(NSArray<ClassItemDataModel *> *)clsItems {
    if (sequences && clsItems) {
        self.sequences = sequences;
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
    return CGSizeMake(10.0, CGRectGetHeight(collectionView.frame));
}


#pragma mark --- UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classItems ? self.classItems.count : 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CourseCollectionCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CourseCollectionCell.class) forIndexPath:indexPath];
    if (self.classItems) {
        ClassItemDataModel *f = self.classItems[indexPath.row];
        NSArray *f_items = f.courses;
        if (f_items && f_items.count > self.currentIndexPathForCell) {
            CourseItemModel *im = f_items[self.currentIndexPathForCell];
            //if (im.idx == ) {
                item.model = im;
            //}
        }
    }
    return item;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *rltView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SequenceHeaderView *header     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ClassTableCell_ReusableViewHeader forIndexPath:indexPath];
        header.model = self.sequences[self.currentIndexPathForCell];
        rltView = header;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        rltView     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ClassTableCell_ReusableViewFooter forIndexPath:indexPath];
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

#pragma mark --- lazy load

-(UILabel *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UILabel new];
        _bottomLine.backgroundColor = [UIColor blueColor];//[UIAdapter lightGray];
    }
    return _bottomLine;
}

-(UICollectionView *)clv {
    if (!_clv) {
        _clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_clv registerClass:[CourseCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass(CourseCollectionCell.class)];
        [_clv registerClass:[SequenceHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ClassTableCell_ReusableViewHeader];
        [_clv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ClassTableCell_ReusableViewFooter];
        _clv.backgroundColor = [UIColor whiteColor];
        _clv.scrollsToTop = FALSE;
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
        _layout.sectionHeadersPinToVisibleBounds = TRUE;
    }
    return _layout;
}

@end
