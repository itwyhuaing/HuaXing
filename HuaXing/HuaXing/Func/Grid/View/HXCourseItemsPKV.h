//
//  HXCourseItemsPKV.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HXCourseItemsPKVCompletion)(NSString *pkvResult);

@interface HXCourseItemsPKV : UIView

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,copy) HXCourseItemsPKVCompletion pkvCompletion;

- (void)showOnSView:(UIView *)sv;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
