//
//  HXNoteEditVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXNoteEditVC.h"
#import "AddNoteView.h"
#import "HXDatePickView.h"

@interface HXNoteEditVC ()<AddNoteViewDelegate>

@property (nonatomic,strong) AddNoteView *adv;

// 时间选择器
@property (nonatomic,strong) HXDatePickView     *timePkv;

@end

@implementation HXNoteEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.adv];
    self.navigationItem.title = @"添加待办事项";
    [self generateDataSource];
}

#pragma mark ------ AddNoteViewDelegate

-(void)addNoteView:(AddNoteView *)addV inputCnt:(NSString *)cnt {
    NSLog(@"\n 事项名称 : %@ \n",cnt);
}

-(void)addNoteView:(AddNoteView *)addV didSelectedTimeAtIndexPath:(NSIndexPath *)idxPath {
    [self.timePkv showOnSView:self.view];
}


#pragma mark ------ other

- (void)generateDataSource {
    
    NSMutableArray *data = [NSMutableArray new];
    InputCellTypeModel *f = [InputCellTypeModel new];
    f.leftIconName = @"note_name";
    f.them = @"事项名称";
    f.placeHolder = @"请输入事项名称";
    
    CommonCellTypeModel *m = [CommonCellTypeModel new];
    m.leftIconName = @"note_start_time";
    m.them = @"开始时间";
    m.detail = @"点击设置时间";
    m.rightIconName = @"common_arrow";
    
    [data addObject:f];
    [data addObject:m];
    
    self.adv.ds = data;
}

-(AddNoteView *)adv {
    if (!_adv) {
        CGRect rect = self.view.frame;
        rect.origin = CGPointZero;
        _adv = [[AddNoteView alloc] initWithFrame:rect];
        _adv.delegate = (id)self;
    }
    return _adv;
}

-(HXDatePickView *)timePkv {
    if (!_timePkv) {
        _timePkv = [[HXDatePickView alloc] initWithViewType:HXDatePickViewTimeType];
    }
    return _timePkv;
}


@end
