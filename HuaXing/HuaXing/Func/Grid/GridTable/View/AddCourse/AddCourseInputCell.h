//
//  AddCourseInputCell.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/2.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddCourseInputCellEndInputBlock)(NSString *rlt);
@interface AddCourseInputCell : UITableViewCell

@property (nonatomic,copy) NSString *txt;

@property (nonatomic,copy) AddCourseInputCellEndInputBlock endInputBlock;

- (void)endEdit;

@end

NS_ASSUME_NONNULL_END
