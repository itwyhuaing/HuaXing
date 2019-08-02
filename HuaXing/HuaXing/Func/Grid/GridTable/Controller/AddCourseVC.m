//
//  AddCourseVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/1.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddCourseVC.h"
#import "AddCourseView.h"

@interface AddCourseVC ()

@property (nonatomic,strong) AddCourseView *acv;

@end

@implementation AddCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.acv];
}

-(AddCourseView *)acv {
    if (!_acv) {
        _acv = [[AddCourseView alloc] init];
    }
    return _acv;
}

@end
