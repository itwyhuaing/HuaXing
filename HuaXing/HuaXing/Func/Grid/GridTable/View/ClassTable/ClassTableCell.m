//
//  ClassTableCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "ClassTableCell.h"
#import "GridCollectionHeader.h"
#import "CourseItem.h"

static NSString *GridCollectionViewReusableViewHeader = @"GridCollectionViewReusableViewHeader";
static NSString *GridCollectionViewReusableViewFooter = @"GridCollectionViewReusableViewFooter";
@interface ClassTableCell () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UILabel                            *bottomLine;
@property (nonatomic,strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic,strong) UICollectionView                   *clv;

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
