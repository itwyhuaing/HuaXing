//
//  PersonVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PersonVC.h"
#import "PersonManager.h"
#import "PersonMainView.h"

@interface PersonVC ()<PersonMainViewDelegate>

@property (nonatomic,strong)    PersonManager       *manager;
@property (nonatomic,strong)    PersonMainView      *pv;

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubV];
    self.pv.pm = [self.manager generateLocalData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = FALSE;
    self.navigationItem.title = @"我的";
}

- (void)addSubV {
    [self.view addSubview:self.pv];
    self.pv.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark ------ PersonMainViewDelegate

-(void)personMainView:(PersonMainView *)pv didSelectedAtIndexPath:(NSIndexPath *)idx {
    NSLog(@" \n ====== \n ");
}

#pragma mark ------ lazy load

-(PersonManager *)manager {
    if (!_manager) {
        _manager = [[PersonManager alloc] init];
    }
    return _manager;
}

-(PersonMainView *)pv {
    if (!_pv) {
        _pv = [[PersonMainView alloc] init];
        _pv.delegate = (id)self;
    }
    return _pv;
}

@end
