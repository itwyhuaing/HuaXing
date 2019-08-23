//
//  HXNoteEditVC.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXBaseVC.h"
@class TodayNoteModel;

NS_ASSUME_NONNULL_BEGIN
@class HXNoteEditVC;
@protocol HXNoteEditVCDelegate <NSObject>
@optional
- (void)hxNoteEditVC:(HXNoteEditVC *)vc popWithModel:(TodayNoteModel *)model;

@end


@interface HXNoteEditVC : HXBaseVC

@property (nonatomic,weak) id <HXNoteEditVCDelegate> delegate;

// 修改场景中需要携带模型数据源
@property (nonatomic,strong) TodayNoteModel *carriedNoteModel;

@end

NS_ASSUME_NONNULL_END
