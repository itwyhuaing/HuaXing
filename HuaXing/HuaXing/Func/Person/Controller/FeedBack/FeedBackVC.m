//
//  FeedBackVC.m
//  HuaXing
//
//  Created by hxwyh on 2019/8/8.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "FeedBackVC.h"
#import "IdeaBackMainView.h"

@interface FeedBackVC ()

@property (nonatomic, strong) IdeaBackMainView *mainView;

@end

@implementation FeedBackVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"反馈意见";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)basePopVC {
    if ([self.mainView.describeTextView isFirstResponder]) {
        [self.mainView.describeTextView resignFirstResponder];
    }
    if ([self.mainView.describeTextView.text length] > 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:[self getAlertTitleAttributedString] forKey:@"attributedMessage"];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (![weakSelf.mainView.describeTextView isFirstResponder]) {
                [weakSelf.mainView.describeTextView becomeFirstResponder];
            }
        }];
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:doneAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSMutableAttributedString *)getAlertTitleAttributedString {
    NSString *sourceString = @"是否放弃编辑";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:sourceString];
    NSRange targetRang = [sourceString rangeOfString:sourceString];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:targetRang];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:targetRang];
    return attrString;
}

- (IdeaBackMainView *)mainView {
    if (_mainView == nil) {
        _mainView = [[IdeaBackMainView alloc]initWithFrame:self.view.bounds superController:self];
    }
    return _mainView;
}

@end
