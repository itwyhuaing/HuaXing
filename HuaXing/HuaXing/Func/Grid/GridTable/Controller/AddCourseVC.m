//
//  AddCourseVC.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/1.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddCourseVC.h"
#import "AddCourseView.h"
#import "AddCourseModel.h"
#import "ClassItemDataModel.h"

@interface AddCourseVC () <AddCourseViewDelegate>

@property (nonatomic,strong) AddCourseView *acv;

@property (nonatomic,strong) CourseItemModel *itemData;

@end

@implementation AddCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.acv];
    self.navigationItem.title = @"添加课程";
    [self generateDataSource];
}

- (void)generateDataSource {
    NSArray *thems = @[@"课程名称",@"授课老师",@"授课地点"];
    NSArray *holders = @[@"请输入课程名称",@"请输入授课老师",@"请输入授课地点"];
    NSMutableArray *data = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 3; cou ++) {
        AddCourseInputTypeModel *f = [AddCourseInputTypeModel new];
        f.leftIconName = @"stress_mark";
        f.them = thems[cou];
        f.placeHolder = holders[cou];
        [data addObject:f];
    }
    self.acv.ds = data;
}

-(void)addCourseView:(AddCourseView *)addV didSelectedAtIndexpath:(NSIndexPath *)idx inputCnt:(NSString *)cnt {
    NSLog(@"\n %ld - %@ \n",idx.row,cnt);
    if (idx.row == 0) {
        self.itemData.courseName = cnt;
    }else if (idx.row == 1){
        self.itemData.teacher = cnt;
    }else if (idx.row == 2){
        self.itemData.location = cnt;
    }
}

-(void)addCourseView:(AddCourseView *)addV didClickEvent:(UIButton *)btn {
    NSLog(@" === ");
    [self.acv resignFirstResponder];
    if (self.itemData.courseName && self.itemData.teacher && self.itemData.location) { // 三者必须全部输入
        if (_delegate && [_delegate respondsToSelector:@selector(addCourseVC:didComposedModel:)]) {
            [_delegate addCourseVC:self didComposedModel:self.itemData];
        }
        [self.navigationController popViewControllerAnimated:FALSE];
    }else { // 有一个为输入
        NSLog(@" === ");
        UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"" message:@"未设置任何信息，真的要离开吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"真的要走了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:FALSE];
        }];
        [altVC addAction:cancelAction];
        [altVC addAction:confirmAction];
        [self presentViewController:altVC animated:FALSE completion:nil];
    }
}

-(AddCourseView *)acv {
    if (!_acv) {
        CGRect rect = self.view.frame;
        rect.origin = CGPointZero;
        _acv = [[AddCourseView alloc] initWithFrame:rect];
        _acv.delegate = (id)self;
    }
    return _acv;
}

-(CourseItemModel *)itemData {
    if (!_itemData) {
        _itemData = [CourseItemModel new];
    }
    return _itemData;
}

@end
