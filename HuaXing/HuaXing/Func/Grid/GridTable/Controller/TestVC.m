//
//  TestVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/26.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TestVC.h"
#import "ClassTableMainView.h"
#import "CourseConfigVC.h"
#import "AddCourseVC.h"

@interface TestVC () <ClassTableMainViewDataSource,ClassTableMainViewDelegate,CourseConfigVCDelegate>

@property (nonatomic,strong) ClassTableMainView *ctv;

@property (nonatomic,assign) HXLocation         selectedLocation;

@property (nonatomic,strong) CourseConfigVC *nextVC;

@property (nonatomic,assign) NSInteger      maxCount;

// 记录已作出的设置信息
@property (nonatomic,copy) NSString *selected_date;
@property (nonatomic,copy) NSString *selected_amax;
@property (nonatomic,copy) NSString *selected_pmax;

@end

@implementation TestVC

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.ctv];
    self.maxCount = [self generateVerticalData].count;
    self.ctv.ds_sequences = [self generateVerticalData];
    self.ctv.ds_classItems = [self generateData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // UI
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(0, 0, 50, 30)];
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"课表设置" style:UIBarButtonItemStylePlain target:self action:@selector(configClassTable)];
    self.navigationItem.rightBarButtonItem = confirmItem;

    // 数据读取
    [[JXFileManager defaultManager] unarchiveObjWithFileKey:kAddCourseItem operateBlock:^(BOOL status, id  _Nonnull info) {
        if (info && [info isKindOfClass:[CourseItemModel class]]) {
            CourseItemModel *f = (CourseItemModel *)info;
            [[JXFileManager defaultManager] clearArchivedRootObjWithKey:kAddCourseItem];
            if (f) {
                [self addCourseItem:f];
            }
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)configClassTable {
    CourseConfigVC *vc = [[CourseConfigVC alloc] init];
    vc.delegate = (id)self;
    vc.lastSelectedDateString = self.selected_date;
    vc.lastSelectedAMax = self.selected_amax;
    vc.lastSelectedPMax = self.selected_pmax;
    [self.navigationController pushViewController:vc animated:FALSE];
}

#pragma mark --- ClassTableMainViewDataSource,ClassTableMainViewDelegate

-(CGFloat)heightForFirstHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 60.0;
}

- (CGFloat)heightForCommonHorizontalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 100.0;
}

-(CGFloat)widthForFirstVerticalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 100.0;
}

-(CGFloat)widthForCommonVerticalRowInClassTableMainView:(ClassTableMainView *)classTable {
    return 120.0;
}

-(void)classTableMainView:(ClassTableMainView *)classTable didSelectItemAtLocation:(HXLocation)l {
    NSLog(@"\n 点击位置 - 行：%lu - 列：%ld \n",(unsigned long)l.XLocation,l.YLocation);
    self.selectedLocation = l;
    AddCourseVC *vc = [AddCourseVC new];
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark --- CourseConfigVCDelegate

-(void)courseConfigVC:(CourseConfigVC *)vc selectedTheStartDate:(NSString *)startDateString {
    // 1. 记录选择信息
    self.selected_date = startDateString;
    
    // 2. 更新数据源
    NSString *year = [[JXDateManager shareInstance] getTheYearWithDateString:startDateString];
    NSString *endDateString = [NSString stringWithFormat:@"%@-12-01",year];
    NSString *lastDateString = [[JXDateManager shareInstance] getMonthLastDayWithDateString:endDateString];
    NSArray *dates = [[JXDateManager shareInstance] getDatesWithStartDate:startDateString endDate:lastDateString dateFormat:dateFormat_md_V];
    NSArray *weekDays = [[JXDateManager shareInstance] getWeekDaysWithStartDate:startDateString endDate:lastDateString];
    NSLog(@"\n 数据测试 : %s\n %@ \n",__FUNCTION__,dates);
    [self modifyDataSourceWithDates:dates weekDays:weekDays];
}

-(void)courseConfigVC:(CourseConfigVC *)vc amCourseMax:(NSInteger)aMax {
    // 1. 记录选择信息
    self.selected_amax = [NSString stringWithFormat:@"%ld",aMax];
    // 2. 更新数据源
    [self modifyDataSourceWithAMMax:aMax];
}

-(void)courseConfigVC:(CourseConfigVC *)vc pmCourseMax:(NSInteger)pMax {
    // 1. 记录选择信息
    self.selected_pmax = [NSString stringWithFormat:@"%ld",pMax];
    // 2. 更新数据源
    [self modifyDataSourceWithPMMax:pMax];
}

-(void)courseConfigVC:(CourseConfigVC *)vc amTimeTxt:(NSString *)time rowIndex:(NSInteger)idx {
    
}

-(void)courseConfigVC:(CourseConfigVC *)vc pmTimeTxt:(NSString *)time rowIndex:(NSInteger)idx {
    
}

#pragma mark --- generate data

- (NSArray *)generateVerticalData {
    NSMutableArray *hData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 3; cou ++) {
        SequenceItemModel *f = [SequenceItemModel new];
        f.sequence = cou;
        f.time = @"10:20-11:10";
        [hData addObject:f];
    }
    return hData;
}

- (NSArray *)generateData {
    NSMutableArray *d = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 6; cou ++) {
        ClassItemDataModel *f = [ClassItemDataModel new];
        f.maxCount = self.maxCount;
        f.date = [NSString stringWithFormat:@"2019/08/%ld",(long)cou];
        f.weekDay = [NSString stringWithFormat:@"星期%ld",cou%7 + 1];
        UIColor *clr = [UIColor colorWithR:(arc4random()%255) G:(arc4random()%255) B:(arc4random()%255) A:1.0];
        NSMutableArray *items = [NSMutableArray new];
        for (NSInteger i = 0; i < f.maxCount; i ++) {
            CourseItemModel *c = [CourseItemModel new];
            c.clr = clr;
            [items addObject:c];
        }
        f.courses = items;
        
        [d addObject:f];
    }
    return d;
}

- (void)addCourseItem:(CourseItemModel *)model {
    // 修改数据源
    ClassItemDataModel *items = self.ctv.ds_classItems[self.selectedLocation.XLocation];
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:items.courses];
    [tmp replaceObjectAtIndex:self.selectedLocation.YLocation withObject:model];
    
    // 更新数据源
    items.courses = tmp;
    [self.ctv reloadClassTalbe];
}

// 选中起始日期之后更新表格
- (void)modifyDataSourceWithDates:(NSArray *)dates weekDays:(NSArray *)weekDays {
    if (dates && weekDays && dates.count == weekDays.count) {
        NSMutableArray *tmp = [NSMutableArray new];
        for (NSInteger cou = 0; cou < dates.count; cou ++) {
            ClassItemDataModel *f = [ClassItemDataModel new];
            f.maxCount = self.maxCount;
            f.date = dates[cou];
            f.weekDay = weekDays[cou];
            UIColor *clr = [UIColor colorWithR:(arc4random()%255) G:(arc4random()%255) B:(arc4random()%255) A:1.0];
            NSMutableArray *items = [NSMutableArray new];
            for (NSInteger i = 0; i < f.maxCount; i ++) {
                CourseItemModel *c = [CourseItemModel new];
                c.clr = clr;
                [items addObject:c];
            }
            f.courses = items;
            [tmp addObject:f];
        }
        self.ctv.ds_classItems = tmp;
        [self.ctv reloadClassTalbe];
    }
}

// 选完课程最大节数之后 - am
- (void)modifyDataSourceWithAMMax:(NSInteger)amCount {
    // 1. 更新节数数据模型 - SequenceItemModel
    NSMutableArray *aData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < amCount; cou ++) {
        SequenceItemModel *f = [SequenceItemModel new];
        f.sequence = cou;
        f.time = @"am";
        [aData addObject:f];
    }
    self.ctv.ds_amsequences = aData;
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.ctv.ds_amsequences];
    [tmp addObjectsFromArray:self.ctv.ds_pmsequences];
    self.ctv.ds_sequences = tmp;
    self.maxCount = tmp.count;
    // 2. 更新课表每列数据模型 - ClassItemDataModel
    HXWeakSelf
    [self.ctv.ds_classItems enumerateObjectsUsingBlock:^(ClassItemDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.maxCount = weakSelf.maxCount;
        
        UIColor *clr = [UIColor colorWithR:(arc4random()%255) G:(arc4random()%255) B:(arc4random()%255) A:1.0];
        if (obj.courses && obj.courses.count > 0) {
            CourseItemModel *item = obj.courses[0];
            clr = item.clr;
        }
        NSMutableArray *items = [NSMutableArray new];
        for (NSInteger i = 0; i < weakSelf.maxCount; i ++) {
            CourseItemModel *c = [CourseItemModel new];
            c.clr = clr;
            [items addObject:c];
        }
        obj.courses = items;
    }];
    // 3. 刷新表格
    [self.ctv reloadClassTalbe];
}


// 选完课程最大节数之后 - pm
- (void)modifyDataSourceWithPMMax:(NSInteger)pmCount {
    // 1. 更新节数数据模型 - SequenceItemModel
    NSMutableArray *pData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < pmCount; cou ++) {
        SequenceItemModel *f = [SequenceItemModel new];
        f.sequence = cou;
        f.time = @"pm";
        [pData addObject:f];
    }
    self.ctv.ds_pmsequences = pData;
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.ctv.ds_amsequences];
    [tmp addObjectsFromArray:self.ctv.ds_pmsequences];
    self.ctv.ds_sequences = tmp;
    self.maxCount = tmp.count;
    // 2. 更新课表每列数据模型 - ClassItemDataModel
    HXWeakSelf
    [self.ctv.ds_classItems enumerateObjectsUsingBlock:^(ClassItemDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.maxCount = weakSelf.maxCount;
        
        UIColor *clr = [UIColor colorWithR:(arc4random()%255) G:(arc4random()%255) B:(arc4random()%255) A:1.0];
        if (obj.courses && obj.courses.count > 0) {
            CourseItemModel *item = obj.courses[0];
            clr = item.clr;
        }
        NSMutableArray *items = [NSMutableArray new];
        for (NSInteger i = 0; i < weakSelf.maxCount; i ++) {
            CourseItemModel *c = [CourseItemModel new];
            c.clr = clr;
            [items addObject:c];
        }
        obj.courses = items;
    }];
    // 3. 刷新表格
    [self.ctv reloadClassTalbe];
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
