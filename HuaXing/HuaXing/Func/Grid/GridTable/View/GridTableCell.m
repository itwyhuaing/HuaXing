//
//  GridTableCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "GridTableCell.h"
#import "GridCollectionView.h"

@interface GridTableCell ()

@property (nonatomic,strong) GridCollectionView *gclv;

@end

@implementation GridTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.gclv];
}

-(GridCollectionView *)gclv {
    if (!_gclv) {
        _gclv = [[GridCollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], 160.0)];
        _gclv.backgroundColor = [UIColor whiteColor];
        HXWeakSelf
        _gclv.gcvSelectedBlock = ^(NSIndexPath * _Nonnull idx) {
            if (weakSelf.gtcSelectedBlock) {
                weakSelf.gtcSelectedBlock(idx);
            }
        };
    }
    return _gclv;
}

@end
