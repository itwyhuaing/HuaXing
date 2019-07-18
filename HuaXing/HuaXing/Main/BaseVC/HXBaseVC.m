//
//  HXBaseVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXBaseVC.h"

@interface HXBaseVC ()

@end

@implementation HXBaseVC

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
         _canGestureBack = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![self setPropertySafe]) {
        return;
    }
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#3FA2FF"]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#3FA2FF"];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 原生返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        [self customNavBackItem];
    }
}

- (void)customNavBackItem{
    UIBarButtonItem *customBackItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(basePopVC)];
    self.navigationItem.leftBarButtonItem = customBackItem;
}

- (void)basePopVC {
    [self.navigationController popViewControllerAnimated:FALSE];
}

- (void)dealloc {
    NSLog(@"%@销毁",NSStringFromClass(self.class));
}


/**
 属性安全设值
 如果控制器还没有添加到父控制器上，则值暂且保留，到viewWillAppear时生效。
 否则，立即生效。
 此方法需在调用处末尾添加
 */
- (BOOL)setPropertySafe {
    if (!self.parentViewController) {
        //父控制器不存在，则当前控制器还处于悬空状态
        return NO;
    }
    if ([NSStringFromClass(self.parentViewController.class) isEqualToString:@"UIPageViewController"] ||
        [NSStringFromClass(self.parentViewController.class) isEqualToString:@"TYPagerController"]) {
        //当父控制器为UIPageViewController、TYPagerController等控制器时，则当前子控制器无需处理导航
        return NO;
    }
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 右滑手势
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationController.interactivePopGestureRecognizer.enabled = self.canGestureBack;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@" gestureRecognizerShouldBegin : %@ \n %@",gestureRecognizer,[gestureRecognizer class]);
    BOOL rlt = FALSE;
    if (self.canGestureBack) {
        // 手势
        if(gestureRecognizer == self.navigationController.interactivePopGestureRecognizer){
            // 控制器堆栈 -- 判断加强：若栈顶不为自己，则不处理
            if(self.navigationController.viewControllers.count >= 2) {
                rlt = TRUE;
            }
        }
    }
    return rlt;
}


@end
