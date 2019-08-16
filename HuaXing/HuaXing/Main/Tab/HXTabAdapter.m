//
//  HXTabAdapter.m
//  HuaXing
//
//  Created by hxwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXTabAdapter.h"
#import "HXNavigationVC.h"
#import "TodayVC.h"
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
    UIColor *unSelectColor = [UIAdapter lightTintBlack];
    UIFont *selectFont = [UIAdapter font10];
    UIColor *selectColor = [UIAdapter mainBlue];
    
    NSMutableDictionary *attributDicNor = [NSMutableDictionary dictionary];
    [attributDicNor setValue:unSelectFont forKey:NSFontAttributeName];
    [attributDicNor setValue:unSelectColor forKey:NSForegroundColorAttributeName];
    
    NSMutableDictionary *attributDicSelect = [NSMutableDictionary dictionary];
    [attributDicSelect setValue:selectFont forKey:NSFontAttributeName];
    [attributDicSelect setValue:selectColor forKey:NSForegroundColorAttributeName];
    
    //UITabBarItem *tabBar = [UITabBarItem appearance];
    //[tabBar setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    //    [tabBar setTitleTextAttributes:attributDicNor forState:UIControlStateNormal];
    //    [tabBar setTitleTextAttributes:attributDicSelect forState:UIControlStateSelected];
}

#pragma mark --- lazy load

-(NSMutableArray *)vcs {
    if (!_vcs) {
        _vcs = [NSMutableArray new];
        HXNavigationVC *todayNav = [[HXNavigationVC alloc] initWithRootViewController:[TodayVC new]];
        HXNavigationVC *gridNav = [[HXNavigationVC alloc] initWithRootViewController:[CourseGridVC new]];
        HXNavigationVC *personNav = [[HXNavigationVC alloc] initWithRootViewController:[PersonVC new]];
        [_vcs addObjectsFromArray:@[todayNav,gridNav,personNav]];
    }
    return _vcs;
}

-(NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray new];
        NSDictionary *dic1 = @{
                               CYLTabBarItemTitle:@"今日",
                               CYLTabBarItemImage:@"tab_sun_normal",
                               CYLTabBarItemSelectedImage:@"tab_sun_press"
                               };
        NSDictionary *dic2 = @{
                               CYLTabBarItemTitle:@"格子",
                               CYLTabBarItemImage:@"tab_grid_normal",
                               CYLTabBarItemSelectedImage:@"tab_grid_pressed"
                               };
        
        NSDictionary *dic3 = @{
                               CYLTabBarItemTitle:@"我的",
                               CYLTabBarItemImage:@"tab_my_normal",
                               CYLTabBarItemSelectedImage:@"tab_my_pressed"
                               };
        [_items addObjectsFromArray:@[dic1,dic2,dic3]];
    }
    return _items;
}

@end
