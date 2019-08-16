//
//  TodayVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TodayVC.h"
#import "TodayBriefInfoView.h"

@interface TodayVC ()
{
    NSMutableDictionary *eventsByDate;
}

@property (nonatomic,strong) TodayBriefInfoView *todayInfoView;
@end

@implementation TodayVC

#pragma mark --- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addOtherSubViews];
    //[self createRandomEvents]; 可用来处理节日
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNav];
}

#pragma mark --- event

- (void)basePopVC {
    [self.navigationController popViewControllerAnimated:FALSE];
}

- (void)backToToday {
    [self.calendarView backToToday];
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
    NSString *key = [[self dateFormatter] stringFromDate:date];
    self.navigationItem.title = key;
    NSArray *events = eventsByDate[key];
    if (events.count>0) {
        //该日期有事件    tableView 加载数据
    }
}

#pragma mark --- UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"Today %ld",indexPath.row];
    
    return cell;
    
}
#pragma mark --- createRandomEvents

- (void)createRandomEvents
{
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
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(0, 0, 50, 30)];
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"今日" style:UIBarButtonItemStylePlain target:self action:@selector(backToToday)];
    self.navigationItem.rightBarButtonItem = confirmItem;
    
    // 原生返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        [self customNavBackItem];
    }
}

- (void)customNavBackItem{
    UIBarButtonItem *customBackItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(basePopVC)];
    self.navigationItem.leftBarButtonItem = customBackItem;
}

-(void)lts_InitUI {
    [super lts_InitUI];
    CGFloat y_min = CGRectGetMinY([self cyl_tabBarController].tabBar.frame);
    CGRect  viewFrame = self.view.frame;
    CGRect  briefInfoFrame = self.todayInfoView.frame;
    CGFloat h_offset = CGRectGetMaxY(viewFrame) - y_min;
    self.calendarView.frame = CGRectMake(0, CGRectGetMaxY(self.todayInfoView.frame), CGRectGetWidth(viewFrame), CGRectGetHeight(viewFrame) - h_offset - CGRectGetHeight(briefInfoFrame));
    self.calendarView.calendar.calendarAppearance.weekDayFormat = LTSCalendarWeekDayFormatShort;
    self.calendarView.calendar.calendarAppearance.firstWeekday = 2;
    self.calendarView.calendar.calendarAppearance.isShowLunarCalender = !self.calendarView.calendar.calendarAppearance.isShowLunarCalender;
    self.calendarView.tableView.bounces = FALSE;
    
//    self.calendarView.calendar.calendarAppearance.backgroundColor = [UIColor whiteColor];
//    self.calendarView.calendar.calendarAppearance.weekDayTextColor = [UIColor greenColor];
//    self.calendarView.calendar.calendarAppearance.dayTextColorOtherMonth = [UIColor blueColor];
//    self.calendarView.calendar.calendarAppearance.lunarDayTextColorOtherMonth = [UIColor purpleColor];
    
    [self.calendarView.calendar reloadAppearance];
}

- (void)addOtherSubViews {
    [self.view addSubview:self.todayInfoView];
}

- (TodayBriefInfoView *)todayInfoView {
    if (!_todayInfoView) {
        CGRect  viewFrame = self.view.frame;
        _todayInfoView = [[TodayBriefInfoView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewFrame), [TodayBriefInfoView minHeight])];
        _todayInfoView.cnts = @[@"阳历 2019年8月16日",@"农历 七月十六 辛丑 兔年"];
    }
    return _todayInfoView;
}

@end
