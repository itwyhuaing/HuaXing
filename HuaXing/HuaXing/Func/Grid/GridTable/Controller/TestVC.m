//
//  TestVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TestVC.h"
#import "ClassTableMainView.h"
#import "AddCourseVC.h"

@interface TestVC () <ClassTableMainViewDataSource,ClassTableMainViewDelegate>

@property (nonatomic,strong) ClassTableMainView *ctv;

@end

@implementation TestVC

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.ctv];
    self.ctv.ds_sequences = [self generateVerticalData];
    self.ctv.ds_classItems = [self generateData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark --- ClassTableMainViewDataSource,ClassTableMainViewDelegate

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

-(void)classTableMainView:(ClassTableMainView *)classTable didSelectItemAtLocation:(HXLocation)l {
    NSLog(@"\n 点击位置 - 行：%ld - 列：%ld \n",l.XLocation,l.YLocation);
    //self.ctv.ds_classItems = [self modifyDataSorce:self.ctv.ds_classItems modelAtHXLocation:l];
    //[self.ctv reloadClassTalbe];
    AddCourseVC *vc = [AddCourseVC new];
    [self.navigationController pushViewController:vc animated:TRUE];
}


#pragma mark --- generate data

- (NSArray *)generateVerticalData {
    NSMutableArray *hData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 10; cou ++) {
        SequenceItemModel *f = [SequenceItemModel new];
        f.sequence = cou;
        [hData addObject:f];
    }
    return hData;
}

- (NSArray *)generateData {
    NSMutableArray *d = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 10; cou ++) {
        ClassItemDataModel *f = [ClassItemDataModel new];
        f.maxCount = [self generateVerticalData].count;
        f.date = [NSString stringWithFormat:@"2019/08/%ld",cou];
        f.weekDay = [NSString stringWithFormat:@"星期%ld",cou%7 + 1];
        
        NSMutableArray *items = [NSMutableArray new];
        for (NSInteger i = 0; i < f.maxCount; i ++) {
            CourseItemModel *c = [CourseItemModel new];
//            c.courseName = [NSString stringWithFormat:@"今天第 %ld 节课",i];
//            c.idx    = i;
//            if (i % 2 == 0) {
//                c.teacher = @"Mr.Z";
//            }
//            c.location = [NSString stringWithFormat:@"紫薇新天大厦A座9层%ld9室",i];
            [items addObject:c];
        }
        f.courses = items;
        
        [d addObject:f];
    }
    return d;
}

- (NSArray *)modifyDataSorce:(NSArray *)ds modelAtHXLocation:(HXLocation)l {
    NSMutableArray *rlt = [NSMutableArray new];
    if (ds) {
        [rlt addObjectsFromArray:ds];
        ClassItemDataModel *f = rlt[l.YLocation];
        NSArray *courses = f.courses;
        CourseItemModel *ff = courses[l.XLocation];
        ff.courseName = [NSString stringWithFormat:@"今天第 %ld 节课",l.XLocation];
        ff.idx    = l.XLocation;
        if (l.XLocation % 2 == 0) {
            ff.teacher = @"Mr.Z";
        }
        ff.location = [NSString stringWithFormat:@"紫薇新天大厦A座9层%ld9室",l.XLocation];
    }
    return rlt;
}

#pragma mark --- lazy load

-(ClassTableMainView *)ctv {
    if (!_ctv) {
        _ctv = [ClassTableMainView new];
        [_ctv setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        _ctv.dataSource = (id)self;
        _ctv.delegate   = (id)self;
    }
    return _ctv;
}

@end
