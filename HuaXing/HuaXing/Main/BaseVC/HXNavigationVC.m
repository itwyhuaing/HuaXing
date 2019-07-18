//
//  HXNavigationVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXNavigationVC.h"

@interface HXNavigationVC ()

@end

@implementation HXNavigationVC

- (instancetype)init {
    //自定义导航bar用
    self = [super initWithNavigationBarClass:[UINavigationBar class] toolbarClass:nil];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    //自定义导航bar用
    self = [super initWithNavigationBarClass:[UINavigationBar class] toolbarClass:nil];
    if (self) {
        self.viewControllers = @[rootViewController];
    }
    return self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
