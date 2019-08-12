//
//  CourseGridVC.m
//  HuaXing
//
//  Created by hxwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "CourseGridVC.h"
#import "CourseConfigVC.h"
#import "TestVC.h"

@interface CourseGridVC ()

@end

@implementation CourseGridVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //CourseConfigVC *vc = [CourseConfigVC new];
    TestVC *vc = [TestVC new];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
