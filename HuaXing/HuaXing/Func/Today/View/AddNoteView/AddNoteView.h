//
//  AddNoteView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNoteNameCell.h"
#import "AddNoteTimeCell.h"

NS_ASSUME_NONNULL_BEGIN

@class AddNoteView;
@protocol AddNoteViewDelegate <NSObject>
@optional
- (void)addNoteView:(AddNoteView *)addV inputCnt:(NSString *)cnt;

- (void)addNoteView:(AddNoteView *)addV didSelectedTimeAtIndexPath:(NSIndexPath *)idxPath;

@end
@interface AddNoteView : UIView

@property (nonatomic,strong) NSArray *ds;

@property (nonatomic,weak) id <AddNoteViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
