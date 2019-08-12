//
//  PersonVC.m
//  HuaXing
//
//  Created by hxwyh on 2019/7/12.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PersonVC.h"
#import "PersonManager.h"
#import "PersonMainView.h"
#import "PersonDataModel.h"

@interface PersonVC ()<PersonMainViewDelegate>

@property (nonatomic,strong)    PersonManager       *manager;
@property (nonatomic,strong)    PersonMainView      *pv;

@property (nonatomic,copy)      NSString            *preCacheData;

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubV];
    self.pv.pm = [self.manager generateLocalData];
    self.preCacheData = @"0";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
    self.navigationItem.title = @"我的";
    [self updateTheLocalCache];
}

- (void)addSubV {
    [self.view addSubview:self.pv];
    self.pv.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

- (void)updateTheLocalCache {
    if (self.pv.pm) {
        PersonDataModel *f = self.pv.pm;
        GroupDataModel  *g = [f.data lastObject];
        ItemDataModel   *i = [g.items lastObject];
        HXWeakSelf
        [[JXFileManager defaultManager] calculateSizeAtFileFolder:JXFileFoldersSet completeBlock:^(NSString * _Nonnull info) {
            weakSelf.preCacheData = info;
            ItemDataModel   *tmp_i = i;
            tmp_i.detailTxt = info;
            NSLog(@"\n 缓存数据测试 %@ \n",info);
            [weakSelf.pv.listTable reloadData];
            
        }];
    }
}


#pragma mark ------ PersonMainViewDelegate

-(void)personMainView:(PersonMainView *)pv didSelectedAtIndexPath:(NSIndexPath *)idx {
    NSLog(@" \n ====== %@\n ",idx);
    if (idx.section == 0) {
        
        if (idx.row == 0) {
            [self handleEvent_UserHelp];
        }else if (idx.row == 1) {
            [self handleEvent_about];
        }else if (idx.row == 2) {
            
        }
        
    }else if (idx.section == 1) {
        
        if (idx.row == 0) {
            [self handleEvent_FeedBack];
        }else if (idx.row == 1) {
            [HXUtil gotoAppStoreEvaluteWithAppID:[HXInfo currentInfo].appId];
        }else if (idx.row == 2) {
            
        }else if (idx.row == 3) {
            [self handleEvent_PaySupportAuthor];
        }
        
    }else if (idx.section == 2) {
        
        if (idx.row == 0) {
            BOOL rlt = [[JXFileManager defaultManager] clearUpFileFolder:JXFileFoldersSet];
            if (rlt) {
                [[HXToast shareManager] toast:[NSString stringWithFormat:@"成功为您清理%@缓存",self.preCacheData] afterDelay:1.0 style:HXToastHudOnlyText];
                [self updateTheLocalCache];
            }
        }
        
    }
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

#pragma mark --- handle router

- (void)handleEvent_UserHelp {
    UIViewController *vc = (UIViewController *)[[NSClassFromString(@"UseHelpVC") alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)handleEvent_PaySupportAuthor {
    UIViewController *vc = (UIViewController *)[[NSClassFromString(@"PaySupportVC") alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)handleEvent_FeedBack {
    UIViewController *vc = (UIViewController *)[[NSClassFromString(@"FeedBackVC") alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)handleEvent_Share {}

- (void)handleEvent_evaluate {}

- (void)handleEvent_cache {}

- (void)handleEvent_about {
    UIViewController *vc = (UIViewController *)[[NSClassFromString(@"AboutVC") alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
