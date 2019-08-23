//
//  CourseGridVC.m
//  HuaXing
//
//  Created by hxwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseGridVC.h"
#import "ClassTableMainView.h"
#import "CourseConfigVC.h"
#import "AddCourseVC.h"

@interface CourseGridVC ()<ClassTableMainViewDataSource,ClassTableMainViewDelegate,CourseConfigVCDelegate,AddCourseVCDelegate>

@property (nonatomic,strong) UIView                 *blankMessageView;

@property (nonatomic,strong) ClassTableMainView     *ctv;

@property (nonatomic,assign) HXLocation             selectedLocation;

@property (nonatomic,strong) CourseConfigVC         *configTableVC;

@property (nonatomic,strong) AddCourseVC            *addCourseVC;

@end

@implementation CourseGridVC


-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.ctv];
    [self handleBlankMessage];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"课表";
    // UI
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(0, 0, 50, 30)];
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"课表设置" style:UIBarButtonItemStylePlain target:self action:@selector(configClassTable)];
    self.navigationItem.rightBarButtonItem = confirmItem;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)configClassTable {
    [self.navigationController pushViewController:self.configTableVC animated:FALSE];
}

-(void)handleBlankMessage {
    if (self.ctv.ds_classItems && self.ctv.ds_sequences) {
        self.blankMessageView.hidden = TRUE;
    }else{
        self.blankMessageView.hidden = FALSE;
    }
}

#pragma mark --- ClassTableMainViewDataSource

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

#pragma mark --- ClassTableMainViewDelegate

-(void)classTableMainView:(ClassTableMainView *)classTable didSelectItemAtLocation:(HXLocation)l {
    NSLog(@"\n 点击位置 - 行：%lu - 列：%ld \n",(unsigned long)l.XLocation,l.YLocation);
    self.selectedLocation = l;
    [self.navigationController pushViewController:self.addCourseVC animated:TRUE];
}


#pragma mark --- AddCourseVCDelegate

- (void)addCourseVC:(AddCourseVC *)vc didComposedModel:(ClassItemDataModel *)model {
    if (model && [model isKindOfClass:[CourseItemModel class]]) {
        CourseItemModel *f = (CourseItemModel *)model;
        if (f) {
            [self addCourseItem:f];
        }
    }
}

#pragma mark --- CourseConfigVCDelegate

-(void)courseConfigVC:(CourseConfigVC *)vc selectedTheStartDate:(NSString *)startDateString {
    // 更新数据源
    NSString *year = [[JXDateManager shareInstance] getTheYearWithDateString:startDateString];
    NSString *endDateString = [NSString stringWithFormat:@"%@-12-01",year];
    NSString *lastDateString = [[JXDateManager shareInstance] getMonthLastDayWithDateString:endDateString];
    NSArray *dates = [[JXDateManager shareInstance] getDatesWithStartDate:startDateString endDate:lastDateString dateFormat:dateFormat_md_V];
    NSArray *weekDays = [[JXDateManager shareInstance] getWeekDaysWithStartDate:startDateString endDate:lastDateString];
    //NSLog(@"\n 数据测试 : %s\n %@ \n",__FUNCTION__,dates);
    [self modifyDataSourceWithDates:dates weekDays:weekDays];
}

-(void)courseConfigVC:(CourseConfigVC *)vc amCourseMax:(NSInteger)aMax {
    // 更新数据源
    [self modifyDataSourceWithAMMax:aMax];
}

-(void)courseConfigVC:(CourseConfigVC *)vc pmCourseMax:(NSInteger)pMax {
    // 更新数据源
    [self modifyDataSourceWithPMMax:pMax];
}

-(void)courseConfigVC:(CourseConfigVC *)vc amTimeTxt:(NSString *)time rowIndex:(NSInteger)idx {
    [self.ctv.ds_amsequences enumerateObjectsUsingBlock:^(SequenceItemModel * _Nonnull obj, NSUInteger location, BOOL * _Nonnull stop) {
        if (idx == location) {
            obj.time = time;
            return;
        }
    }];
    [self.ctv reloadClassTalbe];
}

-(void)courseConfigVC:(CourseConfigVC *)vc pmTimeTxt:(NSString *)time rowIndex:(NSInteger)idx {
    [self.ctv.ds_pmsequences enumerateObjectsUsingBlock:^(SequenceItemModel * _Nonnull obj, NSUInteger location, BOOL * _Nonnull stop) {
        if (idx == location) {
            obj.time = time;
            return;
        }
    }];
    [self.ctv reloadClassTalbe];
}

#pragma mark --- handle data

// 选中起始日期之后更新表格
- (void)modifyDataSourceWithDates:(NSArray *)dates weekDays:(NSArray *)weekDays {
    if (dates && weekDays && dates.count == weekDays.count) {
        NSMutableArray *tmp = [NSMutableArray new];
        for (NSInteger cou = 0; cou < dates.count; cou ++) {
            ClassItemDataModel *f = [ClassItemDataModel new];
            f.maxCount = self.ctv.ds_sequences.count;
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
    // 空白提示页处理
    [self handleBlankMessage];
}

// 选完课程最大节数之后 - am
- (void)modifyDataSourceWithAMMax:(NSInteger)amCount {
    // 1. 更新节数数据模型 - SequenceItemModel
    NSMutableArray *aData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < amCount; cou ++) {
        SequenceItemModel *f = [SequenceItemModel new];
        f.sequence = cou;
        //        f.time = @"am";
        [aData addObject:f];
    }
    self.ctv.ds_amsequences = aData;
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.ctv.ds_amsequences];
    [tmp addObjectsFromArray:self.ctv.ds_pmsequences];
    self.ctv.ds_sequences = tmp;
    
    // 2. 更新课表每列数据模型 - ClassItemDataModel
    HXWeakSelf
    [self.ctv.ds_classItems enumerateObjectsUsingBlock:^(ClassItemDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.maxCount = weakSelf.ctv.ds_sequences.count;
        
        UIColor *clr = [UIColor whiteColor];//[UIAdapter randomColor];
        NSMutableArray *items = [NSMutableArray new];
        for (NSInteger i = 0; i < obj.maxCount; i ++) {
            CourseItemModel *c = [CourseItemModel new];
            c.clr = clr;
            [items addObject:c];
        }
        obj.courses = items;
    }];
    // 3. 刷新表格
    [self.ctv reloadClassTalbe];
    // 空白提示页处理
    [self handleBlankMessage];
}


// 选完课程最大节数之后 - pm
- (void)modifyDataSourceWithPMMax:(NSInteger)pmCount {
    // 1. 更新节数数据模型 - SequenceItemModel
    NSMutableArray *pData = [NSMutableArray new];
    for (NSInteger cou = 0; cou < pmCount; cou ++) {
        SequenceItemModel *f = [SequenceItemModel new];
        f.sequence = cou;
        //        f.time = @"pm";
        [pData addObject:f];
    }
    self.ctv.ds_pmsequences = pData;
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.ctv.ds_amsequences];
    [tmp addObjectsFromArray:self.ctv.ds_pmsequences];
    self.ctv.ds_sequences = tmp;
    
    // 2. 更新课表每列数据模型 - ClassItemDataModel
    HXWeakSelf
    [self.ctv.ds_classItems enumerateObjectsUsingBlock:^(ClassItemDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.maxCount = weakSelf.ctv.ds_sequences.count;
        
        UIColor *clr = [UIColor colorWithR:(arc4random()%255) G:(arc4random()%255) B:(arc4random()%255) A:1.0];
        if (obj.courses && obj.courses.count > 0) {
            CourseItemModel *item = obj.courses[0];
            clr = item.clr;
        }
        NSMutableArray *items = [NSMutableArray new];
        for (NSInteger i = 0; i < obj.maxCount; i ++) {
            CourseItemModel *c = [CourseItemModel new];
            c.clr = clr;
            [items addObject:c];
        }
        obj.courses = items;
    }];
    // 3. 刷新表格
    [self.ctv reloadClassTalbe];
    
    // 空白提示页处理
    [self handleBlankMessage];
}

// 添加课程
- (void)addCourseItem:(CourseItemModel *)model {
    // 修改数据源
    ClassItemDataModel *dayCourseModel = self.ctv.ds_classItems[self.selectedLocation.YLocation];
    CourseItemModel *f = dayCourseModel.courses[self.selectedLocation.XLocation];
    f.courseName = model.courseName;
    f.teacher    = model.teacher;
    f.location   = model.location;
    
    // 更新数据源
    [self.ctv reloadClassTalbe];
}


#pragma mark --- lazy load

-(UIView *)blankMessageView {
    if (!_blankMessageView) {
        _blankMessageView = [UIView new];
        [self.view addSubview:_blankMessageView];
        
        UIImageView *imgV = [UIImageView new];
        UILabel     *message = [UILabel new];
        [_blankMessageView addSubview:imgV];
        [_blankMessageView addSubview:message];
        
        CGFloat imgWH = 120.0 * [UIAdapter Scale47Width];
        CGFloat off_y = 60.0 * [UIAdapter Scale47Width];
        _blankMessageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        imgV.sd_layout
        .widthIs(imgWH)
        .heightIs(imgWH)
        .centerXEqualToView(_blankMessageView)
        .centerYEqualToView(_blankMessageView).offset((-imgWH/2.0 - off_y));
        
        message.sd_layout
        .topSpaceToView(imgV, 15.0)
        .leftEqualToView(_blankMessageView)
        .rightEqualToView(_blankMessageView)
        .heightIs(20.0 * [UIAdapter Scale47Width]);
        
        imgV.contentMode    = UIViewContentModeScaleAspectFill;
        imgV.clipsToBounds  = TRUE;
        message.textColor   = [UIAdapter lightTintGray];
        message.font        = [UIAdapter font15];
        message.textAlignment = NSTextAlignmentCenter;
        
        imgV.image = [UIImage imageNamed:@"table_blank"];
        message.text = @"你还未设置课表哦";
    }
    return _blankMessageView;
}

-(ClassTableMainView *)ctv {
    if (!_ctv) {
        _ctv = [ClassTableMainView new];
        [_ctv setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        _ctv.dataSource = (id)self;
        _ctv.delegate   = (id)self;
    }
    return _ctv;
}

-(CourseConfigVC *)configTableVC {
    if (!_configTableVC) {
        _configTableVC = [CourseConfigVC new];
        _configTableVC.delegate = (id)self;
    }
    return _configTableVC;
}

-(AddCourseVC *)addCourseVC {
    if (!_addCourseVC) {
        _addCourseVC = [[AddCourseVC alloc] init];
        _addCourseVC.delegate = (id)self;
    }
    return _addCourseVC;
}


@end
