//
//  AddCourseView.h
//  HuaXing
//
//  Created by hxwyh on 2019/8/2.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCourseInputTypeModel;

NS_ASSUME_NONNULL_BEGIN

@class AddCourseView;
@protocol AddCourseViewDelegate <NSObject>
@optional
- (void)addCourseView:(AddCourseView *)addV didSelectedAtIndexpath:(NSIndexPath *)idx inputCnt:(NSString *)cnt;

- (void)addCourseView:(AddCourseView *)addV didClickEvent:(UIButton *)btn;

@end

@interface AddCourseView : UIView

@property (nonatomic,strong) NSArray<AddCourseInputTypeModel *> *ds;

@property (nonatomic,weak) id <AddCourseViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
