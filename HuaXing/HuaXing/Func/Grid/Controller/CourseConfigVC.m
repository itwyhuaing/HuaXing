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

//
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

- (void)addDatePickView {
    [self.datePkv showOnSView:self.view];
}

- (void)addTimePickView {
    [self.timePkv showOnSView:self.view];
}

#pragma mark ------ CourseConfigViewDelegate

-(void)courseConfigView:(CourseConfigView *)cv headerEventLocation:(NSInteger)location {
    // 展示选择器
    [self.courseItemsPkv showOnSView:self.view];
    
    // 更新头部
    HXWeakSelf
    self.courseItemsPkv.pkvCompletion = ^(NSString * _Nonnull pkvResult) {
        NSLog(@" \n 测试数据 : %@ \n ",pkvResult);
        NSString *timePart = location == 0 ? @"上午" : @"下午";
        if ([pkvResult integerValue] == 0) {
            [weakSelf.ccv updateHeaderViewWithThem:[NSString stringWithFormat:@"%@几节课 ？",timePart] tipMessage:@"点击选择" section:location];
        }else{
            [weakSelf.ccv updateHeaderViewWithThem:timePart tipMessage:[NSString stringWithFormat:@"%@节课",pkvResult] section:location];
        }
        [weakSelf.ccv updateTableWithCourseItems:pkvResult section:location];
    };
}

-(void)courseConfigView:(CourseConfigView *)cv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.timePkv showOnSView:self.view];
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
