//
//  CourseConfigVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseConfigVC.h"
#import "HXDatePickView.h"

@interface CourseConfigVC ()

@property (nonatomic,strong) HXDatePickView *datePkv;
@property (nonatomic,strong) HXDatePickView *timePkv;


@end

@implementation CourseConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDatePickView];
}

- (void)addDatePickView {
    [self.datePkv showOnSView:self.view];
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


@end
