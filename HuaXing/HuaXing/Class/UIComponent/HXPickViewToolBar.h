//
//  HXPickViewToolBar.h
//  HuaXing
//
//  Created by wangyinghua on 2019/7/19.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBUuttonCancelTag           100
#define kBUuttonConfirmTag          101

NS_ASSUME_NONNULL_BEGIN

typedef void(^HXPickViewToolBarEventBlock)(NSInteger location);
@interface HXPickViewToolBar : UIView

@property (nonatomic,copy)  HXPickViewToolBarEventBlock eventBlock;

- (void)updateThem:(NSString *)them;

@end

NS_ASSUME_NONNULL_END
