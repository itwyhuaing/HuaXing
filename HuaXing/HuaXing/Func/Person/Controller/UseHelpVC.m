//
//  UseHelpVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/8.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "UseHelpVC.h"

@implementation UseHelpVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助文档";
    NSBundle *mainBudle = [NSBundle mainBundle];
    NSString *filePath  = [mainBudle pathForResource:@"help" ofType:@"gif"];
    self.filePath = filePath;
}

@end
