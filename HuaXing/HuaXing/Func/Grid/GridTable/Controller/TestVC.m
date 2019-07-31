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

-(NSArray<SequenceItemModel *> *)datasOfFirstVerticalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return [self generateVerticalData];
}

- (NSArray *)generateVerticalData {
    NSMutableArray *hData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 10; cou ++) {
        SequenceItemModel *f = [SequenceItemModel new];
        f.sequence = cou;
        [hData addObject:f];
    }
    return hData;
}

-(NSArray<ClassItemDataModel *> *)datasInClassTableMainView:(ClassTableMainView *)classTable {
    return [self generateData];
}

- (NSArray *)generateData {
    NSMutableArray *d = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 10; cou ++) {
        ClassItemDataModel *f = [ClassItemDataModel new];
        f.maxCount = 8;
        f.date = [NSString stringWithFormat:@"2019/08/%ld",cou];
        f.weekDay = [NSString stringWithFormat:@"星期%ld",cou%7 + 1];
        
        NSMutableArray *items = [NSMutableArray new];
        for (NSInteger i = 0; i < f.maxCount; i ++) {
            CourseItemModel *c = [CourseItemModel new];
            c.courseName = @"英语";
            c.idx    = i;
            c.teacher = @"Mr.Z";
            c.location = [NSString stringWithFormat:@"紫薇新天大厦A座六栋9层%ld9室",i];
            [items addObject:c];
        }
        f.courses = items;
        
        [d addObject:f];
    }
    return d;
}

-(CGFloat)heightForFirstHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 60.0;
}

- (CGFloat)heightForCommonHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 100.0;
}

-(CGFloat)widthForFirstVerticalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 60.0;
}

-(CGFloat)widthForCommonVerticalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 120.0;
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
