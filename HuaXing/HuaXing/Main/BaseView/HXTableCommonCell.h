//
//  HXTableCommonCell.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonCellTypeModel : NSObject

@property (nonatomic,copy) NSString *leftIconName;

@property (nonatomic,copy) NSString *them;

@property (nonatomic,copy) NSString *detail;

@property (nonatomic,copy) NSString *rightIconName;

@end


@interface HXTableCommonCell : UITableViewCell

@property (nonatomic,strong) CommonCellTypeModel *model;

@end

NS_ASSUME_NONNULL_END
