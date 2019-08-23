//
//  TodayVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TodayVC.h"
#import "HXNoteEditVC.h"
#import "TodayBriefInfoView.h"
#import "TodayNoteCell.h"
#import "TodayDataManager.h"

@interface TodayVC ()<HXNoteEditVCDelegate>
{
    NSMutableDictionary *eventsByDate;
}

@property (nonatomic,strong) TodayBriefInfoView *todayInfoView;

@property (nonatomic,strong) TodayDataManager   *dataManager;

@end

@implementation TodayVC

#pragma mark --- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addOtherSubViews];
    //[self createRandomEvents]; 可用来处理节日
    self.dataSource = [self generateData];
    [self.dataManager orderedByTimeWithDataSource:self.dataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNav];
}

#pragma mark --- target

- (void)basePopVC {
    [self.navigationController popViewControllerAnimated:FALSE];
}

- (void)backToToday {
    [self.calendarView backToToday];
}

- (void)addNote {
    HXNoteEditVC *vc = [HXNoteEditVC new];
    vc.delegate = (id)self;
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark --- HXNoteEditVCDelegate

-(void)hxNoteEditVC:(HXNoteEditVC *)vc popWithModel:(TodayNoteModel *)model {
    if (model) {
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.dataSource];
        [tmp addObject:model];
        self.dataSource = [self.dataManager orderedByTimeWithDataSource:tmp];
        [self.calendarView.tableView reloadData];
    }
}

#pragma mark --- LTSCalendarEventSource

// 该日期是否有事件
- (BOOL)calendarHaveEvent:(LTSCalendarManager *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    //
    return NO;
}

//当前 选中的日期  执行的方法
- (void)calendarDidDateSelected:(LTSCalendarManager *)calendar date:(NSDate *)date {
    [self modifyTodayBriefInfoWithCurDate:date];
    NSString *key = [[self dateFormatter] stringFromDate:date];
    self.navigationItem.title = key;
    NSArray *events = eventsByDate[key];
    if (events.count>0) {
        //该日期有事件    tableView 加载数据
    }
}

#pragma mark --- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource ? self.dataSource.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = 0.0;
    if (self.dataSource && indexPath.row < self.dataSource.count) {
        TodayNoteModel *f = self.dataSource[indexPath.row];
        h = [tableView cellHeightForIndexPath:indexPath
                                        model:f
                                      keyPath:@"model"
                                    cellClass:[TodayNoteCell class]
                             contentViewWidth:[UIAdapter deviceWidth]];

    }
    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayNoteCell *rtnCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TodayNoteCell.class)];
    // cell 数据
    if (self.dataSource && indexPath.row < self.dataSource.count) {
        TodayNoteModel *f = self.dataSource[indexPath.row];
        rtnCell.model = f;
    }
    // cell 点击事件
    rtnCell.foldEventBlock = ^(NSString * _Nonnull cnt) {
        TodayNoteModel *f = self.dataSource[indexPath.row];
        f.foldStatus = !f.foldStatus;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    rtnCell.editEventBlock = ^(NSString * _Nonnull cnt) {
        NSLog(@"\n 编辑备忘录 \n");
        TodayNoteModel *f = self.dataSource[indexPath.row];
        HXNoteEditVC *vc = [HXNoteEditVC new];
        vc.carriedNoteModel = f;
        vc.delegate = (id)self;
        [self.navigationController pushViewController:vc animated:TRUE];
    };
    rtnCell.deleteEventBlock = ^(NSString * _Nonnull cnt) {
        NSLog(@"\n 删除备忘录 \n");
        TodayNoteModel *f = self.dataSource[indexPath.row];
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.dataSource];
        [tmp removeObject:f];
        self.dataSource = tmp;
        [self.calendarView.tableView reloadData];
    };
    // cell 样式
    rtnCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rtnCell;
    
}

#pragma mark --- createRandomEvents

- (void)createRandomEvents {
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
    }
}


#pragma mark --- UI

- (void)setupNav {
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIAdapter mainBlue]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIAdapter mainBlue];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *todayItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"today_nav_today"] style:UIBarButtonItemStylePlain target:self action:@selector(backToToday)];
    UIBarButtonItem *addItem   = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"today_nav_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItems = @[addItem,todayItem];;
    
}

-(void)lts_InitUI {
    [super lts_InitUI];
    [self.calendarView.tableView registerClass:[TodayNoteCell class] forCellReuseIdentifier:NSStringFromClass(TodayNoteCell.class)];
    CGFloat y_min = CGRectGetMinY([self cyl_tabBarController].tabBar.frame);
    CGRect  viewFrame = self.view.frame;
    CGRect  briefInfoFrame = self.todayInfoView.frame;
    CGFloat h_offset = CGRectGetMaxY(viewFrame) - y_min;
    self.calendarView.frame = CGRectMake(0, CGRectGetMaxY(self.todayInfoView.frame), CGRectGetWidth(viewFrame), CGRectGetHeight(viewFrame) - h_offset - CGRectGetHeight(briefInfoFrame));
    self.calendarView.calendar.calendarAppearance.weekDayFormat = LTSCalendarWeekDayFormatZHFull;//LTSCalendarWeekDayFormatShort;
    self.calendarView.calendar.calendarAppearance.firstWeekday = 2;
    self.calendarView.calendar.calendarAppearance.isShowLunarCalender = !self.calendarView.calendar.calendarAppearance.isShowLunarCalender;
    self.calendarView.tableView.bounces = FALSE;
    self.calendarView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.calendarView.calendar.calendarAppearance.backgroundColor                   = [UIColor whiteColor];
    self.calendarView.calendar.calendarAppearance.weekDayTextColor                  = [UIAdapter mainBlue];
    self.calendarView.calendar.calendarAppearance.dayTextColor                      = [UIAdapter lightTintBlack];
    self.calendarView.calendar.calendarAppearance.lunarDayTextColor                 = [UIAdapter lightTintBlack];
    self.calendarView.calendar.calendarAppearance.dayTextColorOtherMonth            = [UIAdapter lightTintGray];
    self.calendarView.calendar.calendarAppearance.lunarDayTextColorOtherMonth       = [UIAdapter lightTintGray];
    self.calendarView.calendar.calendarAppearance.dayBorderColorToday               = [UIAdapter mainBlue];
    self.calendarView.calendar.calendarAppearance.dayCircleColorToday               = [UIAdapter mainBlue];
    self.calendarView.calendar.calendarAppearance.dayCircleColorSelected            = [UIAdapter mainBlue];
    self.calendarView.calendar.calendarAppearance.dayCircleSize                     = 39.f;
    
    [self.calendarView.calendar reloadAppearance];
}

- (void)addOtherSubViews {
    [self.view addSubview:self.todayInfoView];
}

- (void)modifyTodayBriefInfoWithCurDate:(NSDate *)date {
    NSString *global = [[self dateFormatter] stringFromDate:date];
    NSString *chinese = [[JXDateManager shareInstance] getChineseCalendarWithDate:global];
    NSString *global_cnt = [NSString stringWithFormat:@"阳历 %@",global];
    NSString *chinese_cnt = [NSString stringWithFormat:@"农历 %@",chinese];
    self.todayInfoView.cnts = @[global_cnt,chinese_cnt];
}

- (TodayBriefInfoView *)todayInfoView {
    if (!_todayInfoView) {
        CGRect  viewFrame = self.view.frame;
        _todayInfoView = [[TodayBriefInfoView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewFrame), [TodayBriefInfoView minHeight])];
    }
    return _todayInfoView;
}

-(TodayDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TodayDataManager alloc] init];
    }
    return _dataManager;
}


- (NSArray *)generateData {
    NSMutableArray *rlt = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 9; cou ++) {
        TodayNoteModel *f = [TodayNoteModel new];
        NSInteger hour = [HXUtil randomFrom:0 to:23 closed:TRUE];
        NSInteger min  = [HXUtil randomFrom:0 to:59 closed:TRUE];
        f.time = [NSString stringWithFormat:@"%ld:%ld",hour,min];
        f.briefInfo = @"中国ETC服务平台正式上线运营";
        f.detailInfo = @"中国ETC服务平台于8月申办ETC。";
        [rlt addObject:f];
    }
    [self printWithDta:rlt];
    return [self.dataManager orderedByTimeWithDataSource:rlt];
}


- (void)printWithDta:(NSArray *)data {
    if (data) {
        NSLog(@" \n ================== 备忘录事项 \n ");
        for (NSInteger cou = 0; cou < data.count; cou ++) {
            TodayNoteModel *f = data[cou];
            NSLog(@"%@ - %@",f.time,f.itemID);
        }
    }
}

@end
