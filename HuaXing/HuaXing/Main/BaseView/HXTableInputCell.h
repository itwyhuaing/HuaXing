//
//  HXTableInputCell.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputCellTypeModel : NSObject

@property (nonatomic,copy) NSString *leftIconName;

@property (nonatomic,copy) NSString *them;

@property (nonatomic,copy) NSString *placeHolder;

@end


typedef void(^InputCellEndInputBlock)(NSString *rlt);
@interface HXTableInputCell : UITableViewCell

@property (nonatomic,strong) InputCellTypeModel *model;

@property (nonatomic,copy) InputCellEndInputBlock endInputBlock;

+ (CGFloat)cellHeight;

- (void)endEdit;

@end

NS_ASSUME_NONNULL_END
