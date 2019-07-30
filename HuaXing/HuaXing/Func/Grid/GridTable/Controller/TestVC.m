//
//  TestVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TestVC.h"
#import "ClassTableMainView.h"

@interface TestVC () <ClassTableMainViewDataSource,ClassTableMainViewDelegate>

@property (nonatomic,strong) ClassTableMainView *ctv;

@end

@implementation TestVC

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.ctv];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark --- ClassTableMainViewDataSource,ClassTableMainViewDelegate


-(NSArray<HorizontalItemDataModel *> *)datasOfFirstHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return [self generateHorizontalData];
}


-(NSArray<VerticalItemDataModel *> *)datasOfFirstVerticalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return [self generateVerticalData];
}


- (NSArray *)generateHorizontalData {
    NSMutableArray *hData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 10; cou ++) {
        HorizontalItemDataModel *f = [HorizontalItemDataModel new];
        f.date = [NSString stringWithFormat:@"2019/08/%ld",cou];
        f.weekDay = [NSString stringWithFormat:@"星期%ld",cou%7 + 1];
        [hData addObject:f];
    }
    return hData;
}


- (NSArray *)generateVerticalData {
    NSMutableArray *hData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 10; cou ++) {
        VerticalItemDataModel *f = [VerticalItemDataModel new];
        f.sequence = [NSString stringWithFormat:@"第%ld节",cou+1];
        [hData addObject:f];
    }
    return hData;
}

-(CGFloat)heightForFirstHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 60.0;
}

- (CGFloat)heightForCommonHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 100.0;
}

-(void)classTableMainView:(ClassTableMainView *)classTable didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n %ld \n",indexPath.row);
}


#pragma mark --- lazy load

-(ClassTableMainView *)ctv {
    if (!_ctv) {
        _ctv = [ClassTableMainView new];
        [_ctv setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 30)];
        _ctv.dataSource = (id)self;
        _ctv.delegate   = (id)self;
    }
    return _ctv;
}

@end
