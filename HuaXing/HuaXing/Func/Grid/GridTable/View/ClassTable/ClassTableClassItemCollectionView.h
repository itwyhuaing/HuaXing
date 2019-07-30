//
//  ClassTableClassItemCollectionView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/7/30.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClassTableClassItemCollectionViewSelectedBlock)(NSIndexPath *idx);
@interface ClassTableClassItemCollectionView : UIView

@property (nonatomic,copy)          ClassTableClassItemCollectionViewSelectedBlock  selectedBlock;

@end

NS_ASSUME_NONNULL_END
