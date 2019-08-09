//
//  AboutVC.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/8.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()

@end

@implementation AboutVC

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    NSBundle *mainBudle = [NSBundle mainBundle];
    NSString *filePath  = [mainBudle pathForResource:@"abouthx" ofType:@"html"];
    self.filePath = filePath;
}

@end
