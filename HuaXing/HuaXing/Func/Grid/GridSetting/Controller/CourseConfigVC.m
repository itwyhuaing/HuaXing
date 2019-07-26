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
@property (nonatomic,strong) HXCourseItemsPKV *courseItemsPkv;

@end

@implementation CourseConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMainView];
}

- (void)addMainView {
    [self.view addSubview:self.ccv];
    self.ccv.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark ------ CourseConfigViewDelegate

-(void)courseConfigView:(CourseConfigView *)cv headerEventLocation:(NSInteger)location {
    // 展示选择器
    if (location == CourseConfigViewHeaderAMLocation) {
        [self.courseItemsPkv showOnSView:self.view barThem:@"请选择上午有几节课"];
    }else if (location == CourseConfigViewHeaderPMLocation) {
        [self.courseItemsPkv showOnSView:self.view barThem:@"请选择下午有几节课"];
    }else if (location == CourseConfigViewHeaderCourseDateLocation){
        [self.datePkv showOnSView:self.view];
        self.datePkv.barThem = @"请选择开课日期";
    }
    
    // 课程数选择器
    HXWeakSelf
    self.courseItemsPkv.pkvCompletion = ^(NSString * _Nonnull pkvResult) {
        NSLog(@" \n 测试数据 : %@ \n ",pkvResult);
        if (location == CourseConfigViewHeaderAMLocation ||
            location == CourseConfigViewHeaderPMLocation) {
            NSString *timePart = location == CourseConfigViewHeaderAMLocation ? @"上午" : @"下午";
            if ([pkvResult integerValue] == 0) {
                [weakSelf.ccv updateHeaderViewWithThem:[NSString stringWithFormat:@"%@几节课 ？",timePart] tipMessage:@"点击选择" section:location];
            }else{
                [weakSelf.ccv updateHeaderViewWithThem:timePart tipMessage:[NSString stringWithFormat:@"%@节课",pkvResult] section:location];
            }
            [weakSelf.ccv updateTableWithCourseItems:pkvResult section:location];
        }
    };
    
    // 日期选择器回调
    self.datePkv.pickCompletion = ^(NSString * _Nonnull dateResult) {
        NSLog(@" \n 测试数据 : %@ \n ",dateResult);
        [weakSelf.ccv updateHeaderViewWithThem:@"开课日期" tipMessage:dateResult section:location];
    };
}

-(void)courseConfigView:(CourseConfigView *)cv cellModel:(nonnull ItemTimeModel *)model didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HXWeakSelf
    __block BOOL isEnd = FALSE;
    __block NSMutableString *txt = [NSMutableString new];
    // 课程
    [self.timePkv showOnSView:self.view];
    self.timePkv.barThem = @"请选择该节开始时间";
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
        }
    };
}

#pragma mark ------ lazy load

-(CourseConfigView *)ccv {
    if (!_ccv) {
        _ccv = [[CourseConfigView alloc] init];
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

@end
