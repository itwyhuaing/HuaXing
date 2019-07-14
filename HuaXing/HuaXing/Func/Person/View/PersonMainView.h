//
//  PersonMainView.h
//  HuaXing
//
//  Created by wangyinghua on 2019/7/14.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDataModel.h"

@class PersonMainView;
@protocol PersonMainViewDelegate <NSObject>
@optional
- (void)personMainView:(PersonMainView *)pv didSelectedAtIndexPath:(NSIndexPath *)idx;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PersonMainView : UIView

@property (nonatomic,strong,readonly) UITableView *listTable;

@property (nonatomic,strong) PersonDataModel *pm;

@property (nonatomic,weak) id <PersonMainViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
