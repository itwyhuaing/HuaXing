//
//  AddNoteView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNoteTimeCell.h"

NS_ASSUME_NONNULL_BEGIN

@class AddNoteView;
@protocol AddNoteViewDelegate <NSObject>
@optional
- (void)addNoteView:(AddNoteView *)addV them:(NSString *)them;

- (void)addNoteView:(AddNoteView *)addV detail:(NSString *)detail;

- (void)addNoteView:(AddNoteView *)addV didSelectedTimeAtIndexPath:(NSIndexPath *)idxPath;

@end

@interface AddNoteView : UIView

@property (nonatomic,strong) CommonCellTypeModel *model;

@property (nonatomic,weak) id <AddNoteViewDelegate> delegate;

// 外部可以主动传递已经输入的内容
- (void)handleWithThem:(NSString *)them detail:(NSString *)detail;

// 结束编辑态
- (void)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
