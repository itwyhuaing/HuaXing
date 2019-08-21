//
//  HXNoteEditVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXNoteEditVC.h"
#import "TodayNoteModel.h"
#import "AddNoteView.h"
#import "HXDatePickView.h"

@interface HXNoteEditVC ()<AddNoteViewDelegate>

// UI
@property (nonatomic,strong) AddNoteView *adv;

// 时间选择器
@property (nonatomic,strong) HXDatePickView     *timePkv;

// 输入与选择结果
@property (nonatomic,strong) TodayNoteModel    *inputNoteModel;

@end

@implementation HXNoteEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.adv];
    self.navigationItem.title = @"添加待办事项";
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNav];
}

- (void)setupNav {
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(eventCancel)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(eventComplete)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark ------ target

- (void)eventCancel {
    [self.navigationController popViewControllerAnimated:TRUE];
}


- (void)eventComplete {
    [self.adv resignFirstResponder];
    if (self.inputNoteModel.briefInfo.length <= 0 && self.inputNoteModel.detailInfo.length <= 0) {
        NSLog(@"\n 数据测试 : 未完成 \n");
        return;
    }
    
    if (self.inputNoteModel.briefInfo.length <= 0 && self.inputNoteModel.detailInfo.length > 0){
        self.inputNoteModel.briefInfo = @"备忘录";
    }
    
    // 回调数据模型
    if (_delegate && [_delegate respondsToSelector:@selector(hxNoteEditVC:popWithModel:)]) {
        [_delegate hxNoteEditVC:self popWithModel:self.inputNoteModel];
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    
}


#pragma mark ------ AddNoteViewDelegate

-(void)addNoteView:(AddNoteView *)addV them:(NSString *)them {
    self.inputNoteModel.briefInfo = them;
}

-(void)addNoteView:(AddNoteView *)addV detail:(NSString *)detail {
   self.inputNoteModel.detailInfo = detail;
}

-(void)addNoteView:(AddNoteView *)addV didSelectedTimeAtIndexPath:(NSIndexPath *)idxPath {
    [self.timePkv showOnSView:self.view];
}


#pragma mark ------ setter

-(void)setModel:(TodayNoteModel *)model {
    if (model) {
        // 绑定数据
        self.inputNoteModel = model;
        // UI 填充
        [self.adv handleWithThem:model.briefInfo detail:model.detailInfo];
    }
}

#pragma mark ------ lazy load

-(AddNoteView *)adv {
    if (!_adv) {
        CGRect rect = self.view.frame;
        rect.origin = CGPointZero;
        _adv = [[AddNoteView alloc] initWithFrame:rect];
        _adv.delegate = (id)self;
        
        // cell 数据
        CommonCellTypeModel *m = [CommonCellTypeModel new];
        m.leftIconName = @"note_start_time";
        m.them = @"开始时间";
        m.detail = [[JXDateManager shareInstance] getCurrentTime];
        m.rightIconName = @"common_arrow";
        _adv.model = m;
    }
    return _adv;
}

-(HXDatePickView *)timePkv {
    if (!_timePkv) {
        _timePkv = [[HXDatePickView alloc] initWithViewType:HXDatePickViewTimeType];
        _timePkv.barThem = @"修改开始时间";
        HXWeakSelf
        _timePkv.pickCompletion = ^(NSString * _Nonnull dateResult) {
            // 刷新当前 UI
            CommonCellTypeModel *f = weakSelf.adv.model;
            f.detail = dateResult;
            weakSelf.adv.model = f;
            
            // 记录选择结果
            weakSelf.inputNoteModel.time = dateResult;
        };
    }
    return _timePkv;
}

- (TodayNoteModel *)inputNoteModel {
    if (!_inputNoteModel) {
        _inputNoteModel = [TodayNoteModel new];
        _inputNoteModel.time = [[JXDateManager shareInstance] getCurrentTime];
    }
    return _inputNoteModel;
}

@end
