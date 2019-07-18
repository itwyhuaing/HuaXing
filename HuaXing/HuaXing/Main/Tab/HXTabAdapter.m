//
//  HXTabAdapter.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXTabAdapter.h"
#import "HXNavigationVC.h"
#import "CourseGridVC.h"
#import "PersonVC.h"

@interface HXTabAdapter ()

@property (nonatomic,strong) NSMutableArray *vcs;
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation HXTabAdapter

+(instancetype)defaultInstance {
    static HXTabAdapter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [HXTabAdapter new];
    });
    return instance;
}

-(CYLTabBarController *)tabBarController {
    CYLTabBarController *tabController = [[CYLTabBarController alloc] initWithViewControllers:self.vcs tabBarItemsAttributes:self.items];
    [self customizeInterface];
    return tabController;
}

- (void)customizeInterface {
    UIFont *unSelectFont = [UIAdapter font10];
    UIColor *unSelectColor = [UIAdapter lightBlack];
    UIFont *selectFont = [UIAdapter font10];
    UIColor *selectColor = [UIAdapter mainBlue];
    
    NSMutableDictionary *attributDicNor = [NSMutableDictionary dictionary];
    [attributDicNor setValue:unSelectFont forKey:NSFontAttributeName];
    [attributDicNor setValue:unSelectColor forKey:NSForegroundColorAttributeName];
    
    NSMutableDictionary *attributDicSelect = [NSMutableDictionary dictionary];
    [attributDicSelect setValue:selectFont forKey:NSFontAttributeName];
    [attributDicSelect setValue:selectColor forKey:NSForegroundColorAttributeName];
    
    UITabBarItem *tabBar = [UITabBarItem appearance];
    //[tabBar setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    //    [tabBar setTitleTextAttributes:attributDicNor forState:UIControlStateNormal];
    //    [tabBar setTitleTextAttributes:attributDicSelect forState:UIControlStateSelected];
}

#pragma mark --- lazy load

-(NSMutableArray *)vcs {
    if (!_vcs) {
        _vcs = [NSMutableArray new];
        HXNavigationVC *firstNav = [[HXNavigationVC alloc] initWithRootViewController:[CourseGridVC new]];
        HXNavigationVC *fourthNav = [[HXNavigationVC alloc] initWithRootViewController:[PersonVC new]];
        [_vcs addObject:firstNav];
        [_vcs addObject:fourthNav];
    }
    return _vcs;
}

-(NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray new];
        NSDictionary *dic1 = @{
                               CYLTabBarItemTitle:@"首页",
                               CYLTabBarItemImage:@"tab_grid_normal",
                               CYLTabBarItemSelectedImage:@"tab_grid_pressed"
                               };
        
        NSDictionary *dic4 = @{
                               CYLTabBarItemTitle:@"我的",
                               CYLTabBarItemImage:@"tab_my_normal",
                               CYLTabBarItemSelectedImage:@"tab_my_pressed"
                               };
        [_items addObjectsFromArray:@[dic1,dic4]];
    }
    return _items;
}

@end
