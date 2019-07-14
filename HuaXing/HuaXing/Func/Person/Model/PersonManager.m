//
//  PersonManager.m
//  HuaXing
//
//  Created by wangyinghua on 2019/7/14.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "PersonManager.h"
#import "PersonDataModel.h"

@implementation PersonManager

- (id)generateLocalData {
    NSArray *thems = @[@[@"使用帮助",@"支持小主"],
                       @[@"反馈",@"分享",@"评价"],
                       @[@"缓存",@"关于"]];
    NSArray *details = @[@[@"使用帮助",@"支持小主"],
                         @[@"反馈",@"分享",@"评价"],
                         @[@"缓存",@"关于"]];
    NSArray *icons = @[@[@"personal_arrow",@"personal_arrow"],
                         @[@"personal_arrow",@"personal_arrow",@"personal_arrow"],
                         @[@"personal_arrow",@"personal_arrow"]];
    NSMutableArray *tmp = [NSMutableArray new];
    for (NSInteger i = 0; i < thems.count; i ++) {
        NSMutableArray *items = [NSMutableArray new];
        NSArray *item_thems = thems[i];
        for (NSInteger cou = 0; cou < item_thems.count; cou ++) {
            ItemDataModel *f = [ItemDataModel new];
            f.themTxt = item_thems[cou];
            f.detailTxt = details[i][cou];
            f.rightIConName = icons[i][cou];
            [items addObject:f];
        }
        GroupDataModel *g = [GroupDataModel new];
        g.items = items;
        [tmp addObject:g];
    }
    PersonDataModel *p = [PersonDataModel new];
    p.data = tmp;
    return p;
}

@end
