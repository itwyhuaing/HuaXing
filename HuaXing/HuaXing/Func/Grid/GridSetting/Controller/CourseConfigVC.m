//
//  CourseConfigVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseConfigVC.h"
#import "CourseConfigView.h"
#import "HXDatePickView.h"
#import "HXCourseItemsPKV.h"

@interface CourseConfigVC () <CourseConfigViewDelegate>

@property (nonatomic,strong) CourseConfigView   *ccv;

// 日期选择器
@property (nonatomic,strong) HXDatePickView     *datePkv;

// 时间选择器
@property (nonatomic,strong) HXDatePickView     *timePkv;

// 课程节数选择器
@property (nonatomic,strong) HXCourseItemsPKV   *courseItemsPkv;

// 当前选中的 section header 位置
@property (nonatomic,assign) NSInteger          currentLocation;

// 上午最多几节课程
@property (nonatomic,assign) NSInteger          aMax;

// 下午最多几节课程
@property (nonatomic,assign) NSInteger          pMax;

@end

@implementation CourseConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMainView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)addMainView {
    [self.view addSubview:self.ccv];

    HXWeakSelf
    // 日期选择器回调
    self.datePkv.pickCompletion = ^(NSString * _Nonnull dateResult) {
        NSLog(@" \n 测试数据 : %@ \n ",dateResult);
        [weakSelf.ccv updateHeaderViewWithThem:@"开课日期" tipMessage:dateResult section:weakSelf.currentLocation];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigVC:selectedTheStartDate:)]) {
            [weakSelf.delegate courseConfigVC:weakSelf selectedTheStartDate:dateResult];
        }
    };
    
    // 课程数选择器
    self.courseItemsPkv.pkvCompletion = ^(NSString * _Nonnull pkvResult) {
        NSLog(@" \n 测试数据 : %@ \n ",pkvResult);
        NSString *timePart = @"下午";
        if (weakSelf.currentLocation == CourseConfigViewHeaderAMLocation) {
            weakSelf.aMax = [pkvResult integerValue];
            timePart = @"上午";
            // 代理通知
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigVC:amCourseMax:)]) {
                [weakSelf.delegate courseConfigVC:weakSelf amCourseMax:weakSelf.aMax];
            }
        }else {
            weakSelf.pMax = [pkvResult integerValue];
            timePart = @"下午";
            // 代理通知
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigVC:pmCourseMax:)]) {
                [weakSelf.delegate courseConfigVC:weakSelf pmCourseMax:weakSelf.pMax];
            }
        }
        
        // 当前页 UI 更新
        if ([pkvResult integerValue] == 0) {
            [weakSelf.ccv updateHeaderViewWithThem:[NSString stringWithFormat:@"%@最多几节课 ？",timePart] tipMessage:@"点击选择" section:weakSelf.currentLocation];
        }else{
            [weakSelf.ccv updateHeaderViewWithThem:timePart tipMessage:[NSString stringWithFormat:@"%@节课",pkvResult] section:weakSelf.currentLocation];
        }
        [weakSelf.ccv updateTableWithCourseItems:pkvResult section:weakSelf.currentLocation];
        
    };
    
}


- (void)updateUI {
    if (self.lastSelectedDateString) {
        [self.ccv updateHeaderViewWithThem:@"开课日期" tipMessage:self.lastSelectedDateString section:0];
    }
    if (self.lastSelectedAMax && self.lastSelectedAMax.integerValue > 0) {
        [self.ccv updateHeaderViewWithThem:@"上午" tipMessage:[NSString stringWithFormat:@"%@节课",self.lastSelectedAMax] section:1];
        [self.ccv updateTableWithCourseItems:self.lastSelectedAMax section:1];
    }
    if (self.lastSelectedPMax && self.lastSelectedPMax.integerValue > 0) {
        [self.ccv updateHeaderViewWithThem:@"下午" tipMessage:[NSString stringWithFormat:@"%@节课",self.lastSelectedPMax] section:2];
        [self.ccv updateTableWithCourseItems:self.lastSelectedPMax section:2];
    }
}


#pragma mark ------ CourseConfigViewDelegate

-(void)courseConfigView:(CourseConfigView *)cv headerEventLocation:(NSInteger)location {
    // 记录位置
    self.currentLocation = location;
    // 展示选择器
    if (location == CourseConfigViewHeaderAMLocation) {
        [self.courseItemsPkv showOnSView:self.view barThem:@"请选择上午最多有几节课"];
    }else if (location == CourseConfigViewHeaderPMLocation) {
        [self.courseItemsPkv showOnSView:self.view barThem:@"请选择下午最多有几节课"];
    }else if (location == CourseConfigViewHeaderCourseDateLocation){
        [self.datePkv showOnSView:self.view];
        self.datePkv.barThem = @"请选择开课日期";
    }
}

-(void)courseConfigView:(CourseConfigView *)cv cellModel:(nonnull ItemTimeModel *)model didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HXWeakSelf
    __block BOOL isEnd = FALSE;
    __block NSMutableString *txt = [NSMutableString new];
    // 课程
    [self.timePkv showOnSView:self.view];
    self.timePkv.barThem = @"请选择该节开始时间";
    
    // Blcok Event 事件处理
    self.timePkv.pickCompletion = ^(NSString * _Nonnull dateResult) {
        if (!isEnd) {
            ItemTimeModel *f = model;
            f.detailTxt = [NSString stringWithFormat:@"%@-",dateResult];
            f.rightIConName = @"";
            [weakSelf.ccv updateTableWithItemModel:f cellForRowAtIndexPath:indexPath];
            [txt appendString:f.detailTxt];
            [weakSelf.timePkv showOnSView:weakSelf.view];
            weakSelf.timePkv.barThem = @"请选择该节结束时间";
            isEnd = TRUE;
        }else {
            [txt appendString:dateResult];
            ItemTimeModel *f = model;
            f.detailTxt = txt;
            f.rightIConName = @"";
            [weakSelf.ccv updateTableWithItemModel:f cellForRowAtIndexPath:indexPath];
            
            if (indexPath.section == CourseConfigViewHeaderAMLocation) { // 上午
                // 代理
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigVC:amTimeTxt:rowIndex:)]) {
                    [weakSelf.delegate courseConfigVC:weakSelf amTimeTxt:txt rowIndex:indexPath.row];
                }
            }else {
                // 代理
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(courseConfigVC:pmTimeTxt:rowIndex:)]) {
                    [weakSelf.delegate courseConfigVC:weakSelf pmTimeTxt:txt rowIndex:indexPath.row];
                }
            }
        }
    };
}

#pragma mark ------ lazy load

-(CourseConfigView *)ccv {
    if (!_ccv) {
        _ccv = [[CourseConfigView alloc] initWithFrame:self.view.bounds];
        _ccv.delegate = (id)self;
    }
    return _ccv;
}


-(HXDatePickView *)datePkv {
    if (!_datePkv) {
        _datePkv = [[HXDatePickView alloc] initWithViewType:HXDatePickViewDateType];
    }
    return _datePkv;
}

-(HXDatePickView *)timePkv {
    if (!_timePkv) {
        _timePkv = [[HXDatePickView alloc] initWithViewType:HXDatePickViewTimeType];
    }
    return _timePkv;
}


-(HXCourseItemsPKV *)courseItemsPkv {
    if (!_courseItemsPkv) {
        _courseItemsPkv = [HXCourseItemsPKV new];
    }
    return _courseItemsPkv;
}


#pragma mark --- Test



@end
